/**
 *
 * @author Ekkachai.K
 * @date Aug 9, 2015
 */
package com.grandek.myweb.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class SampleExceptionController {

	private static final Logger logger = LoggerFactory.getLogger(SampleExceptionController.class);
	@Autowired MessageSource message;
	@RequestMapping( value = "sampleexception", method = RequestMethod.GET)
	public String pageException() throws Exception{
		throw new IOException();
	}
	/** Any Exception extends java.lang.Throwable.class */
//	@ExceptionHandler({ java.lang.Throwable.class})
	public ModelAndView handleException(HttpServletRequest request, Locale locale, Exception ex) {
		 logger.error("Requested URL : "+request.getRequestURL());
		 logger.error("Exception : "+ex);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("exception", ex);
		modelAndView.addObject("url", request.getRequestURL());

		modelAndView.setViewName("errors/mvcerror");
		modelAndView.addObject("messageError",message.getMessage("default.message.error",null, locale));
		return modelAndView;
	}
}
