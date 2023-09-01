package com.movieProject.dao;

import java.util.ArrayList;

import com.movieProject.dto.Movie;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

public interface AdminDao {

	String selectMaxMvCode();

	int insertMovie(Movie mv);

	String selectMaxThCode();

	int insertTheater(Theater th);

	int insertSchedule(Schedule sc);

	ArrayList<Movie> selectMapperTest(String selthcode);

}
