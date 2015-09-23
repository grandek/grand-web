<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h4 class="modal-title"><spring:message code="label.add" /> <spring:message code="product.label"/> </h4>
</div>
	 <div class="modal-body">
	  <f:form name="productForm" commandName="product" class="form-horizontal">
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
		<button type="button" class="btn btn-success submit" value="create"><spring:message code="label.save"/></button>
	</div>
	
<script>
	$(function() {
		
		$(".submit").click(function() {
			if($('[name="productForm"]').valid()){
				addProduct();
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

	function addProduct(){
		$.ajax({
	        url : '${pageContext.request.contextPath}/sampleajaxcrud/insertJson',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	        	productName:$("#productName").val()
	            ,category:{
	                "categoryId": $("#category").val()
	            }
	            ,price:$("#price").val()
	        }),
	        dataType: 'json',
	        success : function(data) {
					$("#productModal").modal("hide");
					if (data.productId != null ){
// 	        			var olddata = dt.rows().data();
// 	        			dt.clear().draw();
		        		var newrow = dt.row.add(data).draw().node();
		        		$(newrow).css( 'color', 'red' ).css({'border': '1px solid red', 'border-left': 'none', 'border-right': 'none'})
		        	    .animate( { color: 'black' } );
		        		
// 		        		dt.rows.add(olddata).draw();
					}
	        },
	        error: function (data, textStatus, jqXHR) { $('#outputajax').text(textStatus); }
	    });
	}
	
	
</script>