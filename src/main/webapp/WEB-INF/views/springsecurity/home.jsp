<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body><spring:message code="welcome.message"/>
	<h2>Spring Security Home</h2>
	<a href="${ pageContext.request.contextPath }/admin">Admin</a><br>
	<a href="${ pageContext.request.contextPath }/dba">DBA</a><br>
	<c:if test="${ pageContext.request.userPrincipal != null }">
		 <a href="<c:url value="/logout" />">Logout</a>
	</c:if>
</body>
</html>