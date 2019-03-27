<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String pagefile = request.getParameter("page");
	if (pagefile == null) {
		pagefile = "section";
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>혜연이 프로그래밍 연습</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<hr>
	<%@ include file="nav.jsp"%>
	<br><hr>
	<section id="section">
		<jsp:include page='<%=pagefile + ".jsp"%>' />
	</section>
	<hr>
	<%@ include file="footer.jsp"%>
</body>
</html>