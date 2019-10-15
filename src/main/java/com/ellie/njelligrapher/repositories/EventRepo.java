package com.ellie.njelligrapher.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ellie.njelligrapher.models.Event;

@Repository
public interface EventRepo extends CrudRepository <Event, Long>{
	List<Event> findAll();
	Event findByName(String event);
	List<Event> findAllByStateOrderByDateDesc(String state);
	List<Event> findAllByStateNotContaining(String state);
}