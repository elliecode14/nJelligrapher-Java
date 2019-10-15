package com.ellie.njelligrapher.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ellie.njelligrapher.models.Event;
import com.ellie.njelligrapher.models.User;
import com.ellie.njelligrapher.models.UserEvent;
import com.ellie.njelligrapher.repositories.UserEventRepo;

@Service
public class UserEventServ {
	@Autowired
	private UserEventRepo ueR;
	
	public UserEvent addUserToEvent(UserEvent uE) {
		return ueR.save(uE);
	}
	
	public void removeUserFromEvent(User u, Event e) {
		UserEvent uE= ueR.findByUserAndEvent(u, e);
		ueR.deleteById(uE.getId());
	}
}
