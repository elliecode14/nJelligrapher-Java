package com.ellie.njelligrapher.controllers;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ellie.njelligrapher.models.Picture;
import com.ellie.njelligrapher.services.PictureServ;

@RestController
public class PictureRestCtrl {
	private final PictureServ pS;
	
	public PictureRestCtrl(PictureServ pS) {
		this.pS = pS;
	}
	
	@PostMapping("/likes/{id}")
	public int addLike(@PathVariable("id") Long picId,@RequestParam("isLiked") int isLiked) {
		Picture picture = pS.findById(picId);
		int likes = picture.getLikes();
		if(likes >= 100) {
			return picture.getLikes();
		}else {
			likes+=isLiked;
			picture.setLikes(likes);
			pS.createPicture(picture);
			return picture.getLikes();
		}
	}
}
