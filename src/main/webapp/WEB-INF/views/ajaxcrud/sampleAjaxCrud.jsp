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
<link href="<c:url value="/static/css/bootstrap-theme.css" />" rel="stylesheet">
<script src="<c:url value="/static/js/bootstrap.js" />"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/static/css/jquery.dataTables.css" />"/>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/static/css/dataTables.bootstrap.css" />"/> --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/static/css/main.css" />"/>

<script type="text/javascript" src="<c:url value="/static/js/jquery.dataTables.js" />"></script>
<script type="text/javascript" src="<c:url value="/static/js/dataTables.bootstrap.js" />"></script>

<script src="<c:url value="/static/js/jquery.validate.js" />"></script>


<script type="text/javascript">
	var dt;
	$(function(){
		dt = $('#tableData').DataTable( {
// 			ordering : false,
//  		searching: false,
//  		paging: false,
// "bLengthChange": false,
// "bFilter": false,
			dom : '<"insertModal">rtip',
		    ajax: {
		    	url  : '${pageContext.request.contextPath}/sampleajaxcrud/listAllProducts.html/',
			    type : 'POST',
				dataSrc: ""
// 				data :function(data)
// 				     {
// 				       return data = JSON.stringify(data);
// 				     }
		    },
		    language: {
				url: "<c:url value='/static/i18n/${pageContext.response.locale}.json' />"
			},
		    columns: [
		        { data : "productId", className : "dt-head-left" },
	            { data : "productName", className : "dt-head-left" },
	            { data : "category.categoryName", className : "dt-head-left" },
	            { data : "price", className : "dt-head-left dt-body-right"},
	            { data : function(data) {
	            			return '<a data-toggle="modal" data-backdrop="static" data-keyboard="false" data-id="'+data.productId+'" data-target="#productModal"'+
	        				'class="btn btn-xs btn-warning" href="${pageContext.request.contextPath}/sampleajaxcrud/modalEdit/'+data.productId+
	        				'"><span class="glyphicon glyphicon-edit "></span> <spring:message code="label.edit"/></a>';
	            		},
	            		className : "dt-head-center"
	            },
				{ data : function(data) {
	            			return '<button type="button" class="btn btn-xs btn-danger" data-toggle="modal" data-deleteid="'+data.productId+'" data-target="#confirmDeleteModal"'+
	        				'"><span class="glyphicon glyphicon-remove "></span> <spring:message code="label.delete"/></button>';
	            		},
	            		className : "dt-head-center"
	            }
		    ],
		    columnDefs: [ {
		        "targets": [4,5],
		        "orderable": false
		      } ],
		      
			initComplete: function() {
// 			    $('div.loading').remove();
			    $("div.insertModal").html(insert).css("float","right").css("margin-right","5px");
			  }
		} );
		
		var insert = '<a data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target="#productModal" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/sampleajaxcrud/modalAdd"><span class="glyphicon glyphicon-plus has-error"></span> <spring:message code="label.add"/></a>';
		
		$('#productNameSearch').on( 'keyup', function () {
			dt.search( $(this).val() ).draw();
		} );
		
		$('#categorySearch').on( 'change', function () {
			//dt.search( this.value ).draw();
		} );
		
		$('#searchBtn').on("click",function(){
			$.ajax({
				url  : '${pageContext.request.contextPath}/sampleajaxcrud/listProductsByCriteria.html/',
		        type: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify({
		        	productName:$("#productNameSearch").val()
		            ,category:{
		                "categoryId": $("#categorySearch").val()
		            }
		        }),
		        dataType: 'json',
		        success : function(data) {
						if (data != null ){
							dt.clear().draw();
	 		        		dt.rows.add(data).draw();
						}
		        },
		        error: function (data, textStatus, jqXHR) { $('#outputajax').text(textStatus); }
		    });
		});
		
		$('#resetBtn').on("click",function(){
			dt.ajax.reload();
		});
		
		$('#productModal').on('hidden.bs.modal', function() {
		    $(this).removeData();
		});
				
		$('#confirmDeleteModal').on('show.bs.modal', function (e) {
		    var button = $(e.relatedTarget);
		    if (button != null)
		    {
		    	$(".confirm-delete").off("click").on("click",function(){
// 		    		alert("Launch Button ID='" + button.data("deleteid") + "'");
					deleteRow(button.data("deleteid"));
		    		var rowupdate = $(button).closest("tr")
		            .children('td, th')
		            .animate({ padding: 0 })
		            .wrapInner('<div />')
		            .children()
		            .slideUp(function () {
		            $(this).closest('tr').remove();
		        });
// 		    		$("#confirmDeleteModal").modal("hide");
// 		    		$(".modal-backdrop").toggle();
		    	});
		    	
		       
		    }
		});
		
		
		
		function deleteRow(id){
			var obj = $('*[data-deleteid="'+id+'"]');
			if (obj != null) {
				$.ajax({
			        url : '${pageContext.request.contextPath}/sampleajaxcrud/delete/'+id,
			        type: 'POST',
			        success : function(data) {
			        	if(data == "success"){
			        		dt.row($(obj).closest("tr")).remove().draw() ;
			        		$("#confirmDeleteModal").modal("hide");
						}
			        },
			        error: function (data, textStatus, jqXHR) { $('#outputajax').text(textStatus); }
			    });
			}
		}
// 		$("#tableData_length").css("display","none");
// 		$("#tableData_filter").css("display","none");
		
	});
</script>
</head>
<body>
	
	<div class="container">
		<h2><spring:message code="product.management.label"/></h2>
		<form id="productFormSearch"  class="form-horizontal" role="form">
		<div class="form-group">
	      <label class="control-label col-sm-2" for="productNameSearch"><spring:message code="product.label"/>:</label>
	      <div class="col-sm-10">
	        <input class="form-control input-sm" id="productNameSearch" placeholder="<spring:message code="product.label"/>"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="categorySearch"><spring:message code="category.label"/>:</label>
	      <div class="col-sm-10">          
	      	<select id="categorySearch" class="form-control input-sm">
				<option value="">--- <spring:message code="category.label"/> ---</option>
				<c:forEach var="obj" items="${ categories }">
<%-- 					<c:if test="${ obj.productCategoryId eq product.productCategory.productCategoryId }"> --%>
<%-- 						<option selected="selected" value="${obj.productCategoryId }">${ obj.productCategoryName}</option> --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${ obj.productCategoryId ne product.productCategory.productCategoryId }"> --%>
						<option value="${obj.categoryId }">${ obj.categoryName}</option>
<%-- 					</c:if> --%>
				</c:forEach>
			</select>
	      </div>
	    </div>
	    <div class="form-group">        
	      <div class="col-sm-offset-2 col-sm-10">
	        <button id="searchBtn" type="button" class="btn btn-sm btn-success">
			<span class="glyphicon glyphicon-search"></span> <spring:message code="label.search"/></button>
	        <button id="resetBtn" type="reset" class="btn btn-sm btn-warning">
	        <span class="glyphicon glyphicon-refresh"></span> <spring:message code="label.reset"/></button>
<!-- 	      	<a data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target="#productModal" -->
<%-- 									class="btn btn-sm btn-danger" href="<%=request.getContextPath()%>/sampleajaxcrud/modalAdd"> --%>
<%-- 									<span class="glyphicon glyphicon-plus has-error"></span> <spring:message code="label.add"/></a> --%>
	      </div>
	    </div>
	   </form>
	   
	   <div class="row">
		   	<div class="col-sm-12">
		   		<table id="tableData" class=" hover stripe row-border compact" style="width: 100%;">
		   		<thead>
		   			<tr>
		   				<th><spring:message code="label.id"/> </th>
		   				<th><spring:message code="product.name"/></th>
		   				<th><spring:message code="category.label"/></th>
		   				<th><spring:message code="product.price"/></th>
		   				<th class="dt-head-center" style="width: 30px;"><spring:message code="label.edit"/></th>
		   				<th class="dt-head-center" style="width: 30px;"><spring:message code="label.delete"/></th>
		   			</tr>
		   		</thead>
		   		<tbody></tbody>
		   		</table>
		   	</div>
	   </div>
	</div>
	
    
	
	<!-- Modal -->
	<div class="modal fade" id="productModal" tabindex="-1" >
	  <div class="modal-dialog"> <div class="modal-content"> </div> </div>
	</div>
		<!-- Modal Confirm Delete -->
	<div class="modal fade bs-confirm-modal" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title"><spring:message code="default.delete.confirm"/> </h4>
	      </div>
	      <div class="modal-body" style="text-align: center;">
	        <button type="button" class="btn btn-md btn-warning" data-dismiss="modal"><spring:message code="label.cancel"/></button>
	        <button type="button" class="btn btn-md btn-danger confirm-delete"><spring:message code="label.delete"/></button>
	      </div>
	    </div>
	  </div>
	</div>
	
</body>

</html>