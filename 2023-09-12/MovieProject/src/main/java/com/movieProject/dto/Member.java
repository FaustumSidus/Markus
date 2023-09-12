package com.movieProject.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private String mid;
	private String mpw;
	private String mname;
	private String memail;
	private String mdate;
	private MultipartFile mfile;
	private String mprofile;
	private String mstate;
}
