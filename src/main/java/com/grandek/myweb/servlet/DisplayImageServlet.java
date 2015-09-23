package com.grandek.myweb.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class DisplayImageServlet extends HttpServlet {
	
	protected static Logger logger = Logger.getLogger(DisplayImageServlet.class);
	private static final long serialVersionUID = 8500706756578949263L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.displayImage(request, response);
	}

	public void displayImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		File imageFile = new File("D:/eclipse/grand/myweb/src/main/webapp/images/"+request.getParameter("fileName"));
        FileInputStream fin = new FileInputStream(imageFile);
        ServletOutputStream outStream = response.getOutputStream();
        response.setContentType("image/png");
        int i = 0;
        while (i != -1) {
            i = fin.read();
            outStream.write(i);
        }
        fin.close();
	}
	
	

}
