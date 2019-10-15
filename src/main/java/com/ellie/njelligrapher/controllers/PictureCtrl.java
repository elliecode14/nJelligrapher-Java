package com.ellie.njelligrapher.controllers;

import java.io.IOException;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.model.ObjectMetadata;
import com.ellie.njelligrapher.models.Picture;
import com.ellie.njelligrapher.models.PictureTag;
import com.ellie.njelligrapher.models.Tag;
import com.ellie.njelligrapher.s3Services.UploadFile;
import com.ellie.njelligrapher.services.PictureServ;

@Controller
public class PictureCtrl {
	
	@Autowired
	private PictureServ pS;

	@PostMapping("/test")
	public String testUpload(@RequestParam("imgUrl") MultipartFile file, @Valid @ModelAttribute("picture") Picture pic, BindingResult result, @RequestParam("tag") List<String> tag, Model model){
		
		if(result.hasErrors()) {
			return "redirect:/events";
		}
		
		else {
			System.out.println("---URL");
			UploadFile s3Uploader = new UploadFile();
			
			try {
				System.out.println();
				ObjectMetadata metaData = new ObjectMetadata();
				metaData.setContentType("image/png");
				String imgUrl = s3Uploader.Upload("eventsimg132", file.getOriginalFilename(), file.getInputStream(), metaData);
				pic.setUrl(imgUrl);
				
				Picture newPics = pS.createPicture(pic);
				tag.forEach(tagName -> {
					Tag currentTag = pS.getTagByName(tagName);
					
				if(currentTag == null) {
					Tag newTag = new Tag();
					newTag.setName(tagName.trim());
					Tag createdTag = pS.createTag(newTag);
					PictureTag pT = new PictureTag();
					pT.setPicture(newPics);
					pT.setTag(createdTag);
					pS.addTagToPic(pT);
				} else {
					PictureTag pT = new PictureTag();
					pT.setPicture(newPics);
					pT.setTag(currentTag);
					pS.addTagToPic(pT);
				}
				});
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
			
			return "redirect:/events/pictures";
		}
	}

	@GetMapping("/events/pictures")
	public String allPics(Model model) {
		List<Picture> pictures = pS.findAll();
		model.addAttribute("pictures",pictures);
		return "allPics.jsp";
	}
	
	@PostMapping("/events/search")
	public String searchTag(@RequestParam("name") String name) {
		return "redirect:/events/search/" + name;
	}
	
	@GetMapping("/events/search/{name}")
	public String getTag(@PathVariable("name") String name, Model model) {
		List<Picture> pictures = pS.searchTag(name);
		model.addAttribute("pictures", pictures);
		return "/searchList.jsp";
	}
	
	
}
