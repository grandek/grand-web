/**
 *
 * @author Ekkachai.K
 * @date Sep 3, 2015
 */
package com.grandek.myweb.interceptor;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.EmptyInterceptor;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;
import org.hibernate.type.Type;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

import com.grandek.mydb.model.Employee;

public class AuditInterceptor extends EmptyInterceptor {
	private static final long serialVersionUID = 1L;
	
	private static final SessionFactory sessionFactory = createSessionFactory();
	
	@Override
	public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types) {
//		try {
            for (int i = 0; i < propertyNames.length; i++) {
                if ("createdDate".equals(propertyNames[i])) {
                    state[i] = new Date();
                }
                if ("createdBy".equals(propertyNames[i])) {
                    state[i] = "Grand_C";
                }
                if ("auditFlag".equals(propertyNames[i])) {
                    state[i] = "C";
                }
            }
//        } catch (Exception ex) {
//        	ex.printStackTrace();
//        }
        return true;
	}
	
	
	@Override
	public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, Object[] previousState, String[] propertyNames, Type[] types) {
		for (int i = 0; i < propertyNames.length; i++) {
            if ("updatedDate".equals(propertyNames[i])) {
                currentState[i] = new Date();
            }
            if ("updatedBy".equals(propertyNames[i])) {
            	currentState[i] = "Grand_U";
            }
            if ("auditFlag".equals(propertyNames[i])) {
            	currentState[i] = "U";
            }
        }
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User)auth.getPrincipal();
		System.out.println("Audit onFlushDirty =================================> "+getUser(user.getUsername()));
		
        return true;
	}
	
	public String getUser(String username){
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery("from Employee");
		List<Employee> emps = query.list();
		session.getTransaction().commit();
		session.close();
		return emps.get(0).getFirstName();
	}
	
	public static SessionFactory createSessionFactory() {
	    Configuration configuration = new Configuration();
	    configuration.configure();
	    ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(
	            configuration.getProperties()). buildServiceRegistry();
	    return configuration.buildSessionFactory(serviceRegistry);
	}
	
}
