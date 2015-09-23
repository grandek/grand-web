/**
 *
 * @author Ekkachai.K
 * @date Jul 23, 2015
 */
package com.grandek.myweb.controller;

import java.io.Serializable;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@Controller
public class HelloController implements Serializable {

	@RequestMapping( value ="/hello", method = {RequestMethod.GET})
	public String helloPage(){
		return "hello";
	}
}
