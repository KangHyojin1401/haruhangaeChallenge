<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� ���� �Ϸ�</title>
<style>
a {
	color: black;
	display: block;
	text-decoration: none;
	background: #cccccc;
}

span {
	text-align: center;
}

input[type=button] {
		background-color: transparent;
		border-radius: 20px;
		padding: 5px 10px 5px 10px;
		background-color: #6a60a9;
		color: white;
		font-size: medium;
		font-size: 80%;
		border: 0px;
		box-shadow: none;
	}	
</style>
</head>
<body>
	<form action="<c:url value='/user/login' />">
		<table align="center">
			<tr>
				<td align="center">ȯ���ؿ�.</td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td><span>ȸ�� ������ �Ϸ�Ǿ����ϴ�.<br>�α��� �� ���񽺸� �̿����ּ���.<span></span></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td><br /></td>
			</tr>
			<tr>
				<td align="center"><input type="button" value="�α��� �������� �̵��ϱ�"
					onClick="submit()" /></td>
			</tr>
		</table>
	</form>
</body>
</html>