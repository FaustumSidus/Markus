package com.spring_memberBoard.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring_memberBoard.dto.Bus;

@Service
public class ApiService {

	public ArrayList<Bus> getBusArrive() throws IOException  {
		System.out.println("Service - getBusArrive");
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=J6FAUoa2Vt3ccaicgyj0ajPJiWMIfOpoWzu8TG10uuEBEGSBS%2BJRo17cTOX32fWkNxCvVrKMUZwkfEvTa1YD1Q%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("23", "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("nodeId","UTF-8") + "=" + URLEncoder.encode("ICB163000063", "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
		
        JsonObject busInfo_Json 
        	= (JsonObject) JsonParser.parseString(sb.toString());
        JsonArray infoList = busInfo_Json.get("response").getAsJsonObject()
        								 .get("body").getAsJsonObject()
        								 .get("items").getAsJsonObject()
        								 
        								 .get("item").getAsJsonArray();
        System.out.println(infoList);
        System.out.println(infoList.size());
        ArrayList<Bus> busList = new ArrayList<Bus>();
        for(int i = 0; i < infoList.size(); i++) {    
        	Bus bus = new Bus();
        	String nodenm = infoList.get(i).getAsJsonObject().get("nodenm").getAsString();
        	System.out.println("정류소명 : "+nodenm);
        	bus.setNodenm(nodenm);
        	
        	String routeno = infoList.get(i).getAsJsonObject().get("routeno").getAsString();
        	bus.setRouteno(routeno);
        	
        	String arrprevstationcnt = infoList.get(i).getAsJsonObject().get("arrprevstationcnt").getAsString();
        	bus.setArrprevstationcnt(arrprevstationcnt);
        	
        	String arrTime = infoList.get(i).getAsJsonObject().get("arrtime").getAsString();
        	int arrtime = Integer.parseInt(arrTime)/60;
        	arrTime = Integer.toString(arrtime);
        	bus.setArrtime(arrTime);
        	busList.add(bus);
        }
        System.out.println(busList);
       
		return busList;
	}
	/*
        JsonObject busInfo_body 
        	= busInfo_Json.get("response").getAsJsonObject().get("body").getAsJsonObject();
        System.out.println(busInfo_body);
        JsonObject busInfo_Items = busInfo_body.get("items").getAsJsonObject();
        System.out.println(busInfo_Items);
        JsonArray itemList = busInfo_Items.get("item").getAsJsonArray();
        System.out.println(itemList);
        System.out.println(itemList.size());
	 */

	public String getBusArrInfoList(String nodeId, String cityCode) throws IOException {
		System.out.println("service 버스도착정보_API 호출");
		// 공공데이터 포털 예제 코드
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
		     	urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=J6FAUoa2Vt3ccaicgyj0ajPJiWMIfOpoWzu8TG10uuEBEGSBS%2BJRo17cTOX32fWkNxCvVrKMUZwkfEvTa1YD1Q%3D%3D"); /*Service Key*/
		     	urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		     	urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
		        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
		        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(cityCode, "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
		        urlBuilder.append("&" + URLEncoder.encode("nodeId","UTF-8") + "=" + URLEncoder.encode(nodeId, "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
		        URL url = new URL(urlBuilder.toString());
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("GET");
		        conn.setRequestProperty("Content-type", "application/json");
		        System.out.println("Response code: " + conn.getResponseCode());
		        BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }
		        StringBuilder sb = new StringBuilder();
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb.append(line);
		        }
		        rd.close();
		        conn.disconnect();
//		        System.out.println(sb.toString());
		        JsonObject arrInfoJson = JsonParser.parseString(sb.toString()).getAsJsonObject();
		        JsonArray busInfoList = arrInfoJson.get("response").getAsJsonObject()
		        						.get("body").getAsJsonObject()
		        						.get("items").getAsJsonObject()
		        						.get("item").getAsJsonArray();
		        System.out.println(arrInfoJson);
		        System.out.println(busInfoList);
		        System.out.println(busInfoList.size());
		  
		return new Gson().toJson(busInfoList);
	}

	public String getBusSt(String lati, String longti) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=J6FAUoa2Vt3ccaicgyj0ajPJiWMIfOpoWzu8TG10uuEBEGSBS%2BJRo17cTOX32fWkNxCvVrKMUZwkfEvTa1YD1Q%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("gpsLati","UTF-8") + "=" + URLEncoder.encode(lati, "UTF-8")); /*WGS84 위도 좌표*/
        urlBuilder.append("&" + URLEncoder.encode("gpsLong","UTF-8") + "=" + URLEncoder.encode(longti, "UTF-8")); /*WGS84 경도 좌표*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
//        System.out.println(sb.toString());
        JsonObject busSt = JsonParser.parseString(sb.toString()).getAsJsonObject();
        JsonArray busStList = busSt.get("response").getAsJsonObject()
        						.get("body").getAsJsonObject()
        						.get("items").getAsJsonObject()
        						.get("item").getAsJsonArray();
        System.out.println(busStList);			
		return new Gson().toJson(busStList);
	}

	public String getBusLoc(String cityCode, String routeId) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=J6FAUoa2Vt3ccaicgyj0ajPJiWMIfOpoWzu8TG10uuEBEGSBS%2BJRo17cTOX32fWkNxCvVrKMUZwkfEvTa1YD1Q%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(cityCode, "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("routeId","UTF-8") + "=" + URLEncoder.encode(routeId, "UTF-8")); /*노선ID [국토교통부(TAGO)_버스노선정보]에서 조회가능*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        JsonObject busloc = JsonParser.parseString(sb.toString()).getAsJsonObject();
        JsonArray locList = busloc.get("response").getAsJsonObject()
        						.get("body").getAsJsonObject()
        						.get("items").getAsJsonObject()
        						.get("item").getAsJsonArray();
		return new Gson().toJson(locList);
	}

	public String getBList(String cityCode, String routeId) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusRouteInfoInqireService/getRouteAcctoThrghSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=J6FAUoa2Vt3ccaicgyj0ajPJiWMIfOpoWzu8TG10uuEBEGSBS%2BJRo17cTOX32fWkNxCvVrKMUZwkfEvTa1YD1Q%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("200", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(cityCode, "UTF-8")); /*도시코드 [상세기능4. 도시코드 목록 조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("routeId","UTF-8") + "=" + URLEncoder.encode(routeId, "UTF-8")); /*노선ID [상세기능1. 노선번호목록 조회]에서 조회 가능*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
//        System.out.println(sb.toString());
        JsonObject busList = JsonParser.parseString(sb.toString()).getAsJsonObject();
        JsonArray bList = busList.get("response").getAsJsonObject()
        						.get("body").getAsJsonObject()
        						.get("items").getAsJsonObject()
        						.get("item").getAsJsonArray();
		return new Gson().toJson(bList);
	}
	
}
