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
<link href="<c:url value="/static/css/bootstrap.css" />"
	rel="stylesheet" media="all">
<link href="<c:url value="/static/css/bootstrap-theme.css" />"
	rel="stylesheet">
<script src="<c:url value="/static/js/bootstrap.js" />"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/static/css/jquery.dataTables.css" />" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/dataTables.bootstrap.css" />"/> --%>
<script type="text/javascript"
	src="<c:url value="/static/js/jquery.dataTables.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/static/js/dataTables.bootstrap.js" />"></script>


<script type="text/javascript">
	var dt;
	$(function() {
		// 			dt = $('#tableData').DataTable( {
		// 			    ajax: {
		// 			    	url : '${pageContext.request.contextPath}/sampleajaxcrud/listAllProducts.html/',
		// 				    type : 'POST',
		// 				    data : function ( d ) {
		// 				        d.searchCriteria = $('#searchText').val();
		// 				    },
		// 				    dataSrc : ""
		// 			    },
		// 			    columns: [
		// 			        { "data": "productId" },
		// 		            { "data": "productName" },
		// 		            { "data": "category.categoryName" },
		// 		            { "data": "price" }
		// //	 	            { "data": "" },
		// //	 	            { "data": "" }
		// 			    ]
		// 			} );
		$.extend($.fn.dataTable.defaults, {
			paging : false,
			searching : false,
			ordering : false
		});
		$('#table_id').DataTable(
				{
					"data" : [ [ "Tiger Nixon", "System Architect" ],
							[ "Garrett Winters", "Director" ] ]
				});

		$('#table_id2').DataTable({
			"columns" : [ {
				"data" : "name"
			}, {
				"data" : "position"
			}, {
				"data" : "office"
			}, {
				"data" : "extn"
			}, {
				"data" : "start_date"
			}, {
				"data" : "salary"
			} ],
			"data" : [ {
				"name" : "Tiger Nixon",
				"position" : "System Architect",
				"salary" : "$3,120",
				"start_date" : "2011/04/25",
				"office" : "Edinburgh",
				"extn" : "5421"
			}, {
				"name" : "Garrett Winters",
				"position" : "Director",
				"salary" : "5300",
				"start_date" : "2011/07/25",
				"office" : "Edinburgh",
				"extn" : "8422"
			} ]
		});

	});
</script>
</head>
<body>
	<div class="container">
		<h2>Sample Data Tables with Spring MVC</h2>
		<h2>Data Table with data(array)</h2>
		<table id="table_id" class="display">
			<thead>
				<tr>
					<th>Name</th>
					<th>Position</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<h2>Data Table with data(object)</h2>
		<table id="table_id2" class="display">
			<thead>
				<tr>
					<th>Name</th>
					<th>Position</th>
					<th>Salary</th>
					<th>Start Date</th>
					<th>Office</th>
					<th>Extn</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<!-- 	<input id="searchText" value="ddd"/> -->
		<!-- 	<table id="tableData" class="row-border" style="width: 100%;"> -->
		<!-- 		<thead> -->
		<!-- 			<tr> -->
		<%-- 				<th><spring:message code="label.id"/> </th> --%>
		<%-- 				<th><spring:message code="product.name"/></th> --%>
		<%-- 				<th><spring:message code="category.label"/></th> --%>
		<%-- 				<th><spring:message code="product.price"/></th> --%>
		<!-- 			</tr> -->
		<!-- 		</thead> -->
		<!-- 		<tbody></tbody> -->
		<!-- 	</table> -->
	</div>
</body>
</html>