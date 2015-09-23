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

<script type="text/javascript">
	$(function(){
		$("#searchBtn").click(function(){
			$.ajax({
		        url : '${pageContext.request.contextPath}/ajax/get'+$("#ajaxRequest").val()+'List/',
		        type: 'POST',
		        //data : "searchName="+$("#searchName").val(),
		        dataType: "json",
		        success : function(data) {
		        	$('#outputajax').text(JSON.stringify(data));
		        },
		        error: function (jqXHR,  textStatus,  error) { $('#outputajax').text(jqXHR+" : "+ textStatus+" : "+error); }
		    });
		});
		
	});
</script>
</head>
<body>
	<h2>Sample Ajax with Spring MVC</h2>
	<select id="ajaxRequest">
		<option value="Product">Product</option>
		<option value="Category">Category</option>
		<option value="Customer">Customer</option>
		<option value="Employee">Employee</option>
		<option value="Orders">Orders</option>
		<option value="OrderDetails">OrderDetails</option>
	</select>
	<button id="searchBtn" type="button" class="btn btn-sm btn-default">Test Ajax</button>
	
	<div id="outputajax"></div>
</body>
</html>