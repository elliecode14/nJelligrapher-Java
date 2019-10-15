package com.ellie.njelligrapher.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ellie.njelligrapher.models.User;
import com.ellie.njelligrapher.repositories.UserRepo;

@Service
public class UserServ {

	@Autowired
	private UserRepo uR;
	
	public User registerUser(User user) {
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashed);
		return uR.save(user);
	}
	
	public User findByEmail(String email) {
		return uR.findByEmail(email);
	}
	
	public User findUserById(Long id) {
		Optional<User> u = uR.findAllById(id);
		if(u.isPresent()) {
			return u.get();
		} else {
			return null;
		}
	}
	
	public boolean authenticateUser(String email, String password) {
		User user = uR.findByEmail(email);
		if(user == null) {
			return false;
		} else {
			if(BCrypt.checkpw(password, user.getPassword())) {
				return true;
			} else {
				return false;
			}
		}
	}
	
}