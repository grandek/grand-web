/**
 *
 * @author Ekkachai.K
 * @date Sep 3, 2015
 */
package com.grandek.myweb.model.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.grandek.mydb.model.Person;

@Component
public class PersonValidator implements Validator {

    public boolean supports(Class<?> clazz) {
        return Person.class.equals(clazz);
    }

    public void validate(Object obj, Errors errors) {
        ValidationUtils.rejectIfEmpty(errors, "name", "person.required.name", "Name is required!!");

        Person p = (Person) obj;
		if ( p.getAge() != null && p.getAge()  <  0 ) {  errors.rejectValue("age", "person.required.age.positive" ,null, "Age must greater than 0!!"); } 
         else if ( p.getAge() != null && p.getAge()  >  110 ) {  errors.rejectValue("age", "person.required.age.old",null, "Age not over 110!!"); }
    }
}
