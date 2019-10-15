package com.ellie.njelligrapher.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ellie.njelligrapher.models.User;
import com.ellie.njelligrapher.services.UserServ;
import com.ellie.njelligrapher.validator.UserValidator;

@Controller
public class UserCtrl {

	@Autowired
	private UserServ uS;
	
	@Autowired
	private UserValidator uV;
	
	@GetMapping("/")
	public String registerForm(@ModelAttribute("user") User user) {
		return "loginReg.jsp";
	}
	
    @PostMapping("/")
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
        // if result has errors, return the registration page (don't worry about validations just now)
        // else, save the user in the database, save the user id in session, and redirect them to the /home route
    		uV.validate(user, result);
    		if(result.hasErrors()) {
    			return "loginReg.jsp";
    		} else {
    			User u = uS.registerUser(user);
    			session.setAttribute("userId", u.getId());
    			return "redirect:/events";
    		}
    }
    
    @PostMapping("/login")
    public String loginUser(@ModelAttribute("user") User user, @RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, RedirectAttributes rA) {
        // if the user is authenticated, save their user id in session
        // else, add error messages and return the login page
	    	boolean isAuthenticated = uS.authenticateUser(email, password);
	    	
    		if(email.length() < 1) {
    			rA.addFlashAttribute("invalid", "Email must be given!");
	    		if(password.length() < 1) {
	    			rA.addFlashAttribute("invalid2", "Password must be filled!");
	    			return "redirect:/";
	    		 }
    		}
    		
    		if(isAuthenticated) {
    			User u = uS.findByEmail(email);
    			session.setAttribute("userId", u.getId());
    			return "redirect:/events";
    		} else {
    			model.addAttribute("invalid", "Invalid Credentials. Please try again!");
    			return "loginReg.jsp";
    		}
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
    		session.invalidate();
    		return "redirect:/";
    }
}
