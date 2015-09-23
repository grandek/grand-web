/**
 *
 * @author Ekkachai.K
 * @date Aug 16, 2015
 */
package com.grandek.myweb.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.grandek.mydb.model.Category;
import com.grandek.mydb.model.Product;
import com.grandek.mydb.service.CategoryService;
import com.grandek.mydb.service.ProductService;
import com.grandek.myweb.model.validator.ProductValidator;

@Controller
public class SampleCrudController {
	
	@Autowired ProductService productService;
	@Autowired CategoryService categoryService;
	@Autowired ProductValidator productValidator;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy",Locale.ENGLISH);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	@RequestMapping( value="samplecrud.html", method= {RequestMethod.GET})
	public String crudPage(){
		return "crud/sampleCrud";
	}
	
	@RequestMapping( value="create.html")
	public String create(@ModelAttribute Product product, BindingResult results){
		productValidator.validate(product, results);
		if (results.hasErrors()){
			return "crud/sampleCrud";
		}else {
			productService.create(product);
		}
		return "redirect:sampleCrud.html";
	}
	
	@RequestMapping( value="initupdate.html/{id}")
	public String initUpdate(@PathVariable Integer id, Model model){
		model.addAttribute("product",productService.find(id));
		return "crud/sampleCrud";
	}
	
	@RequestMapping( value="update.html")
	public String update(@ModelAttribute Product product, BindingResult results){
		productValidator.validate(product, results);
		if (results.hasErrors()){
			return "crud/sampleCrud";
		}else {
			productService.update(product);
		}
		return "redirect:sampleCrud.html";
	}
	
	@ModelAttribute("product")
	public Product initProduct(){
		return new Product();
	}
	
	@ModelAttribute("products")
	public List<Product> getProducts(){
		return productService.findAll();
	}
	
	@ModelAttribute("categories")
	public List<Category> getCategorys(){
		return categoryService.findAll();
	}
}
