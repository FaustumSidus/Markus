<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Movie Reserve Project</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/user/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath }/resources/user/css/styles.css" rel="stylesheet" />
    	<style type="text/css">
    		.selectList{
    			cursor: pointer;
    			border: 1px solid black;	
    			border-radius: 5px;
    			margin-bottom: 3px;
    			margin-top: 3px;
    			padding: 3px;
    		}
    		.selectList:hover{
    			background-color: bisque;
    		}
    		.selectObj{
    			background-color: pink;
    		}
    		#movArea{
    			overflow: scroll;
    			border: 2px solid black;
    			width: auto;
    			height: 400px;
    		}
    		#thArea{
    			overflow: scroll;
    			border: 2px solid black;
    			width: auto;
    			height: 400px;
    		}   
    		#dateArea{
    			overflow: scroll;
    			border: 2px solid black;
    			width: auto;
    			height: 400px;
    		}	 
    		#timeArea{
    			overflow: scroll;
    			border: 2px solid black;
    			width: auto;
    			height: 400px;
    		}	    	
    		.title{
    			background-color: black;
    			color: white;
    			text-align: center;
    			font-weight: bold;
    		}
    		.selectObj{
    			background-color: black !important;
    			color: white;
    			font-weight: bold;
    		}
    		.selMoviePoster{   			
    			width: 240px;
    			height: 260px;
    		}   
    		.selTheaterImg{   			
    			width: 240px;
    			height: 400px;
    		}   
    		.unselectList{
    			cursor: pointer;
    			border: 1px solid lightgray;	
    			border-radius: 5px;
    			margin-bottom: 3px;
    			margin-top: 3px;
    			padding: 3px;
    			color: lightgray;
    		}		
    		.info{
    			background-color: bisque;
    		}
    		.bold{
    			font-weight: bold;
    		}   
    		.reserveBtn{
    			height: 340px;
    		}	
    	</style>
    </head>
    <body>
    	<!-- 메뉴 시작 -->
        <!-- Responsive navbar-->
        <%@ include file="/WEB-INF/views/include/menu.jsp" %>
        <!-- 메뉴 끝 -->
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">영화 예매 페이지</h1>
                    <p class="lead mb-0">영화, 극장, 날짜 선택 및 결제 페이지</p>
                </div>
            </div>
        </header>
        <!-- Page content-->
        <div class="container"> <!-- 모든 페이지는 constainer 클래스 내부의 코드만 다름 -->
            <!-- 컨텐츠 시작 -->
             <div class="row">
            	<div class="col-lg-3 col-md-6 p-1">
            		<div class="title">영화</div>
					<div class="card mb-4">
						<div class="card-body p-2" id="movArea">		
						<c:forEach items="${mv}" var="mv">
							<div class="selectList selEl" id="${mv.mvcode }"  tabindex="0" onclick="movieClick(this,'${mv.mvcode}','${mv.mvposter }')">${mv.mvtitle }</div>
						</c:forEach>											 	
						</div>
					</div>
            	</div>
            	
            	<div class="col-lg-3 col-md-6 p-1">
            		<div class="title">극장</div>
	            	<div class="card mb-4">
						<div class="card-body p-2" id="thArea">	
						<c:forEach items="${th}" var="th">
							<div class="selectList selEl" id="${th.thcode }" onclick="theaterClick(this,'${th.thcode}','${th.thimg }')" >${th.thname }</div>
						</c:forEach>						
						</div>
					</div>
            	</div>
            	<div class="col-lg-2 col-md-4">
            	<div class="title">날짜</div>
            	<div class="card-body p-2" id="dateArea">	
            	</div>
            	</div>
            	<div class="col-lg-3 col-md-6">
            	<div class="title">시간</div>
            	<div class="card-body p-2" id="timeArea">           		
            	</div>
            	</div>
            </div>
            
            <div class="row">
            	<div class="col-lg-3">
            		<div class="card mb-4">
            			<div class="card-header text-center info" >선택영화</div>
            			<div class="card-body p-2" style="text-align: center;">
            				<p class="card-text bold" id="selTitle"></p>
            				<img class="selMoviePoster" id="selPoster" 
            				src="">
            			</div>
            		</div>
            	</div>
            	<div class="col-lg-5">
            		<div class="card mb-5">
            			<div class="card-header text-center info" >선택극장</div>           			 
            			<div class="card-body p-2" style="text-align: center;">     			
            			<p class="card-text mt-2 w-100 bold" id="selName"></p>
            			<!--  
            				<img class="selTheaterImg" id="selThImg" 
            				src="">
            			-->
            			<hr>
            			<p class="card-text w-100 info" >선택일시</p>
            			<hr>
            			<p class="card-text w-100 bold" id="selDate" >날짜</p>
            			<p class="card-text w-100 bold" id="selTime">시간</p>
            			<hr>
            			<p class="card-text w-100 info" >선택 상영관</p>
            			<hr>
            			<p class="card-text w-100 bold" id="selTheater" >상영관</p>           			
            			</div>
            		</div>
            	</div> 
            	<div class="col-lg-3">
            		<div class="card mb-4">  
            			<div class="card-body p-2">
		            		<button class="btn btn-danger w-100 p-2 reserveBtn" onclick="movieReserve()" href="#!">예매하기</button>
            			</div>
            		</div> 
            	</div> 
            </div>
                                	                             
            <!-- 컨텐츠 끝 -->
        </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        <!-- Core theme JS-->
        <script type="text/javascript">
        	let mvCheck = null;
        	let reserve_mvcode = null;
        	let reserve_thcode = null;
        	let reserve_scdate = null; 
        	let reserve_sctime = null;
        	let reserve_schall = null;
        	//let reserve_mid = ${loginId};
        	//let reserve_MM = null;
        	//let reserve_DD = null;
        	let thCheck = null;
        	let dateCheck = null;
        	let recode = null;
        	//let timeCheck = null;
        	let timeDiv = document.querySelector('#timeArea');
        	let reCheck = null;
        	/*
        		function resetSelectInfo(sel){
        		// 선택정보 초기화
        		// 페이지 : 시간, 상영환 조기화
        		document.querySelector('#selTime').innerText = "시간";
  				document.querySelector('#selTheater').innerText = "상영관";
  				// 시간 상영관 목록 초기화
  				document.querySelector('#timeArea').innerHTML = "";
        		// 변수 : reserve_sctime, reserve_schall 초기화
        		reserve_sctime = null;
        		reserve_schall = null;
        		if(sel){
        			// 페이지 : 날짜 초기화
        			document.querySelector('#selDate').innerText = "날짜";
        			// 변수 : reserve_scdate 초기화
        			reserve_scdate = null;
        		}
        		
        		switch(sel){
        		case 'date':        			
        			break;
        		case 'movie' :
        		case 'theater' :
        			// 영화, 극장 클릭 시 초기화 해줄 내용
        			// 페이지 : 시간, 상영관 초기화 + 날짜
        			
        			break;
        		}
        	}
        	*/
			function kakaoPay_ready(recode){
        		console.log('카카오페이 결제준비');
        		$.ajax({
        			type : "post",
        			url : "kakaoPay_ready",
        			data : {'mvcode':reserve_mvcode,
    						'thcode':reserve_thcode,
    						'schall':reserve_schall,
    						'scdate':reserve_sctime 
    					   },
    				async : false,
    				success:function(result){
    					console.log(result);
    					window.open(result,"pay","width=400,height=500");
    				}
        		})
        	}
        	function reserveResult_success(){
        		// 예매 성공 시 호출
        		alert("예매 완료");
        		location.href="${pageContext.request.contextPath }/";
        	}
        	function failReserve(){
        		// 예매 처리 실패
        		alert('예매 실패');
        		$.ajax({
        			// DELETE FROM RESERVE WHERE RECODE = ???
        			type : "post",
        			url : "reserveFail",
        			data : {'recode':reserveCode},
        			async : false,
        			success : function(result){
        				console.log(result);       				
        			}
        		})
        		location.reload();
        	}
        	let reserveCode = "";
        	function registReserveInfo(){
        		$.ajax({
        			type : "post",
        			url : "registReserveInfo",
        			data : {'recode':recode,
        					'mvcode':reserve_mvcode,
        					'thcode':reserve_thcode,
        					'schall':reserve_schall,
        					'scdate':reserve_sctime},
        			async : false,
        			success : function(result){
        				console.log('예매 처리 결과');
        				if(result == 'login'){
        					alert('로그인 후 이용가능');
        					location.href="/memberLoginForm";
        				} else if(result.length > 0){
        					console.log("예매 INSERT 성공");
        					reserveCode = result;
        					kakaoPay_ready(result);
        				} else {
        					console.log("예매 INSERT 실패");
        					alert('예매 실패');	
        				}
        			}
        		})
        	}
        	function movieReserve(){
        		let loginCheck = '${sessionScope.loginId}';
        		if(loginCheck.length == 0){
        			alert('로그인해 주세요!');
        		} else if(reserve_mvcode == null){        			        		
        			alert('영화를 선택 해주세요!');
        		} else if(reserve_thcode == null){        			
            		alert('극장을 선택 해주세요!');
            	} else if(reserve_scdate == null){        			        			
            		alert('날짜를 선택 해주세요!');
        		} else if(reserve_sctime == null){        			            		           	 
            		alert('시간을 선택 해주세요!');
            	} else{           		
	        		//console.log("reserve_mvcode : "+reserve_mvcode);
	        		//console.log("reserve_thcode : "+reserve_thcode);	        		
					//console.log("reserve_sctime : "+reserve_sctime+":00");
					//console.log("reserve_schall : "+reserve_schall);
            		console.log('예매처리 요청');
            		// 1. INSERT >> 성공
            		// 2. KAKAOPAY >> 성공(메시지), 실패(DELETE)
            		// 3. 
            		// 1. 카카오페이 API 결제 준비 요청
            		
            		// 결제QR URL
            		// 결제 결과값
            		// 2. Controller INSERT 요청
            		registReserveInfo();
            	} 
        	}
        	function movieClick(selmvobj, mvcode, mvposter){
        		//console.log("selmvobj : "+selmvobj); // style 변경
        		//console.log("mvcode : "+mvcode); // 극장 목록 조회
        		//console.log("mvtitle : "+selmvobj.innerText); // 선택항목 출력
        		//console.log("mvposter : "+mvposter); //선택 항목 출력
        		if(selmvobj.classList.contains('unselectList')){
        			console.log('예매 불가능 영화 선택');
        			let reloadCheck = confirm('선택한 극장에 상영중인 영화가 아닙니다. \n계속하시겠습니까?');
        			if(reloadCheck){
        				location.reload();
        			}
        		} else {			
        			//console.log(reserve_mvcode);
        			console.log('예매 가능 영화 선택');      				        		       					        		
	        		if(thCheck == null){	   
	        			// 1. 선택 항목 출력	        			
			        	document.querySelector('#selTitle').innerText = selmvobj.innerText;
			        	document.querySelector('#selPoster').setAttribute('src',mvposter);
			        	// 2. 선택 항목 style 변경
			        	addSelectStyle(selmvobj);
		        		// 3. 선택 영화 예매 가능한 극장 목록 조회(출력 x)
		        		let thList = getReserveTheaterList(mvcode);
		      			//console.log(thList);
		      			changeTheaterList(thList);		      			
	        		} else {
	        			if(mvCheck == '2'){    
	        				if(dateCheck == '1'){
		        				let reloadMvCheck = confirm('이미 날짜를 선택중입니다.\n계속하시겠습니까?');
		            			if(reloadMvCheck){
		            				location.reload();
		            			} else {
		            				timeDiv.innerHTML = "";
		            				reCheck = '1';
		            				getReserveTimeList();
		            			}
		        			} else {	        				
			        			// 1. 선택 항목 출력	        			
					        	document.querySelector('#selTitle').innerText = selmvobj.innerText;
					        	document.querySelector('#selPoster').setAttribute('src',mvposter);
					        	// 2. 선택 항목 style 변경
					        	addSelectStyle(selmvobj);	
					        	reserve_mvcode = mvcode;
		        			}
	        			} else if(mvCheck != null) { 	        				
	        				let reloadMvCheck = confirm('이미 영화를 선택중입니다.\n계속하시겠습니까?');
	            			if(reloadMvCheck){
	            				location.reload();
	            			} else {
	            				timeDiv.innerHTML = ""; 
	           					reCheck = '1';
	           					if(dateCheck == '1'){
	           						getReserveTimeList();
	           					}
	            			}
	        			}	else {	        				
	        				// 1. 선택 항목 출력	        			
				        	document.querySelector('#selTitle').innerText = selmvobj.innerText;
				        	document.querySelector('#selPoster').setAttribute('src',mvposter);
				        	// 2. 선택 항목 style 변경
				        	addSelectStyle(selmvobj);
				        	reserve_mvcode = mvcode;
	        			}
	        			//4. 영화 & 극장 모두 선택 시 날짜 목록 조회 출력
		      			if( (reserve_mvcode != null) && (reserve_thcode != null) && (reCheck != '1') ){
		      				getReserveScheduleDateList();
		      				reCheck == null;
		      				//console.log("영화코드 : "+reserve_mvcode);
		      				//console.log("극장코드 : "+reserve_thcode);
		      			}
	        		}
	        		if(reCheck != '1'){	
        				reserve_mvcode = mvcode;
        			}
	        		if(thCheck == null){	        			
	        			mvCheck = 1;	
	        		} else {
	        			if(mvCheck != '1'){	        				
	        				mvCheck = 2;
	        			}
	        		}
        		}
        	}
        	function changeTheaterList(thList){
        		console.log(thList.length);
        		let thCodeList = [];
        		for(let th of thList){
        			thCodeList.push(th.thcode);
        		}
        		//console.log(thCodeList);
        		let theaterEls = document.querySelectorAll("#thArea>div.selEl");
        		let thArea = document.querySelector('#thArea');
        		for(let thEl of theaterEls){
        			thEl.classList.remove('selectList');
        			thEl.classList.remove('unselectList');
        			if(thCodeList.includes(thEl.getAttribute('id'))){
        				//console.log("예매 가능 극장");
        				// 선택 영화 예매 가능 극장
        				thEl.classList.add('selectList');
        			} else {
        				//console.log("예매 불가 극장");
        				// 선택 영화 예매 불가 극장
        				thEl.classList.add('unselectList');
        				thArea.appendChild(thEl); // 복사가 아닌 내려쓰기
        			}
        		}
        	}
        	function addSelectStyle(selObj){
        		//console.log(selObj.parentElement);
        		let movDivs = selObj.parentElement.querySelectorAll('div.selEl');
        		for(let movEl of movDivs){
        			movEl.classList.remove('selectObj');
        		}
        		selObj.classList.add('selectObj');
        	}
        	function getReserveTheaterList(selectMvcode){
        		console.log("예매 가능 극장 목록 조회");
        		let theaterList = [];
        		$.ajax({
        			type : "get",
        			url : "getTheaterList_json",
        			data : {'selMvcode' : selectMvcode},
        			async : false,
        			dataType : "json",
        			success : function(result){
        				theaterList = result;
        			}
        		});
        		return theaterList;
        	}
        </script>
        <script type="text/javascript">
        	function theaterClick(selThobj,thcode,thimg){
        		//console.log("selThobj : "+selThobj);
        		//console.log("thcode : "+thcode);
        		if(selThobj.classList.contains('unselectList')){
        			console.log('예매 불가능 극장 선택');
        			let reloadCheck = confirm('선택한 극장에 원하는 상영스케쥴이 없습니다. \n 계속하시겠습니까?');
        			if(reloadCheck){
        				location.reload();
        			}
        		} else {        			
        			//console.log(reserve_thcode);
        			console.log('예매 가능 극장 선택');       				        				
        			if(mvCheck == null){       	
        				// 1. 선택 항목 출력
		        		document.querySelector('#selName').innerText = selThobj.innerText;
		        		//document.querySelector('#selThImg').setAttribute('src',thimg);
		        		// 2. 선택 항목 style 변경
		        		addSelectStyle(selThobj);		
	        			// 3. 선택 극장에서 예매 가능 영화 목록 조회
	        			let mvList = getMovieList(thcode);   
	        			//console.log(mvList.length);
	        			changeMovieList(mvList);		        			
        			} else {
        				if(thCheck == '2'){  
        					if(dateCheck == '1'){
            					let reloadThCheck = confirm('이미 날짜을 선택중입니다. \n계속하시겠습니까?');
                    			if(reloadThCheck){
                    				location.reload();
                    			} else {
		            				timeDiv.innerHTML = "";  
		            				reCheck = '1';
		            				getReserveTimeList();
		            			}
            				} else {
		        				// 1. 선택 항목 출력       				
				        		document.querySelector('#selName').innerText = selThobj.innerText;
				        		//document.querySelector('#selThImg').setAttribute('src',thimg);
				        		// 2. 선택 항목 style 변경
				        		addSelectStyle(selThobj); 
				        		reserve_thcode = thcode;        	
            				}
        				} else if(thCheck != null){
        					let reloadThCheck = confirm('이미 극장을 선택중입니다. \n계속하시겠습니까?');
                			if(reloadThCheck){
                				location.reload();
                			} else {
	            				timeDiv.innerHTML = "";
	            				reCheck = '1';	
	            				if(dateCheck == '1'){
	           						getReserveTimeList();
	           					}
	            			}
        				}   else {	
        					timeDiv.innerHTML = "";  	
        					// 1. 선택 항목 출력       				
			        		document.querySelector('#selName').innerText = selThobj.innerText;
			        		//document.querySelector('#selThImg').setAttribute('src',thimg);
			        		// 2. 선택 항목 style 변경
			        		addSelectStyle(selThobj);   
			        		reserve_thcode = thcode;        	
        				}
        				if((reserve_mvcode != null) && (reserve_thcode != null) && (reCheck != '1')){
        					getReserveScheduleDateList();
        					reCheck = null;
		      				//console.log("영화코드 : "+reserve_mvcode);
		      				//console.log("극장코드 : "+reserve_thcode);
		      			}
        			}
        			if(reCheck != '1'){
	        			reserve_thcode = thcode;        				
        			}
        			if(mvCheck == null){        				
		        		thCheck = 1;
        			} else {
        				if(thCheck != '1'){        					
        					thCheck = 2;
        				}
        			}
        		}
        		
        	}
        	function changeMovieList(mvList){
        		console.log(mvList.length);
        		let mvCodeList = [];
        		for(let mv of mvList){
        			mvCodeList.push(mv.mvcode);
        		}
        		//console.log(thCodeList);
        		let movieEls = document.querySelectorAll("#movArea>div.selEl");
        		let mvArea = document.querySelector('#movArea');
        		for(let mvEl of movieEls){
        			mvEl.classList.remove('selectList');
        			mvEl.classList.remove('unselectList');
        			if(mvCodeList.includes(mvEl.getAttribute('id'))){
        				//console.log("예매 가능 극장");
        				// 선택 영화 예매 가능 극장
        				mvEl.classList.add('selectList');
        			} else {
        				//console.log("예매 불가 극장");
        				// 선택 영화 예매 불가 극장
        				mvEl.classList.add('unselectList');
        				mvArea.appendChild(mvEl); // 복사가 아닌 내려쓰기
        			}
        		}
        	}
        	function getMovieList(thcode){
        		let movieList = [];
        		$.ajax({
        			type : "get",
        			url : "getMovieList_json",
        			data : {'selThcode' : thcode},
        			async : false,
        			dataType : "json",
        			success : function(result){
        				movieList = result;
        			}
        		});
        		return movieList;
        	}
        </script>
        <script type="text/javascript">
        	function getReserveScheduleDateList(){
        		console.log('예매 가능 날짜 목록 조회');
        		//console.log("영화코드 : "+reserve_mvcode);
  				//console.log("극장코드 : "+reserve_thcode);
  				let dateList = [];
  				$.ajax({
  					type : "get",
  					url : "getScheduleDateList_json",
  					data : {'mvcode':reserve_mvcode,'thcode' : reserve_thcode},
  					async : false,
  					dataType : 'json',
  					success : function(result){
  						console.log(result);
  						dateList = result;
  					}
  				});
  				//<div class="selectList selEl" onclick="dateClick(this,'${sc.scdate}')" >${sc.scdate}</div> 				
  				let dateDiv = document.querySelector('#dateArea');
  				dateDiv.innerHTML = "";
  				let nowMM = null;
  				for(let dateEl of dateList){  					
  					let dateArr = dateEl.scdate.split("/"); 					
  					if(nowMM != dateArr[1]){ // ?월 출력
  						nowMM = dateArr[1]; 	
  						let mmDiv = document.createElement('div');
  						mmDiv.innerText = dateArr[1]+"월";
  						mmDiv.classList.add('text-center');
  						dateDiv.appendChild(mmDiv);
  					}
  					let datDiv = document.createElement('div'); // ?일 출력
  					//datDiv.innerText = dateEl.scdate;
  					datDiv.classList.add('selectList');
  					datDiv.classList.add('selEl');
  					datDiv.classList.add('text-center');
  					datDiv.innerText = dateArr[2]+"일";
  					datDiv.addEventListener('click',function(e){
  						reserve_sctime = null;
  			        	reserve_schall = null;
  						//if(timeCheck == '1'){
  							//let reloadThCheck = confirm('이미 날짜를 선택중입니다. \n계속하시겠습니까?');
                			//if(reloadThCheck){
                				//location.reload();
                			//}	
  						//} else {  				
  						document.querySelector('#selTime').innerText = "시간";
  						document.querySelector('#selTheater').innerText = "상영관";
  						addSelectStyle(e.target); // 이벤트 발생 요소
  						document.querySelector('#selDate').innerText = dateArr[1]+"월"+dateArr[2]+"일";
  						dateCheck = '1';  	
  						reserve_scdate = dateEl.scdate
  						//console.log(dateCheck);
  						getReserveTimeList(reserve_mvcode, reserve_thcode, reserve_scdate);
  						//}
  					});
  					dateDiv.appendChild(datDiv);
  				}
  				
  				//changeDateList(dateList);
        	}   
        	function getReserveTimeList(){
        		let timeList = [];
  				$.ajax({
  					type : "get",
  					url : "getScheduleTimeList_json",
  					data : {'mvcode':reserve_mvcode,'thcode' : reserve_thcode,'scdate':reserve_scdate},
  					async : false,
  					dataType : 'json',
  					success : function(result){
  						console.log(result);
  						timeList = result;
  					}
  					
  				});
  				//let timeDiv = document.querySelector('#timeArea');
  				timeDiv.innerHTML = "";  	
  				let titleDiv = document.createElement('div');
  				titleDiv.classList.add('text-center');
  				titleDiv.innerText = reserve_scdate;
  				timeDiv.appendChild(titleDiv);
  				let hallname = null;
  				for(let timeEl of timeList){  		
  					if(hallname != timeEl.schall){
  						let hrEl = document.createElement('hr');
  						timeDiv.appendChild(hrEl);
  						hallname = timeEl.schall;
  						let hallDiv = document.createElement('div'); 		  				
  		  				hallDiv.innerText = timeEl.schall;  		  				
  		  				timeDiv.appendChild(hallDiv); 		  				
  					}
  					let timDiv = document.createElement('div'); 				
  					timDiv.classList.add('selectList');
  					timDiv.classList.add('selEl');
  					timDiv.classList.add('text-center');
  					timDiv.classList.add('mx-1');
  					timDiv.classList.add('d-inline-block');
  					timDiv.innerText = timeEl.scdate;
  					timDiv.addEventListener('click',function(e){
  						addSelectStyle(e.target); // 이벤트 발생 요소
  						document.querySelector('#selTime').innerText = timeEl.scdate;
  						document.querySelector('#selTheater').innerText = timeEl.schall;
  						reserve_sctime = reserve_scdate+" "+timeEl.scdate
  						reserve_schall = timeEl.schall;  						
  						//timeCheck = '1';
  						//dateCheck = '1';  	
  						//reserve_scdate = dateEl.scdate
  						//console.log(dateCheck);
  						//getReserveTimeList(reserve_mvcode, reserve_thcode, reserve_scdate);
  					});
  					timeDiv.appendChild(timDiv);
  				}
        	}       	
        </script>
        <c:if test="${param.mvcode != null }">       
        <script type="text/javascript">
        	// 예매 버튼 클릭 시 해당 영화 클릭된 상태      	
        	document.querySelector("#${param.mvcode}").click();    
        	document.querySelector("#${param.mvcode}").focus();    
        </script>
        </c:if>
    </body>
</html>
