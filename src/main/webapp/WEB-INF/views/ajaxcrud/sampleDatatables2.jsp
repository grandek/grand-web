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
<link href="<c:url value="/static/css/bootstrap.css" />" rel="stylesheet" media="all">
<%-- <link href="<c:url value="/static/css/bootstrap-theme.css" />" rel="stylesheet"> --%>
<script src="<c:url value="/static/js/bootstrap.js" />"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/static/css/jquery.dataTables.css" />"/>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/dataTables.bootstrap.css" />"/> --%>
<script type="text/javascript" src="<c:url value="/static/js/jquery.dataTables.js" />"></script>
<script type="text/javascript" src="<c:url value="/static/js/dataTables.bootstrap.js" />"></script>


<script type="text/javascript">
		var dt;
		$(function(){
			
			dt = $('#tableData').DataTable( {
				"pageLength": 2,
			    ajax: {
			    	url : '${pageContext.request.contextPath}/sampleajaxcrud/listAllProducts.html/',
				    type : 'POST',
				    data : function ( d ) {
				        d.searchCriteria = $('#searchText').val();
				    },
				    dataSrc : ""
			    },
			    language: {
					url: "<c:url value="/static/i18n/${pageContext.response.locale}.json" />"
				},
			    columns: [
			        { "data": "productId" ,"className":"dt-center"},
		            { "data": "productName" },
		            { "data": "category.categoryName" },
		            { "defaultContent": "<i>Not set</i>" }
//	 	            { "data": "" },
// 	 	            { "defaultContent": "<input type='button' value='delete'>" }
			    ]
// 			    ,dom : 'lprt<"toolbar">if',
// 			    initComplete : function (){
// 			    	$("div.toolbar").html("<b>Custom tool bar! Text/images etc.</b>").css("float","left");
// 			    }
			} );
		
	});
</script>
</head>
<body>
 <div class="container">
	<h2>Sample Data Tables with Spring MVC</h2>
	
<h2>Data Table with ajax</h2>
<!-- 	<input id="searchText" value="ddd"/> -->
	<table id="tableData" class="row-border" style="width: 100%;">
		<thead>
			<tr>
				<th><spring:message code="label.id"/> </th>
				<th><spring:message code="product.name"/></th>
				<th><spring:message code="category.label"/></th>
				<th><spring:message code="product.price"/></th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	</div>
</body>
</html>