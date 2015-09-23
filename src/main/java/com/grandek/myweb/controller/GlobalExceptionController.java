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
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

//@ControllerAdvice
public class GlobalExceptionController {
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionController.class);
	@Autowired MessageSource message;
	
//	@ExceptionHandler({ java.lang.Throwable.class})
	public ModelAndView handleException(HttpServletRequest request,Locale locale, Exception ex) {
		logger.error("Requested URL : " + request.getRequestURL());
		logger.error("Exception : " + ex);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("exception", ex);
		modelAndView.addObject("url", request.getRequestURL());
		modelAndView.setViewName("errors/mvcerror");
		modelAndView.addObject("messageError",message.getMessage("default.message.error",null, locale));
		return modelAndView;
	}
	
//	@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="IOException occured")
//    @ExceptionHandler({IOException.class})
    public String handleIOException(){
        logger.error("IOException handler executed");
        //returning 404 error code
        return "errors/mvcerror";
    }
	
	//@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="Ajax error occured")
//    @ExceptionHandler({java.lang.IllegalStateException.class})
    public String handleIllegalStateException(){
        logger.error("IllegalStateException handler executed");
        //returning 404 error code
        return "errors/mvcerror";
    }
	
	
	
}
