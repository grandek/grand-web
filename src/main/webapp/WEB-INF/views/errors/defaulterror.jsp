<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
</head>
<body>
	<h1>Default Handler Exception</h1>
	<a href="/myweb">BACK TO HOME</a>
	<h2>ErrorCode : ${pageContext.errorData.statusCode}</h2>
	<h4>URL : ${pageContext.errorData.requestURI}</h4>
	<h3>${pageContext.exception}</h3>	
	<c:forEach var="trace" items="${pageContext.exception.stackTrace}">
		<p>${trace}</p>
	</c:forEach>
</body>
</html>