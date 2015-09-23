/**
 *
 * @author Ekkachai.K
 * @date Sep 3, 2015
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

import com.grandek.mydb.model.Person;
import com.grandek.mydb.service.PersonService;
import com.grandek.myweb.model.validator.PersonValidator;

@Controller
public class SampleHibernateInterceptorController {

	@Autowired
	PersonValidator personValidator;
	@Autowired
	PersonService personService;

	@ModelAttribute("person")
	public Person newPerson() {
		return new Person();
	}
	
	@ModelAttribute("personList")
	public List<Person> listPerson() {
		return personService.findAll();
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy",Locale.ENGLISH);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        
    }

	@RequestMapping(value = "sampleHibernateInterceptor", method = RequestMethod.GET)
	public String initPage() {
		return "hibernateinterceptor/sampleHibernateInterceptor";
	}

	@RequestMapping(value = "sampleHibernateInterceptor", method = RequestMethod.POST)
	public String save(@ModelAttribute("person") Person person, BindingResult errors) {
		personValidator.validate(person, errors);
		if (errors.hasErrors()) {
			return "hibernateinterceptor/sampleHibernateInterceptor";
		} else {
			personService.create(person);
		}
		return "redirect:/sampleHibernateInterceptor";
	}

	@RequestMapping(value = "sampleHibernateInterceptor/edit/{personId}", method = RequestMethod.GET)
	public String edit(@PathVariable("personId") Integer personId, Model model) {
		Person person = personService.find(personId);
		model.addAttribute("person", person);
		return "hibernateinterceptor/sampleHibernateInterceptor";
	}

	@RequestMapping(value = "sampleHibernateInterceptor/edit", method = RequestMethod.POST)
	public String edit(@ModelAttribute("person") Person person, BindingResult errors) {
		personValidator.validate(person, errors);
		if (errors.hasErrors()) {
			return "hibernateinterceptor/sampleHibernateInterceptor";
		} else {
			personService.update(person);
		}
		return "redirect:/sampleHibernateInterceptor";
	}
	
	@RequestMapping(value = "sampleHibernateInterceptor/delete/{personId}", method = RequestMethod.GET)
	public String delete(@PathVariable("personId") Integer personId, Model model) {
		Person person = personService.find(personId);
		personService.delete(person);
		return "redirect:/sampleHibernateInterceptor";
	}
}
