/**
 *
 * @author Ekkachai.K
 * @date Jul 23, 2015
 */
package com.grandek.myweb.controller;

import java.io.IOException;
import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonView;
import com.grandek.mydb.model.Category;
import com.grandek.mydb.model.Customer;
import com.grandek.mydb.model.Employee;
import com.grandek.mydb.model.OrderDetails;
import com.grandek.mydb.model.Orders;
import com.grandek.mydb.model.Product;
import com.grandek.mydb.model.Views;
import com.grandek.mydb.service.CategoryService;
import com.grandek.mydb.service.CustomerService;
import com.grandek.mydb.service.EmployeeService;
import com.grandek.mydb.service.OrderDetailsService;
import com.grandek.mydb.service.OrdersService;
import com.grandek.mydb.service.ProductService;

@Controller
public class SampleAjaxController implements Serializable {
	private static final long serialVersionUID = 1L;

	@Autowired private ProductService productService;
	@Autowired private CategoryService categoryService;
	@Autowired private CustomerService customemrService;
	@Autowired private EmployeeService employeeService;
	@Autowired private OrdersService ordersService;
	@Autowired private OrderDetailsService OrderDetailsService;
	
	@RequestMapping(value="/sampleajax", method ={RequestMethod.GET})
	public String samplePage(){
		return "ajax/sampleAjax";
	}
	
	@RequestMapping( value = "sampleexception2", method = RequestMethod.GET)
	public String pageException() throws Exception{
		throw new IOException();
	}
//	@JsonView(Views.Public.class)
	@RequestMapping(value="/ajax/getProductList/", method ={RequestMethod.POST})
	public @ResponseBody List<Product> listProduct(){
		return productService.findAll();
	}
//	@JsonView(Views.Internal.class)
	@RequestMapping(value="/ajax/getCategoryList/", method ={RequestMethod.POST})
	public @ResponseBody List<Category> listCategory(){
		return categoryService.findAll();
	}
	
	@RequestMapping(value="/ajax/getCustomerList/", method ={RequestMethod.POST})
	public @ResponseBody List<Customer> listCustomer(){
		return customemrService.findAll();
	}
	
	@RequestMapping(value="/ajax/getEmployeeList/", method ={RequestMethod.POST})
	public @ResponseBody List<Employee> listEmployee(){
		return employeeService.findAll();
	}
	
	@RequestMapping(value="/ajax/getOrdersList/", method ={RequestMethod.POST})
	public @ResponseBody List<Orders> listOrders(){
		return ordersService.findAll();
	}
	
	@RequestMapping(value="/ajax/getOrderDetailsList/", method ={RequestMethod.POST})
	public @ResponseBody List<OrderDetails> listOrderDetails(){
		return OrderDetailsService.findAll();
	}
}
