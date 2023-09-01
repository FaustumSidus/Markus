<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>
	
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
        
    	<style type="text/css">
    		.arr{
				
			}
			.arr>td{
				text-align: center;
			}
			div>button{
				font-size: 20px;
				margin: 5px;
				width: 200px;
				height: auto;
				background-color: aqua;
			}
			.soon{
				color: blue;
			}
			.scroll{
				overflow: scroll;
				width: 500px;
				height: 290px;
			}
			#nodeList{
				float: right;
			}
			.sarr{
				border: 1px solid red;
			}
    	</style>
    	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5f9e825dec7177a1b1fbf0f69df23821"></script>
    </head>

    <body>
        <div class="mainWrap">
            <div class="header">
                <h1>버스 - views/BusList_ajax.jsp</h1>
                <p id = "loginId"></p>
            </div>

            <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

            <div class="contents">
            	<div id="map" style="width:400px;height:300px;"></div>
            	<div id="nodeList" >
            	</div>
               	<div id="busSt" >
               	
               	</div>
               	<hr>
               	<div id="busArr" class="busSt">
               	
               	</div>
               	<div id="arrInfo">
               	</div>
            </div>

        </div>
    </body>
    <script type="text/javascript">
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.4387, 126.6750), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    // 클릭한 위도, 경도 정보를 가져옵니다 
    	var latlng = mouseEvent.latLng;
    	var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    	message += '경도는 ' + latlng.getLng() + ' 입니다'; 
    	console.log(message);
    	getBusStList(latlng.getLat(),latlng.getLng());
	});
    </script>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script type="text/javascript">
    	let citycode = 0;
    	let routeid = 0;
    	function getBusArrInfo(nodeId, cityCode){
    		console.log("nodeId : "+nodeId);
    		console.log("cityCode : "+cityCode);
    		citycode = cityCode;
    		$.ajax({
    			type : "get",
    			url : "getBusArr",
    			data : {"nodeId" : nodeId, "cityCode" : cityCode},
    			dataType : "json",
    			success : function(arrInfoList){
    				console.log(arrInfoList);
    				console.log(arrInfoList.length);
    				console.log("버스번호 : "+arrInfoList[0].routeno);
    				console.log("남은정류장 : "+arrInfoList[0].arrprevstationcnt);
    				console.log("도착예정시간 : "+arrInfoList[0].arrtime);
    				let busarrdiv = document.querySelector("#busArr");
    				busarrdiv.innerHTML = "";
    					let div = document.createElement('table');
    					let bustr = document.createElement('tr');
    					bustr.setAttribute("id","bustr")
    					let busno = document.createElement('th');
    					busno.innerText = "버스번호";
    					bustr.appendChild(busno);
    					let buscnt = document.createElement('th');
    					buscnt.innerText = "남은정류장";
    					bustr.appendChild(buscnt);
    					let bustime = document.createElement('th');
    					bustime.innerText = "도착예정시간";
    					bustr.appendChild(bustime);
    					div.appendChild(bustr);
    					busarrdiv.appendChild(div);
    				for(let i = 0; i<arrInfoList.length; i++){
    					let arrdiv = document.createElement('tr');
    					arrdiv.setAttribute("id","arrtr")
    					arrdiv.classList.add('arr');
    					let routenop = document.createElement('td');
    					routenop.innerText=arrInfoList[i].routeno+"번";
    					let rnobtn = document.createElement('button');
    					routeid=arrInfoList[i].routeid;
    					rnobtn.setAttribute("value",routeid);
    					console.log("citycode : "+citycode);
    					rnobtn.innerText="현위치 확인";
    					rnobtn.setAttribute("onclick","getbuslo('"+citycode+"','"+rnobtn.value+"')");
    					routenop.appendChild(rnobtn);
    					arrdiv.appendChild(routenop);
    					let arrprevstationcntp = document.createElement('td');
    					arrprevstationcntp.innerText=arrInfoList[i].arrprevstationcnt+"개 전";
    					arrdiv.appendChild(arrprevstationcntp);
    					let arrtimep = document.createElement('td');
    					if(arrInfoList[i].arrtime/60>=2){
    						arrtimep.innerText=parseInt(arrInfoList[i].arrtime/60)+"분 후 도착예정";
    					} else {
    						arrtimep.innerText="곧 도착예정";
    						arrtimep.classList.add('soon');
    					}
    					arrdiv.appendChild(arrtimep);
    					div.appendChild(arrdiv);
    					busarrdiv.appendChild(div);
    					console.log(busarrdiv);
    				}
    			}
    		});
    	}
    	$(document).ready(function(){
    		getBusStList(37.4387, 126.6750);
    	});
    	function getBusStList(lati,longti){
    		$.ajax({
    			type : "get",
    			url : "getBusSt",
    			data : {
    				"lati" : lati,
    				"longti" : longti
    			},
    			dataType : "json",
    			success : function(stList){
    				console.log(stList);
    				let busSt = document.querySelector("#busSt");
    				busSt.innerHTML = "";
    				let idx = 0;
    				console.log(idx);
    					for(let i = 0; i<stList.length; i++){
        					let busstnm = document.createElement('button');
        					busstnm.innerText+=stList[i].nodeno+'\n'+stList[i].nodenm;  
        					busstnm.setAttribute("onclick","getBusArrInfo('"+stList[i].nodeid+"','"+stList[i].citycode+"')");
        					busSt.appendChild(busstnm);
        					idx++;
        					console.log(idx);
        					if(idx%2==0){
        						let br = document.createElement('br');
        						busSt.appendChild(br);
        					}
        					console.log(busSt);
        				}
    				
    			}
    		});
    	}
    	function getbuslo(cityCode,routeId){
    		// 전체 버스 정류장 목록
    		bList="";
    		$.ajax({
    			type : "get",
    			url : "busloList",
    			data : {
    				"cityCode" : cityCode,
    				"routeId" : routeId
    			},
    			dataType : "json",
    			success : function(result){
    				bList=result;
    				let nodeList = document.querySelector("#nodeList");
    				nodeList.innerHTML="";
    				let nodediv = document.createElement('div');
    				nodediv.setAttribute("class","scroll");
    				for(let info of bList){
    					let nodep = document.createElement('p');   		
    					nodep.innerText=info.nodenm;
    					 //  전체 1 ~ 100
    					// 운행중  4, 8, 10
    					nodediv.appendChild(nodep);
    					nodeList.appendChild(nodediv);
    				}
    				
    			}
    		});
    		//운행중인 버스 현 위치
    		$.ajax({
    			type : "get",
    			url : "busloc",
    			data : {
    				"cityCode" : cityCode,
    				"routeId" : routeId
    			},
    			dataType : "json",
    			success : function(locList){
    				console.log(locList);
    				let arrdiv = document.querySelector("#arrInfo");
    				arrdiv.innerHTML="";
    				let atable = document.createElement('table');
    				let atr1 = document.createElement('tr');
    				let ath1 = document.createElement('th');
    				ath1.innerText="현위치";
    				atr1.appendChild(ath1);
    				let ath2 = document.createElement('th');// 버스차번
    				ath2.innerText="차량번호";
    				atr1.appendChild(ath2);
    				atable.appendChild(atr1);    				
    				for(i=0; i<locList.length; i++){
    				let atr2 = document.createElement('tr');
    				let atd1 = document.createElement('td');// 정류장이름
    				atd1.innerText=locList[i].nodenm;
    				atr2.appendChild(atd1);
    				for(let bl of bList){
    					if(bl.nodeid == locList[i].nodeid){
    						console.log("버스 있는 정류장 : "+bl.nodeid);
    					}
    					
    				}
    				let atd2 = document.createElement('td');// 버스차번
    				atd2.innerText=locList[i].vehicleno;
    				atr2.appendChild(atd2);
    				atable.appendChild(atr2);
    				console.log(atable);
    				arrdiv.appendChild(atable);
    				}
    			}
    		});
    		
    		
    		
    		
    		
    	}
    </script>
    </html>
    