/**
 *
 * @author Ekkachai.K
 * @date Aug 9, 2015
 */
package com.grandek.myweb.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsMultiFormatView;

import com.grandek.mydb.model.Product;
import com.grandek.mydb.service.OrdersService;
import com.grandek.mydb.service.ProductService;

@Controller
public class SampleReportController {
	@Autowired ProductService productService;
	@Autowired private MessageSource message;
	@Autowired private ApplicationContext appContext;
	@Autowired private DataSource dataSource;
	@Autowired private OrdersService orderService;

	@Transactional
	@RequestMapping(value = "/samplereport/{reportType}", method = { RequestMethod.GET })
	public ModelAndView sampleReport(@PathVariable String reportType, Locale locale) {
		
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		
		//Create Product collection and convert to JasperReport data
		List<Product> products = productService.findAll();		
//		List<Orders> orders = orderService.findAll();
//		for (Orders order : orders) {
//		     Hibernate.initialize(order.getOrderDetails());
//		}
		JRDataSource JRdataSource = new JRBeanCollectionDataSource(products);
		parameterMap.put("datasource", JRdataSource);
		
		//Get Resource with locale
		ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);		
		parameterMap.put(JRParameter.REPORT_RESOURCE_BUNDLE, bundle);
		
		//Set Type of report
		parameterMap.put("format", reportType);

		//Create JasperReport View		
		JasperReportsMultiFormatView view = new JasperReportsMultiFormatView();
		view.setUrl("classpath:reports/sampleReport.jasper");
		view.setApplicationContext(appContext);
		ModelAndView reportview = new ModelAndView(view, parameterMap);
		System.out.print("================> "+view.getUrl());
		return reportview;
	}
	
	
	@RequestMapping(value = "/samplereport2/{reportType}", method = { RequestMethod.GET })
	public ModelAndView sampleReport2(@PathVariable String reportType, Locale locale) {
		
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		
		//Get Resource with locale
		ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);		
		parameterMap.put(JRParameter.REPORT_RESOURCE_BUNDLE, bundle);
		
		//Set Type of report
		parameterMap.put("format", reportType);

		//Create JasperReport View		
		JasperReportsMultiFormatView view = new JasperReportsMultiFormatView();
		view.setJdbcDataSource(dataSource);
		view.setUrl("classpath:reports/subReport.jasper");
		view.setApplicationContext(appContext);
		ModelAndView reportview = new ModelAndView(view, parameterMap);
		System.out.print("================> "+view.getUrl());
		return reportview;
	}


}
