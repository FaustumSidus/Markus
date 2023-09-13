package com.movieProject.dto;

import lombok.Data;

@Data
public class Movie {
	private String mvcode; 			//코드
	private String mvtitle;			//제목
	private String mvdirector;		//감독
	private String mvactors;		//배우
	private String mvgenre;			//장르
	private String mvinfo;			//기본정보
	private String mvopen;			//개봉일
	private String mvposter;		//포스터
	private String mvstate;			//상태	
}
