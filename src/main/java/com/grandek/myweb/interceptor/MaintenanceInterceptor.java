/**
 *
 * @author Ekkachai.K
 * @date Sep 2, 2015
 */
package com.grandek.myweb.interceptor;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MaintenanceInterceptor extends HandlerInterceptorAdapter{
	
	private int maintenanceStartTime;
	private int maintenanceEndTime;
	private String maintenanceMapping;
	
	public void setMaintenanceMapping(String maintenanceMapping) {
		this.maintenanceMapping = maintenanceMapping;
	}

	public void setMaintenanceStartTime(int maintenanceStartTime) {
		this.maintenanceStartTime = maintenanceStartTime;
	}

	public void setMaintenanceEndTime(int maintenanceEndTime) {
		this.maintenanceEndTime = maintenanceEndTime;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
		
		if (hour >= maintenanceStartTime && hour < maintenanceEndTime) {
			//maintenance time, send to maintenance page
			System.err.println("MaintenanceInterceptor preHandle ====================> URI: "+request.getRequestURI());
			response.sendRedirect(maintenanceMapping);
			return false;
		} else {
			return true;
		}
		
	}
	
}