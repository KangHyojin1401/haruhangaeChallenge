<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� Ż�� �Ϸ�</title>
<style>
a {
	color: black;
	display: block;
	text-decoration: none;
	background: #cccccc;
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
				<td align="center">ȸ�� Ż��</td>
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
				<td>ȸ�� Ż�� �Ϸ�Ǿ����ϴ�.</td>
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