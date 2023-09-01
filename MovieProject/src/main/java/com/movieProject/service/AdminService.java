package com.movieProject.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.PageLoadStrategy;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.AdminDao;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Schedule;
import com.movieProject.dto.Theater;

@Service
public class AdminService {
	@Autowired
	private AdminDao adminDao;

	public int addCgvMovie() throws IOException { // addCgvMovie() 시작
		System.out.println("addCgvMocie 호출");
		// cgv 영화 정보 수집
		// jsoup 사용
		// 무비차트 페이지 접속 >> 영화 상세 페이지 URL(19개) 수집
		//String cgvMovieUrl = "http://www.cgv.co.kr/movies/";
		String cgvMovieUrl = "http://www.cgv.co.kr/movies/?lt=1&ft=0";
		Document cgvMovieDoc = Jsoup.connect(cgvMovieUrl).get();
		Elements urlItems = cgvMovieDoc.select("div.sect-movie-chart>ol>li>div.box-contents>a");
		// System.out.println(urlItems);
		ArrayList<Movie> mvList = new ArrayList<Movie>();
		
		for (Element urlItem : urlItems) {
			String detailUrl = "http://www.cgv.co.kr" + urlItem.attr("href");
			// System.out.println(detailUrl);
			Document detailDoc = Jsoup.connect(detailUrl).get();
			Movie movie = new Movie();
			String mvtitle = detailDoc.select("div.sect-base-movie>div.box-contents>div.title>strong").text();
			movie.setMvtitle(mvtitle);
			String mvdirector = detailDoc.select("div.sect-base-movie>div.box-contents>div.spec>dl>dd:nth-child(2)")
					.text();
			movie.setMvdirector(mvdirector);
			String mvactors = detailDoc.select("div.sect-base-movie>div.box-contents>div.spec>dl>dd.on").get(0).text();
			mvactors = mvactors.replace(" , ", ",");
			movie.setMvactors(mvactors);
			String mvgenre = detailDoc.select("div.sect-base-movie>div.box-contents>div.spec>dl>dd.on").get(0)
					.nextElementSibling().text();
			mvgenre = mvgenre.replace("장르", "").replace(":", "").replace(", ", ",").trim();
			movie.setMvgenre(mvgenre);
			String mvinfo = detailDoc.select("div.sect-base-movie>div.box-contents>div.spec>dl>dd.on").get(1).text();
			mvinfo = mvinfo.replace(", ", ",");
			movie.setMvinfo(mvinfo);
			String mvopen = detailDoc.select("div.sect-base-movie>div.box-contents>div.spec>dl>dd.on").get(2).text();
			mvopen = mvopen.substring(0, 10);
			movie.setMvopen(mvopen);
			String mvposter = detailDoc.select("div.sect-base-movie>div.box-image>a>span>img").attr("src");
			movie.setMvposter(mvposter);
			mvList.add(movie);
//			System.out.println("영화제목 : "+mvtitle+'\n'+
//							   "영화감독 : "+mvdirector+'\n'+
//							   "영화배우 : "+mvactors+'\n'+
//							   "영화장르 : "+mvgenre+'\n'+
//							   "영화기본정보 : "+mvinfo+'\n'+
//							   "영화개봉일 : "+mvopen+'\n'+
//							   "영화포스터 : "+mvposter
//								);

		}
		String maxMvcode = adminDao.selectMaxMvCode();
		System.out.println("maxMvcode : " + maxMvcode);
		int insertCount = 0;
		System.out.println(mvList);
		for (Movie mv : mvList) {
			// 1. 영화코드 생성
			String mvCode = genCode(maxMvcode);
			// System.out.println(mvCode);
			mv.setMvcode(mvCode);
			// 2. MOVIES 테이블 INSERT
			try {
				int insertResult = adminDao.insertMovie(mv);
				insertCount++;
				maxMvcode = mvCode;
			} catch (Exception e) {
				continue; // 중복 영화일 경우 다음 반복
			}
			// System.out.println(mv);
		}
		// System.out.println(mvList);
		// mvList >> 영화정보 19개 수집
		// Movies 테이블 mvcode 최대값 조회

		return insertCount;

	}// addCgvMovies() 종료
		// 코드 생성 메소드 시작

	private String genCode(String currentCode) {
		// System.out.println("genCode() 호출 : "+currentCode);
		// currentCode = MV00000 :: 앞2자리 영문, 뒤 5자리 숫자
		String strCode = currentCode.substring(0, 2);
		int numCode = Integer.parseInt(currentCode.substring(2));
		String newCode = strCode + String.format("%05d", numCode + 1);
		return newCode;
	}

	private ArrayList<String> getTheaterUrls() {
		System.out.println("getTheaterUrls");
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		options.addArguments("headless");
		// options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);
		String cgvTheaterUrl = "http://www.cgv.co.kr/theaters/";
		driver.get(cgvTheaterUrl);
		List<WebElement> theaterUrls = driver.findElements(By.cssSelector("div.sect-city>ul>li>div.area>ul>li>a"));
		// System.out.println(theaterUrls.size());
		ArrayList<String> thUrls = new ArrayList<String>();
		for (WebElement theater : theaterUrls) {
			thUrls.add(theater.getAttribute("href"));
		}
//		for(String url : thUrls) {
//			driver.get(url);
//		}
		driver.quit();
		return thUrls;
	}

	public int addCgvTheaters() {
		System.out.println("addCgvTheaters");
		ArrayList<String> theaterUrls = getTheaterUrls();
		// System.out.println(theaterUrls.size());
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		// options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);
		int idx = 0;
		ArrayList<Theater> thList = new ArrayList<Theater>();
		for (String url : theaterUrls) {
			driver.get(url);
			Theater th = new Theater();
			try {
				WebElement titleElement = driver
						.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"));
				String thname = titleElement.getText();
				// System.out.println(thname);
				th.setThname(thname);
				WebElement addrElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > strong"));
				String thaddr = addrElement.getText();
				thaddr = thaddr.replace("위치/주차 안내 >", "");
				thaddr = thaddr.split("\n")[0];
				th.setThaddr(thaddr);
				// 서울특별시 강남구 역삼동 814-6 스타플렉스+\n+서울특별시 강남구 강남대로 438 (역삼동)
				// \n을 기점으로 0번 인덱스만 사용
				WebElement telElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(1)"));
				String thtel = telElement.getText();
				th.setThtel(thtel);
				WebElement infoElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(2)"));
				String thinfo = infoElement.getText();
				th.setThinfo(thinfo);
				WebElement imgElement = driver.findElement(By.cssSelector("#theater_img_container > img"));
				String thimg = imgElement.getAttribute("src");
				th.setThimg(thimg);
//				System.out.println("이름 : "+thname+'\n'+
//								   "주소 : "+thaddr+'\n'+
//								   "번호 : "+thtel+'\n'+
//								   "정보 : "+thinfo+'\n'+
//								   "이미지 : "+thimg
//									);
				thList.add(th);
			} catch (Exception e) {
				// 선택 요소가 없을 때
				continue;
			}
			// System.out.println(titleElement.getText());

//			idx++;
//			if(idx>50) {
//				break;
//			}
		}
		System.out.println(thList);
		driver.quit();
		String maxThCode = adminDao.selectMaxThCode();
		System.out.println(maxThCode);
		int insertCount = 0;
		for (Theater th : thList) {
			String thCode = genCode(maxThCode);
			th.setThcode(thCode);
			try {
				int insertResult = adminDao.insertTheater(th);
				insertCount++;
				maxThCode = thCode;
			} catch (Exception e) {
				continue; // 중복 영화일 경우 다음 반복
			}
		}
		return insertCount;
	}

	public int addCgvScheduleInfo() {
		ArrayList<String> theaterUrls = getTheaterUrls();
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		WebDriver driver = new ChromeDriver(options);
		ArrayList<Schedule> scList = new ArrayList<Schedule>();
		int check = 0;
		for (String thurl : theaterUrls) {
			driver.get(thurl);
			check ++;
			if(check > 5) {
				break;
			}
			try {
				String thname = driver
						.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"))
						.getText();
				//System.out.println("극장 : " + thname);
				// selenium - 극장 페이지 내부에 있는 스케쥴 프레임으로 변경
				driver.switchTo().frame(driver.findElement(By.id("ifrm_movie_time_table")));
				List<WebElement> dayList = driver.findElements(By.cssSelector("#slider > div:nth-child(1) > ul > li"));
				for (int i = 0; i < dayList.size(); i++) {
					// showtimes : 상영스케쥴표 영화 목록
					if (i > 0) {
						driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on+li")).click();
						
					}
					String mm = driver
							.findElement(By
									.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > span"))
							.getText();
					mm= mm.replace("월", "");
					String dd = driver.findElement(
							By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > strong"))
							.getText();
					//System.out.println(mm + dd);
					List<WebElement> showtimes = driver
							.findElements(By.cssSelector("body>div>div.sect-showtimes>ul>li"));
					// System.out.println("showtimes.size() : "+showtimes.size());
					for (WebElement showtime : showtimes) {
						// 예매 가능 영화 제목
						String mvtitle = showtime.findElement(By.cssSelector("div>div.info-movie>a>strong")).getText();
						// 예매 가능 상영관
						List<WebElement> type_Halls = showtime
								.findElements(By.cssSelector("div.col-times>div.type-hall"));
						for(WebElement hall : type_Halls) {
							// 예매 가능 상영관 이름
							String hallName = hall.findElement(By.cssSelector("div.info-hall > ul > li:nth-child(2)")).getText();
							//System.out.println("상영관 "+hallName);
							List<WebElement> timeList = hall.findElements(By.cssSelector("div.info-timetable > ul > li > a > em"));
							for(WebElement time : timeList) {
								// 예매 가능 시간
								String hallTime = time.getText();
								//System.out.println(thname+" : "+mm+dd+" : "+mvtitle+" : "+hallName+" : "+hallTime);
								Schedule schedule = new Schedule();
								schedule.setMvcode(mvtitle);
								schedule.setThcode(thname);
								schedule.setSchall(hallName);
								schedule.setScdate("2023"+mm+dd+" "+hallTime);
								scList.add(schedule);
							}
							//System.out.println();
						}
						//System.out.println("영화제목 : " + mvtitle + " : " + type_Halls.size());
					}
				}
				// selenium - 예약 가능 날짜 목록 수집
				// System.out.println(dayList.size());
			} catch (Exception e) {
				continue;
			}
		}
		//INSERT
		int insertCount = 0;
		//System.out.println(scList);
		System.out.println(scList.size());
		for(Schedule sc : scList) {
			try {
				int insertResult = adminDao.insertSchedule(sc);	
				insertCount++;
			} catch (Exception e) {
				continue;
			}
		}
		driver.quit();
		return insertCount;
	}

	public void mapperTest_Movie(String thcode) {
		System.out.println("mapperTest_Movie"+thcode);
		ArrayList<Movie> mvList = adminDao.selectMapperTest(thcode);
		System.out.println("극장선택 O : "+mvList.size());
		ArrayList<Movie> mvList2 = adminDao.selectMapperTest(null);
		System.out.println("극장선택 X : "+mvList2.size());
		//System.out.println(mvList);
		System.out.println(mvList.size());
	}
}
