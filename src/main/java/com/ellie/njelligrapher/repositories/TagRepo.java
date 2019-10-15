package com.ellie.njelligrapher.repositories;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ellie.njelligrapher.models.Tag;

@Repository
public interface TagRepo extends CrudRepository<Tag, Long> {

	Optional<Tag> findByName(String tagName);
	
	

}