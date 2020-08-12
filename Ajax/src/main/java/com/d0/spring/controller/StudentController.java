package com.d0.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/student")
public class StudentController {

	@GetMapping("/insert")
	public String join() {
		
		return "student/insert";
	}
	
	@GetMapping("/list")
	public String list() {
		
		return "student/list";
	}
	
	@GetMapping("/search")
	public String search() {
		
		return "student/search";
	}
}
