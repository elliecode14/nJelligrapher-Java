package com.ellie.njelligrapher.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ellie.njelligrapher.models.Event;
import com.ellie.njelligrapher.models.User;
import com.ellie.njelligrapher.models.UserEvent;

@Repository
public interface UserEventRepo extends CrudRepository <UserEvent, Long>{
	List<UserEvent> findAll();

	UserEvent deleteByEventAndUser(Event event, User user);

	UserEvent findByUserAndEvent(User u, Event e );
}
