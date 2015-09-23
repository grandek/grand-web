/**
 *
 * @author Ekkachai.K
 * @date Aug 12, 2015
 */
package com.grandek.myweb.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DisplayImageController {
	
	@RequestMapping( value="/sampledisplayimage.html", method={RequestMethod.GET})
	public String sampleDisplayImage(){
		return "displayimg/sampleDisplayImage";
	}
	
	@RequestMapping("/imageRequest/{imgName}")
	@ResponseBody
	public HttpEntity<byte[]> getPhoto(@PathVariable String imgName) throws IOException {
	    byte[] image = FileUtils.readFileToByteArray(new File("D:/eclipse/grand/myweb/src/main/webapp/images/"+ imgName + ".png"));
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.IMAGE_PNG); 
	    headers.setContentLength(image.length);
	    return new HttpEntity<byte[]>(image, headers);
	}
}
