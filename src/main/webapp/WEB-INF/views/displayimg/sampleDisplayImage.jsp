<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="<c:url value="/static/js/jquery-1.10.2.min.js" />"></script>

</head>
<body>
	<h1>Sample Display Image on Spring MVC</h1>
	<table border="1">
		<tr>
			<td><div>Load image from server root directory<br><img style="height: 200px;" src="static/images/Documentsx.png"/></div></td>
			<td><div>Load image from physical file system by DisplayImaage<br><img style="height: 200px;" src="${pageContext.request.contextPath}/DisplayImageServlet?fileName=Documentsx.png"/></div></td>
			<td><div>Load image from physical file system by mvc:resources<br><img style="height: 200px;" src="images/Documentsx.png"/></div></td>
			<td><div>Load image from physical file system by ResponseBody<br><img style="height: 200px;" src="${pageContext.request.contextPath}/imageRequest/Documentsx"/></div></td>
		</tr>
		
	</table>
	
	
</body>
</html>