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
	<h2>Sample Hibernate Interceptor with Spring MVC</h2>
	
	<c:if test="${ person.id ne null}">
		<c:set var="actionForm" value="${pageContext.request.contextPath}/sampleHibernateInterceptor/edit"/>
	</c:if>
	<c:if test="${ person.id eq null }">
		<c:set var="actionForm" value="${pageContext.request.contextPath}/sampleHibernateInterceptor"/>
	</c:if>
	
	<f:form action="${ actionForm }" commandName="person" method="post">
		<f:hidden path="id"/><f:hidden path="createdDate"/><f:hidden path="createdBy"/>
		<spring:message code="person.name"/><f:input path="name"/><f:errors path="name"/><br>
		<spring:message code="person.age"/><f:input path="age"/><f:errors path="age"/><br>
		<input type="submit" value="Submit">
	</f:form>
	
	<table>
		<thead>
			<tr>
				<th><spring:message code="label.id"/></th>
				<th><spring:message code="person.name"/></th>
				<th><spring:message code="person.age"/></th>
				<th>Created By</th>
				<th>Created Date</th>
				<th>Updated By</th>
				<th>Updated Date</th>
				<th><spring:message code="label.edit"/></th>
				<th><spring:message code="label.delete"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${personList }" var="person">
			<tr>
				<td>${ person.id }</td>
				<td>${ person.name }</td>
				<td>${ person.age }</td>
				<td>${ person.createdBy }</td>
				<td>${ person.createdDate }</td>
				<td>${ person.updatedDate }</td>
				<td>${ person.updatedBy }</td>
				<td><a href="${pageContext.request.contextPath}/sampleHibernateInterceptor/edit/${person.id}"><spring:message code="label.edit"/></a></td>
				<td><a class="del" href="${pageContext.request.contextPath}/sampleHibernateInterceptor/delete/${person.id}"><spring:message code="label.delete"/></a></td>
			
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
</body>
</html>