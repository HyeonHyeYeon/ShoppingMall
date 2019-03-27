<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- <% String pagefile= request.getParameter("file");
if(pagefile == null){
pagefile = "%> --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#middle {
	height: 200px;
	width: 500px;
	border: 1.5px solid purple;
	overflow: hidden;
	display: inline-flex;
	padding: 10px;
}

#menu {
	float: left;
	text-align: center;
	width: 80px;
	height: 190px;
}

#main {
	height: 190px;
	width: 300px;
	text-align: center;
	float: left;
	overflow: auto;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
	<div id="middle">
		<div id="menu"><%@ include file="menu.jsp"%></div>
		<div id="main"><%@ include file="main.jsp"%></div>
	</div>
</body>
</html>