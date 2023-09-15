package com.movieProject.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

public interface MovieDao {
	// 영화 인기 순위 조회
	ArrayList<Movie> getRankMovList();
	// 영화 상세정보 조회
	Movie getDetailMovie(String mvcode);
	// 예매 가능 영화정보 조회(모든 or 특정 극장에서 예매 가능)
	ArrayList<Movie> getMovieList(String selThcode);
	// 예매 가능 극장정보 조회(모든 or 특정 영화만 예매 가능)
	ArrayList<Theater> getTheaterList(String selMvcode);
	ArrayList<Schedule> getScheduleList(@Param("mvcode")String mvcode, @Param("thcode")String thcode);
	ArrayList<Schedule> getTimeList(@Param("mvcode")String mvcode, @Param("thcode")String thcode, @Param("scdate")String scdate);
	String getMaxrecode();
	int insertReserve(Reserve re);


}
