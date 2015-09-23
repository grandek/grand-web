/**
 *
 * @author Ekkachai.K
 * @date Aug 7, 2015
 */
package com.grandek.myweb.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class SampleUploadController {
	
	@Autowired ServletContext context;
	
	@RequestMapping( value = "sampleupload", method = RequestMethod.GET)
	public String uploadPage(){
		return "upload/sampleUpload";
	}
	
	@RequestMapping( value = "/sampleupload", method = RequestMethod.POST)
	public String upload(@RequestParam("file") MultipartFile file, Model model) throws IOException {
		model.addAttribute("fileName", "Not multipart upload!!");
		if (!file.isEmpty()) {
			// store the bytes somewhere
//			File imageFile = new File("C:/UPLOAD/"+file.getOriginalFilename());
			File imageFile = new File(context.getRealPath("/")+"/images/"+file.getOriginalFilename());
			System.out.println("========path====> "+imageFile.getPath());
			FileOutputStream fout = new FileOutputStream(imageFile);
			fout.write(file.getBytes());
			fout.close();
			model.addAttribute("fileName", "Upload file "+file.getOriginalFilename()+ " success!!!");
		}

		return "upload/sampleUpload";
	}
	
}
