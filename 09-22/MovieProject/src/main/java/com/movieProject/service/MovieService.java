package com.movieProject.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.movieProject.dao.MovieDao;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Review;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;
@Service
public class MovieService {
	@Autowired
	private MovieDao mdao;
	public ArrayList<Movie> getRankMovList() {		
		int totalCount = 0;
		ArrayList<Movie> rankMovList = mdao.getRankMovList();		
		for(Movie mov : rankMovList) {
			totalCount += Integer.parseInt(mov.getRecount());
			String movGrade = mov.getMvinfo();	
			movGrade = movGrade.split(",")[0];
			movGrade = movGrade.substring(0, 2);
			if(movGrade.equals("전체")) {
				movGrade = "ALL";
			} else if(movGrade.equals("청소")) {
				movGrade = "18";
			}
			//System.out.println("movGrade : "+movGrade);
			mov.setMvstate(movGrade);
			
		}
		for(Movie mv : rankMovList) {
			int recount = Integer.parseInt(mv.getRecount());
			double reRate = ((double)recount/totalCount) * 100;
			//String recount_str = reRate + "";
			//mv.setRecount(recount_str.substring(0,2));
			mv.setRecount(Math.round(reRate*100)/100.0+"");
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
	public String registReserveInfo(Reserve re) {
		// 1. 예매코드 생성 ( RE00001 )
		String maxrecode = mdao.getMaxrecode(); 
		System.out.println(maxrecode);
		String recode = genCode(maxrecode);
		re.setRecode(recode);
		System.out.println(re);
		// 2. DAO - INSERT 
		int insertResult = 0;
		try {
			insertResult = mdao.insertReserve(re);			
		} catch (Exception e) {
		}
		if(insertResult > 0) {
			return recode;		
		} else {
			return null;
		}
	}
	private String genCode(String currentCode) {
		// System.out.println("genCode() 호출 : "+currentCode);
		// currentCode = MV00000 :: 앞2자리 영문, 뒤 5자리 숫자
		String strCode = currentCode.substring(0, 2);
		int numCode = Integer.parseInt(currentCode.substring(2));
		String newCode = strCode + String.format("%05d", numCode + 1);
		return newCode;
	}
	public int registReview(Review rv) {
		String maxrvcode = mdao.getMaxrvcode(); 
		System.out.println(maxrvcode);
		String rvcode = genCode(maxrvcode);
		rv.setRvcode(rvcode);
		System.out.println(rv);
		return mdao.insertReview(rv);	
	}
	public ArrayList<Review> getReList(String mvcode) {
		ArrayList<Review> reList = mdao.getReList(mvcode);
		return reList;
	}
	public int deleteReview(String rvcode) {
		
		return mdao.deleteReview(rvcode);
	}

}
