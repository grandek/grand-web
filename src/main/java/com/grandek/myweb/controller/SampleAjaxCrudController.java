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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grandek.mydb.model.Category;
import com.grandek.mydb.model.Product;
import com.grandek.mydb.service.CategoryService;
import com.grandek.mydb.service.ProductService;
import com.grandek.myweb.model.validator.ProductValidator;

@Controller
public class SampleAjaxCrudController {
	static Logger logger = LoggerFactory.getLogger(SampleAjaxCrudController.class);
	@Autowired ProductService productService;
	@Autowired CategoryService categoryService;
	@Autowired ProductValidator productValidator;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy",Locale.ENGLISH);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	@RequestMapping( value="sampleajaxcrud.html", method= {RequestMethod.GET})
	public String crudPage(){
		return "ajaxcrud/sampleAjaxCrud";
	}
	
	@RequestMapping( value="sampledatatables.html", method= {RequestMethod.GET})
	public String datatablePage(){
		return "ajaxcrud/sampleDatatables";
	}
	
	@RequestMapping( value="sampledatatables2.html", method= {RequestMethod.GET})
	public String datatablePage2(){
		return "ajaxcrud/sampleDatatables2";
	}
	
	@RequestMapping( value="sampleajaxcrud/listProductsByCriteria.html/", method= {RequestMethod.POST})
	public @ResponseBody List<Product> getProducsByCriteria(@RequestBody Product product){
		return productService.findByCriteria(product);
	}
	
	@RequestMapping( value="sampleajaxcrud/listAllProducts.html/", method= {RequestMethod.POST})
	public @ResponseBody List<Product> getProducts(String searchCriteria){
		System.out.println("==========================> "+searchCriteria);
//		return new Object(){
//			public List<Product> getData(){
				return productService.findAll();
//			}
//		};
	}
	
	
	/** Start of ajax method ==================================> */
	
	@RequestMapping(value = "sampleajaxcrud/modalAdd", method = {RequestMethod.GET,RequestMethod.POST})
    public String modalAdd(@ModelAttribute(value="product") Product product,Model model)
    {
        model.addAttribute("product", product);
        return "/ajaxcrud/add";
    }
	
	@RequestMapping(value = "/sampleajaxcrud/insertJson", method = {RequestMethod.POST})
    public @ResponseBody Product insertJson(@RequestBody Product product)
    {
		logger.info("Create Product : " + product);
		productService.create(product);
        return productService.find(product.getProductId());
    }
	
	@RequestMapping(value = "/sampleajaxcrud/modalEdit/{productId}", method = {RequestMethod.GET,RequestMethod.POST})
    public String modalEdit(@PathVariable Integer productId, Model model)
    {
        model.addAttribute("product", productService.find(productId));
        return "/ajaxcrud/edit";
    }
	
	@RequestMapping(value = "/sampleajaxcrud/updateJson", method = {RequestMethod.POST})
    public @ResponseBody Product updateJson(@RequestBody Product product)
    {
		logger.info("Update Product : " + product);
		productService.update(product);
        return productService.find(product.getProductId());
    }
	
	@RequestMapping("/sampleajaxcrud/delete/{productId}")
	public @ResponseBody String deleteProduct(@PathVariable("productId") Integer productId) {
		logger.info("deleteProduct : " + productId);
		productService.delete(productService.find(productId));
		return "success";
	}
	
	
	/** End of ajax method <==================================  */
	
	
	@RequestMapping( value="ajaxcreate")
	public @ResponseBody Product create(@RequestBody Product product, BindingResult results){
		productValidator.validate(product, results);
		if (results.hasErrors()){
//			return "crud/sampleCrud";
		}else {
			productService.create(product);
		}
		return productService.find(product.getProductId());
	}
	
	@RequestMapping( value="initupdate/{id}")
	public String initUpdate(@PathVariable Integer id, Model model){
		model.addAttribute("product",productService.find(id));
		return "crud/sampleCrud";
	}
	
	@RequestMapping( value="update")
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
	
	@ModelAttribute("categories")
	public List<Category> getCategorys(){
		return categoryService.findAll();
	}
}
