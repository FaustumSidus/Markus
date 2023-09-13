package com.movieProject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.movieProject.dao.MovieDao;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;
@Service
public class MovieService {
	@Autowired
	private MovieDao mdao;
	public ArrayList<Movie> getRankMovList() {		
		ArrayList<Movie> rankMovList = mdao.getRankMovList();
		for(Movie mov : rankMovList) {
			String movGrade = mov.getMvinfo();	
			movGrade = movGrade.split(",")[0];
			movGrade = movGrade.substring(0, 2);
			if(movGrade.equals("전체")) {
				movGrade = "ALL";
			} else if(movGrade.equals("청소")) {
				movGrade = "18";
			}
			System.out.println("movGrade : "+movGrade);
			mov.setMvstate(movGrade);
			
		}
		return rankMovList;
	}
	public Movie getDetailMovie(String mvcode) {
		Movie mov = mdao.getDetailMovie(mvcode);
		return mov;
	}
	public ArrayList<Movie> getMovieList(String selThcode) {
		ArrayList<Movie> mList = mdao.getMovieList(selThcode);
		
		for(Movie mov : mList) {
			String movGrade = mov.getMvinfo();	
			movGrade = movGrade.split(",")[0];
			movGrade = movGrade.substring(0, 2);
			if(movGrade.equals("전체")) {
				movGrade = "ALL";
			} else if(movGrade.equals("청소")) {
				movGrade = "18";
			}
			System.out.println("movGrade : "+movGrade);
			mov.setMvstate(movGrade);
			
		}
		return mList;
	}
	public ArrayList<Theater> getTheaterList(String selMvcode) {		
		ArrayList<Theater> tList = mdao.getTheaterList(selMvcode);
		return tList;
	}
	public ArrayList<Schedule> getScheduleList(String mvcode, String thcode) {
		ArrayList<Schedule> sList = mdao.getScheduleList(mvcode, thcode);
		return sList;
	}
	public ArrayList<Schedule> getTimeList(String mvcode, String thcode, String scdate) {		
		ArrayList<Schedule> timeList = mdao.getTimeList(mvcode, thcode, scdate);
		return timeList;
	}
	

}
