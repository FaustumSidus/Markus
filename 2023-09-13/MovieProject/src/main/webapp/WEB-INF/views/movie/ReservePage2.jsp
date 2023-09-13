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
    			background-color: pink;
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
						</div>
					</div>
            	</div>
            	
            	<div class="col-lg-3 col-md-6 p-1">
            		<div class="title">극장</div>
	            	<div class="card mb-4">
						<div class="card-body p-2" id="thArea">	
						<c:forEach items="${th}" var="th">
							<div class="selectList">${th.thname }</div>
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
            			<div class="card-body p-2" style="text-align: center;">
            				<p class="card-text" id="selTitle"></p>
            				<img class="selMoviePoster" id="selPoster" 
            				src="">
            			</div>
            		</div>
            	</div>
            	<div class="col-lg-3">
            		<div class="card mb-4">
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
        	$(document).ready(function(){
        		//1. 예매 가능 영화 목록 조회 - json
        		//let mvList = getReserveMovieList();
        		//2. 예매 가능 극장 목록 조회 - json
        		//3. 영화목록 출력
        		printMovieList(getReserveMovieList('ALL'));       		
        		//4. 극장목록 출력
        		printTheaterList(getReserveTheaterList('ALL'));
        	});
        </script>
        <script type="text/javascript">
       		function getReserveMovieList(selectTheaterCode){
       			console.log('예매 가능 영화 목록 조회요청');  
       			let movieList = '';
       			$.ajax({
       				type : 'get',
       				url : 'getMovieList_json',
       				data : {'selThcode' : selectTheaterCode},
       				dataType : 'json',
       				async : false,
       				success : function(result){
       					console.log("영화목록_json");
       					console.log(result);
       					movieList = result;
       				}
       			});
       			return movieList;
       		}
       		function getReserveTheaterList(selectMovieCode){
       			console.log('예매 가능 극장 목록 조회요청');   
       			let theaterList = '';
       			$.ajax({
       				type : 'get',
       				url : 'getTheaterList_json',
       				data : {'selMvcode' : selectMovieCode},
       				dataType : 'json',
       				async : false,
       				success : function(result){
       					console.log("극장목록_json");
       					console.log(result);
       					theaterList = result;
       				}
       			});
       			return theaterList;
       		}
       		let reserve_mvcode = null; // 선택 영화 코드 저장 변수
       		let reserve_thcode = null; // 선택 극장 코드 저장 변수
       		function printMovieList(movList){
       			console.log('영화 목록 출력');
       			let movArea_Div = document.querySelector('#movArea');  
       			movArea_Div.innerHTML = "";
       			for(let mvinfo of movList){
       				let mv_Div = document.createElement('div');
       				mv_Div.innerText = mvinfo.mvtitle;
       				mv_Div.classList.add('selectList'); 
       				mv_Div.classList.add('selEl');   
       				mv_Div.addEventListener('click', function(e){       			
	       			reserve_mvcode = 'f'+mvinfo.mvcode;	       					   					
       				// 영화목록에 있는 모든 강조 스타일 제거      					     					
	       			removeSelectStyle('movArea');
	       			// 선택된 영화 강조 STYLE 추가   
       				//2. 선택 정보 출력(제목, 포스터)
	       			document.querySelector('#selTitle').innerText = mvinfo.mvtitle;
	       			document.querySelector('#selPoster').setAttribute('src',mvinfo.mvposter);			     					
	       			mv_Div.classList.add('selectObj');       				      						
       				if(reserve_thcode == null){
       					//1. 극장목록 조회 및 출력(영화코드)
	       				let thList = getReserveTheaterList(mvinfo.mvcode);
	           			printTheaterList(thList);
       				}	
       					
       				})
	       			movArea_Div.appendChild(mv_Div);
       			}
       			
       			
       		}
			function printTheaterList(theList){
				
				console.log('극장 목록 출력');				
       			let theArea_Div = document.querySelector('#thArea');   
       			theArea_Div.innerHTML = "";
       			for(let thinfo of theList){
       				let th_Div = document.createElement('div');
       				th_Div.innerText = thinfo.thname;
       				th_Div.classList.add('selEl');   
       				th_Div.classList.add('selectList');  
					th_Div.addEventListener('click',function(e){
					reserve_thcode = thinfo.thcode;	
					removeSelectStyle('thArea');
					th_Div.classList.add('selectObj'); 
					document.querySelector('#selName').innerText = thinfo.thname;
	       			document.querySelector('#selThImg').setAttribute('src',thinfo.thimg);												
						if(reserve_mvcode == null){     						
	       					let mvList = getReserveMovieList(thinfo.thcode);
	       					printMovieList(mvList);													 					
       					}			
						
       				})
	       			theArea_Div.appendChild(th_Div);
       			}
				
       		}
			function removeSelectStyle(areaId){
				let areaDiv = document.querySelectorAll('#'+areaId+">.selEl");
				for(let el of areaDiv){
					el.classList.remove('selectObj');
				}											
			}
        </script>
        <script type="text/javascript">
    		let movAreaEl = document.querySelectorAll('#movArea div.selectList');
    		
    		for(let movEl of movAreaEl){
				movEl.addEventListener('click',function(e){					
					console.log(movEl.innerText);
				})    			
    		}
    	</script>
    </body>
</html>
