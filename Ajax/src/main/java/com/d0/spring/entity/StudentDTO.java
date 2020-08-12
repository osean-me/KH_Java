package com.d0.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class StudentDTO {
	private String name;
	private int age;
	private int score;
	private String when;
}
