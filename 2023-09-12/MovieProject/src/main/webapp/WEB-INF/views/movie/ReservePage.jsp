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
    			height: 400px;
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
							<div class="selectList selEl" id="${mv.mvcode }" onclick="movieClick(this,'${mv.mvcode}','${mv.mvposter }')">${mv.mvtitle }</div>
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
            	</div>
            	<div class="col-lg-3 col-md-6">
            	<div class="title">시간</div>
            	</div>
            </div>
            
            <div class="row">
            	<div class="col-lg-3">
            		<div class="card mb-4">
            			<div class="card-header text-center" >선택영화</div>
            			<div class="card-body p-2" style="text-align: center;">
            				<p class="card-text" id="selTitle"></p>
            				<img class="selMoviePoster" id="selPoster" 
            				src="">
            			</div>
            		</div>
            	</div>
            	<div class="col-lg-3">
            		<div class="card mb-4">
            			<div class="card-header text-center" >선택극장</div>
            			<div class="card-body p-2" style="text-align: center;">     			
            			<p class="card-text" id="selName"></p>
            				<img class="selTheaterImg" id="selThImg" 
            				src="">
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
        	let thCheck = null;
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
		        			// 1. 선택 항목 출력	        			
				        	document.querySelector('#selTitle').innerText = selmvobj.innerText;
				        	document.querySelector('#selPoster').setAttribute('src',mvposter);
				        	// 2. 선택 항목 style 변경
				        	addSelectStyle(selmvobj);	        
	        			} else if(mvCheck != null) { 	        				
	        				let reloadMvCheck = confirm('이미 영화를 선택중입니다.\n계속하시겠습니까?');
	            			if(reloadMvCheck){
	            				location.reload();
	            			}
	        			} else {
	        				// 1. 선택 항목 출력	        			
				        	document.querySelector('#selTitle').innerText = selmvobj.innerText;
				        	document.querySelector('#selPoster').setAttribute('src',mvposter);
				        	// 2. 선택 항목 style 변경
				        	addSelectStyle(selmvobj);	     
	        			}
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
        		console.log("selThobj : "+selThobj);
        		console.log("thcode : "+thcode);
        		if(selThobj.classList.contains('unselectList')){
        			console.log('예매 불가능 극장 선택');
        			let reloadCheck = confirm('선택한 극장에 원하는 상영스케쥴이 없습니다. \n 계속하시겠습니까?');
        			if(reloadCheck){
        				location.reload();
        			}
        		} else {
        			console.log('예매 가능 극장 선택');       				        				
        			if(mvCheck == null){       	
        				// 1. 선택 항목 출력
		        		document.querySelector('#selName').innerText = selThobj.innerText;
		        		document.querySelector('#selThImg').setAttribute('src',thimg);
		        		// 2. 선택 항목 style 변경
		        		addSelectStyle(selThobj);		
	        			// 3. 선택 극장에서 예매 가능 영화 목록 조회
	        			let mvList = getMovieList(thcode);   
	        			//console.log(mvList.length);
	        			changeMovieList(mvList);	        			        						        		      				        			
        			} else {
        				if(thCheck == '2'){       					
	        				// 1. 선택 항목 출력       				
			        		document.querySelector('#selName').innerText = selThobj.innerText;
			        		document.querySelector('#selThImg').setAttribute('src',thimg);
			        		// 2. 선택 항목 style 변경
			        		addSelectStyle(selThobj);   	
        				} else if(thCheck != null){
        					let reloadThCheck = confirm('이미 극장을 선택중입니다. \n계속하시겠습니까?');
                			if(reloadThCheck){
                				location.reload();
                			}
        				} else {
        					// 1. 선택 항목 출력       				
			        		document.querySelector('#selName').innerText = selThobj.innerText;
			        		document.querySelector('#selThImg').setAttribute('src',thimg);
			        		// 2. 선택 항목 style 변경
			        		addSelectStyle(selThobj);   	
        				}
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
    </body>
</html>
