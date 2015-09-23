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
<script src="<c:url value="/static/js/jquery-1.10.2.min.js" />"></script>

</head>
<body>
	<h1>Sample Upload with Spring MVC</h1>
	 <h2>Please upload a file</h2>
        <form method="post" action="${pageContext.request.contextPath}/sampleupload" enctype="multipart/form-data">
            <input type="file" name="file"/>
            <input type="submit"/>
        </form>
        <div>${ fileName }</div>
        <div><br><img style="height: 200px;" src="<c:url value="images/${ fileName }" />"/></div>
</body>
</html>