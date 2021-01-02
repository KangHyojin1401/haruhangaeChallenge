<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>위치 선택</title>
<script src="http://code.jquery.com/jquery-latest.js"
	type="text/javascript"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=3w9kmlriw5&callback=initMap&submodules=geocoder"></script>
<script type="text/javascript">
	
	var map = null;
	var addressVal = null;
	
	function initMap() {
	    map = new naver.maps.Map('map', {
	        center: new naver.maps.LatLng(37.3595704, 127.105399),
	        zoom: 10,
	        disableDoubleClickZoom: true,
	        disableDoubleTapZoom: true, 
	        logoControl: false, 
	        mapDataControl: false,
	        mapTypeControl: false,
	        maxZoom: 17
	    });
	    
	    var marker = new naver.maps.Marker({
	        position: map.center,
	        map: map
	    });
	    
	    naver.maps.Event.addListener(map, 'click', function(e) {
	    	map.setCenter(e.coord);
	    	marker.setPosition(e.coord);
	    	searchCoordinateToAddress(e.coord);
		});
	}
	
	var infoWindow = new naver.maps.InfoWindow({
		disableAnchor: true,
		backgroundColor: '#fffcf0',
		borderColor: '#6a60a9',
		borderWidth: 3
	});
	
	map.setCursor('pointer');
	
	function searchCoordinateToAddress(latlng) {
		infoWindow.close();

   	  	naver.maps.Service.reverseGeocode({
   	    	coords: latlng,
   	    	orders: [
   	    		naver.maps.Service.OrderType.ROAD_ADDR
	   	    ]
		}, function(status, response) {
		   	    if (status === naver.maps.Service.Status.ERROR) {
					if (!latlng) {
		   	        	return alert('ReverseGeocode Error, Please check latlng');
		   	      	}
		   	      	if (latlng.toString) {
		   	        	return alert('ReverseGeocode Error, latlng:' + latlng.toString());
		   	     	}
		   	      	if (latlng.x && latlng.y) {
		   	        	return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
		   	      	}
		   	      	return alert('ReverseGeocode Error, Please check latlng');
		   	    }
		
		   	    var address = response.v2.address,
		   	        htmlAddresses = [];
		
		   	    if (address.roadAddress !== '') {
		   	        htmlAddresses.push(address.roadAddress);
		   	    }
		
		   	    infoWindow.setContent([
		   	    	'<div style="padding:6px;min-width:200px;line-height:150%;font-size:85%;">',
					htmlAddresses.join('<br />'),
					'</div>'
				].join('\n'));
		   	    
		   	    addressVal = address.roadAddress;
		   	    
		   	    infoWindow.open(map, latlng.destinationPoint(0, 100));
			});
   	}
	
	function cancel(){
		self.opener = self;
		window.close();  
		self.close();  
		window.open('','_self').close(); 
	}
	
	function ok(){
		if (addressVal == '' || addressVal == null) {
			alert('정확한 장소를 클릭해주세요.');
		}
		else {
			$("#location_text", opener.document).val(addressVal);
			window.close();
		}
	}

</script>
<style type="text/css">
	.container {
		width: 90%;
		margin: auto;
	}
	
	body {
		background-color: #dedcee;
	}
	
	#btn_table {
		margin: auto;
		width: 100%;
		text-align: center;
	}
	
	input[type=button] {
		border-radius: 20px;
		padding: 5px 10px 5px 10px;
		background-color: #6a60a9;
		color: white;
		font-size: medium;
		font-size: 80%;
		border: 0px;
		box-shadow: none;
		width: 60%;
	}
	
	a input[type=button]: hover {
		background-color: #fffcf0;
		color: #6a60a9;
	}
</style>
</head>
<body>
	<div class="container">
		<div id="map" style="width:100%;height:600px;"></div>
		
		<br>
		
		<table id="btn_table">
			<tr>
				<td><input type="button" onclick="cancel()" value="취소"/></td>
				<td><input type="button" onclick="ok()" value="확인"/></td>
			</tr>
		</table>
	</div>
</body>
</html>