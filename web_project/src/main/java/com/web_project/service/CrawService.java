package com.web_project.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Service;

@Service
public class CrawService {

	public ArrayList<HashMap<String, String>> getOliveRankItem() throws IOException {
		System.out.println("올리브영  랭킹 아이템 수집 기능 호출");
		//Jsoup
		
		
		//1. https://www.oliveyoung.co.kr/store/main/getBestList.do 접속
		String oliveRankUrl="https://www.oliveyoung.co.kr/store/main/getBestList.do";
		//2. 랭킹 페이지 문서 리턴 <HTML> ~ <HTML>
		Document oliveRankDoc = Jsoup.connect(oliveRankUrl).get();// 아무거나 import X, jsoup 만
		//3. 필요한 정보가 있는 부분(태그, 요소) 선택 (css 선택자)
		Elements itemsDiv = oliveRankDoc.select("div.TabsConts"); // 사이트 내 div 선택
		Elements items = itemsDiv.get(0).select("ul.cate_prd_list li"); // div 내 class 내 li 태그 선택
		//System.out.println(item.get(0)); // 1~100위까지 출력
		//System.out.println(item.size()); // 100
		//4. 데이터를 수집
		// 브랜드명, 상품이름, 상품가격, 상품이미지
		// 상품리뷰수 상품 상세페이지 이동 > 리뷰수 수집
		// 상세페이지 url
		//System.out.println(item.get(1).select("div.prd_info>a>img"));
//		for(Element item : items) {
//			item.selct~
//		}
		ArrayList<HashMap<String, String>> prdList = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<items.size(); i++) {
			HashMap<String, String> prdMap = new HashMap<String, String>();
			String rank = items.get(i).select("div.prd_info>a>span").text();	
			String imgUrl = items.get(i).select("div.prd_info>a>img").attr("src");
			prdMap.put("prdImg", imgUrl);
			String brandName = items.get(i).select("span.tx_brand").text(); // span 태그의 innerText 추출
			prdMap.put("prdBrd", brandName);
			String orgPrice = items.get(i).select("span.tx_org>span").text();
			String prdPrice = items.get(i).select("span.tx_cur>span").text();
			prdMap.put("prdPrice", prdPrice+'원');
			String prdName = items.get(i).select("p.tx_name").text();
			prdMap.put("prdName", prdName);			
			String detailUrl = items.get(i).select("div.prd_info>a").attr("href");
			// 상세페이지 Document
			Document detailDoc = Jsoup.connect(detailUrl).get();
			String reviewCount = detailDoc.select("p#repReview > em").text();
			reviewCount = reviewCount.replace("(","").replace(")","").replace(",", "");
			prdMap.put("prdRev", reviewCount);
//			String[] prdName_split = prdName.split("]");
//			System.out.println(prdName_split.length);
//			System.out.println(prdName_split[0]);
//			System.out.println(prdName_split[1]);
//			System.out.println(
//					"인기순위 : "+rank+"위"+'\n'+
//					"브랜드명 : "+brandName+'\n'+
//					"상품이름 : "+prdName+'\n'+
//					"상품가격 : "+orgPrice+"원"+'\n'+					
//					"할인가격 : "+prdPrice+"원"+'\n'+
//					"댓글개수 : "+reviewCount+'\n');
			prdList.add(prdMap);
			
			}
		//5. DB에 저장
			return prdList;
	}

	public ArrayList<HashMap<String, String>> get11stList(String searchText) throws IOException {
		System.out.println("cvsc.getllstList");
		//접속 페이지 URL
		//https://search.11st.co.kr/Search.tmall?kwd=keyboard
		//String connectUrl = "https://search.11st.co.kr/Search.tmall?kwd="+searchText;
		//Document targetPage = Jsoup.connect(connectUrl).get();
		//System.out.println(targetPage);
		ChromeOptions chromeOptions = new ChromeOptions();
		chromeOptions.addArguments("headless");
		WebDriver driver = new ChromeDriver(chromeOptions);		
		String connectUrl = "https://search.11st.co.kr/Search.tmall?kwd="+searchText;
		driver.get(connectUrl);
		List<WebElement> items = driver.findElements(By.cssSelector("section.search_section>ul.c_listing>li"));
		ArrayList<HashMap<String, String>> prdList_11st = new ArrayList<HashMap<String,String>>();
		for(WebElement item : items) {		
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			
			try {
				String prdName = item.findElement(By.cssSelector("div.c_prd_name strong")).getText();
				prdInfo.put("prdName", prdName);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		
	
		return null;
	}

	public ArrayList<HashMap<String, String>> getPrdList_coopang(String searchText) throws IOException {
		//https://www.coupang.com/np/search
		//?component=&q=keyboard&channel=user
		//System.out.println("coopang");
		String connectUrl = "https://www.coupang.com/np/search";
		HashMap<String, String> paramList = new HashMap<String, String>();
		paramList.put("component", "");
		paramList.put("q", searchText);
		paramList.put("channel", "user");
		Document targetPage = Jsoup.connect(connectUrl)
								   .data(paramList)
								   .cookie("auth", "token")
								   .get();
		
		Elements items = targetPage.select("li.search-product");
		//System.out.println(items);
		//System.out.println(items.size());
		// 상품 이름, 가격 수집
		ArrayList<HashMap<String, String>> prdList_coopang = new ArrayList<HashMap<String, String>>();
		for(int i=0; i<items.size(); i++) {
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			String prdName = items.get(i).select("div.name").text();//div.descriptions-inner>div.name
			String prdPrice = items.get(i).select("div.price>em>strong").text();//div.descriptions-inner>div.price-area strong.price-value
			String prdUrl = "https://www.coupang.com"+items.get(i).select("a").attr("href");// 도메인 주소 X > 앞에 별도 추가
			prdPrice = prdPrice.replace(",", "");
			prdInfo.put("prdName", prdName);
			prdInfo.put("prdPrice", prdPrice);
			prdInfo.put("prdUrl", prdUrl);
			prdInfo.put("prdSite", "coopang");
			// 상품 가격 순 정렬 (high~low)
			int idx = -1; // prdList_coopang에 추가할 인덱스 번호
			
			
			for(int j=0; j<prdList_coopang.size(); j++) {
				int prdPrice_int = Integer.parseInt(prdPrice);
				int listPrice = Integer.parseInt(prdList_coopang.get(j).get("prdPrice"));
				if(prdPrice_int > listPrice) {
					idx = j;
					break;
				}
			}
			if(idx>-1) {
				prdList_coopang.add(idx,prdInfo);
			} else {
				prdList_coopang.add(prdInfo);
			}
			// prdList_coopang.add(idx,prdInfo);
		}
		return prdList_coopang;
	}

	public ArrayList<HashMap<String, String>> getPrdList_gmarket(String searchText) throws IOException {
		String connectUrl = "https://browse.gmarket.co.kr/search";
		HashMap<String, String> paramList = new HashMap<String, String>();
		paramList.put("keyword", searchText);
		Document targetPage = Jsoup.connect(connectUrl)
								   .data(paramList)
								   .cookie("auth", "token")
								   .get();	
		//Elements item = targetPage.select("div.section__module-wrap");
		//Elements items = item.select("div.box__item-container"); // 광고상품도 같이 나옴
		Elements items = targetPage.select("div.box__component-itemcard");
		ArrayList<HashMap<String, String>> prdList_gmarket = new ArrayList<HashMap<String, String>>();
		for(int i=0; i<items.size(); i++) {
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			String prdName = items.get(i).select("span.text__item").text();
			String prdPrice = items.get(i).select("div.box__price-seller>strong").text();			
			String prdUrl = items.get(i).select("div.box__item-title>span>a").attr("href");			
			prdPrice = prdPrice.replace(",", "");
			prdInfo.put("prdName", prdName);
			prdInfo.put("prdPrice", prdPrice);
			prdInfo.put("prdUrl", prdUrl);
			prdInfo.put("prdSite", "gmarket");
			int idx = -1; // prdList_coopang에 추가할 인덱스 번호
			/*String sortOption = "PRICE_ACS";
			for(int j=0; j<prdList_gmarket.size(); j++) {
				int prdPrice_int = Integer.parseInt(prdPrice);
				int listPrice = Integer.parseInt(prdList_gmarket.get(j).get("prdPrice"));
				boolean sortType = true;
				switch(sortOption) {
				case "PRICE_DESC":
					sortType = prdPrice_int > listPrice;
					break;
				case "PRICE_ACS":
					sortType = prdPrice_int < listPrice;
					break;
				}
				if(sortType) {
					idx = j;
					break;
				}
			}
			if(idx>-1) {
				prdList_gmarket.add(idx,prdInfo);
			} else {
			}*/
			prdList_gmarket.add(prdInfo);
		}
		//System.out.println(items);
		
		return prdList_gmarket;
	}

}
