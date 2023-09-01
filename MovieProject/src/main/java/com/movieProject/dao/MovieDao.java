package com.movieProject.dao;

import java.util.ArrayList;

import com.movieProject.dto.Movie;

public interface MovieDao {

	ArrayList<Movie> getRankMovList();

	Movie getDetailMovie(String mvcode);

	ArrayList<Movie> getMovieList();

}
