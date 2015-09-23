<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h4 class="modal-title"><spring:message code="label.edit" /> <spring:message code="product.label"/> </h4>
</div>
	 <div class="modal-body">
	  <f:form name="productForm" commandName="product" class="form-horizontal">
	  <f:hidden path="productId"/>
		 <div class="row form-group">
		 <spring:message code="category.label" var="categorylabel"/>
		 	<div class="col-md-3"><label class="control-label" >${categorylabel }:</label></div>
	      	<div class="col-md-9">
		      	<f:select path="category" cssClass="form-control input-sm">
					<option value="">--- ${categorylabel} ---</option>
					<c:forEach var="obj" items="${ categories }">
						<c:if test="${ obj.categoryId eq product.category.categoryId }">
							<option selected="selected" value="${obj.categoryId }">${ obj.categoryName}</option>
						</c:if>
						<c:if test="${ obj.categoryId ne product.category.categoryId }">
							<option value="${obj.categoryId }">${ obj.categoryName}</option>
						</c:if>
					</c:forEach>
				</f:select>
	      	</div>
		 </div>
		 <div class="row form-group">
		 	<spring:message code="product.name" var="namelabel"/>
		 	<div class="col-md-3"><label class="control-label" >${namelabel }:</label></div>
	      	<div class="col-md-9"><f:input id="productName" name="productName" path="productName" cssClass="form-control input-sm" placeholder="${namelabel }" />
	      	</div>
		 </div>
		 <div class="row form-group">
		 	<spring:message code="product.price" var="pricelabel"/>
		 	<div class="col-md-3"><label class="control-label" for="price">${pricelabel }:</label></div>
	      	<div class="col-md-9"><f:input path="price" cssClass="form-control input-sm" placeholder="${pricelabel }" />
	      	</div>
		 </div>
		 
		 </f:form>
      </div>

	<div class="modal-footer">
		<button type="button" class="btn btn-warning closemodal" data-dismiss="modal"><spring:message code="label.close"/></button>
		<button type="button" class="btn btn-success submit" value="create"><spring:message code="label.update"/></button>
	</div>
	
<script type="text/javascript">
	$(function() {
		
		$(".submit").click(function() {
			if($('[name="productForm"]').valid()){
					updateProduct();
			}
		});
		
		$('[name="productForm"]').validate({
		    rules : {
		        category :"required",
		        productName : "required",
	    		price : {
	    			required : true
	    		}
		    }
		});
	});
	
	function updateProduct(){
		var obj = $('*[data-id="'+$("#productId").val()+'"]');
		var rowupdate = $(obj).closest("tr");
		$.ajax({
	        url : '${pageContext.request.contextPath}/sampleajaxcrud/updateJson',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	        	productId:$("#productId").val()
	        	,productName:$("#productName").val()
	            ,category:{
	                "categoryId": $("#category").val()
	            }
	            ,price:$("#price").val()
	        }),
	        dataType: 'json',
	        success : function(data) {
	        		$("#productModal").modal("hide");
					if (data.productId != null ){
						var updaterow = dt.row(rowupdate).data(data).draw();
						$(rowupdate).css( 'color', 'blue' ).css('background-color','aliceblue')
		        	    .animate( { color: 'black' } );
					}
	        },
	        error: function (data, textStatus, jqXHR) { $('#outputajax').text(textStatus); }
	    });
	}
	
	
</script>