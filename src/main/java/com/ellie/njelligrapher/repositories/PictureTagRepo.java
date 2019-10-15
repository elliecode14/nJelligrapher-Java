package com.ellie.njelligrapher.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.ellie.njelligrapher.models.PictureTag;

public interface PictureTagRepo extends CrudRepository<PictureTag, Long>{

	List<PictureTag> findAll();

}