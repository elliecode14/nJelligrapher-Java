package com.ellie.njelligrapher.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ellie.njelligrapher.models.Picture;
import com.ellie.njelligrapher.models.PictureTag;
import com.ellie.njelligrapher.models.Tag;
import com.ellie.njelligrapher.repositories.PictureRepo;
import com.ellie.njelligrapher.repositories.PictureTagRepo;
import com.ellie.njelligrapher.repositories.TagRepo;

@Service
public class PictureServ {
	
	@Autowired
	private PictureRepo pRepo;
	
	@Autowired
	private TagRepo tR;
	
	@Autowired
	private PictureTagRepo pTR;
	
	
	//Pictures	
	public PictureServ(PictureRepo pRepo) {
		this.pRepo = pRepo;
	}
	
	public Picture createPicture(Picture p) {
		return pRepo.save(p);
	}
	
	public List<Picture> findAll(){
		return pRepo.findAll();
	}
	
	public Picture findById(Long id) {
		Optional<Picture> pic = pRepo.findById(id);
		if(pic.isPresent()) {
			return pic.get();
		}else {
			return null;
		}
	}
	
	public List<Picture> searchTag(String name){
		Optional<Tag> optionalTag = tR.findByName(name);
		if(optionalTag.isPresent()) {
			return pRepo.findByTags(optionalTag);
			
		} else {
			return null;
		}
	}
	
	//Tags
	
	public Tag createTag(Tag t) {
		return tR.save(t);
	}
	
	public Tag getTagByName(String tagName) {
		Optional<Tag> optionalTag = tR.findByName(tagName);
		if(optionalTag.isPresent()) {
			return optionalTag.get();
		} else {
			return null;
		}
	}
	
	public void addTagToPic(PictureTag pictureTag) {
		pTR.save(pictureTag);
	}
}
