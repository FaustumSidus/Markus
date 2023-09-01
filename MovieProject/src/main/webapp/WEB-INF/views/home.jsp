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
    		.ageInfo{
			    display: inline-block;
			    text-align: center;			   
			    border-radius: 10px;
			    padding: 5px;
			    font-weight: bold;
			    color: white;
			    position: absolute;
			    top: 5px;
			    left: 5px;
    		}
    		.gradeALL{
    			background-color: green; 
    		}
    		.grade12{
    			background-color: yellow;
    		}
    		.grade15{
    			background-color: coral;
    		}
    		
    		.grade18{
    			background-color: red;
    		}
    		.rankMov{
    			background-color: red;
    			margin-bottom: 5px;
    			border-radius: 5px;
    			text-align: center;
    			color: white;
    			font-size: 18px;
    			font-weight: bold;
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
                    <h1 class="fw-bolder">메인 페이지</h1>
                    <p class="lead mb-0">영화 랭킹 1위~6위 목록 출력</p>
                </div>
            </div>
        </header>
        <!-- Page content-->
        <div class="container">
            <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">                   
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                    
	                	<c:forEach items="${rankMovList}" var="rank" varStatus="status">	                
	                        <div class="col-lg-4 col-md-6">
	                        	<div class="rankMov">
	                        		No.${status.index+1 }
	                        	</div>
	                            <!-- Blog post-->                            
	                            <div class="card mb-4">
	                                <a href="${pageContext.request.contextPath }/detailMovie?mvcode=${rank.mvcode}"><img class="card-img-top" src="${rank.mvposter }" alt="..." /></a>
	                                <span class="ageInfo grade${rank.mvstate }">${rank.mvstate }</span>
	                                <div class="card-body">
	                                    <div class="small text-muted">예매율</div>                                 
	                                    <h2 class="card-title h4" style="overflow: hidden; white-space: nowrap;" title="${rank.mvtitle }">${rank.mvtitle}</h2>  
	                                    <h2 class="card-title h4">${rank.mvopen}</h2>                                  
	                                    <a class="btn btn-danger" href="#!">예매하기</a>
	                                </div>
	                            </div>                           
	                        </div>                   
	                    </c:forEach>
                    
                    </div>
                    <!-- Pagination-->
                    <nav aria-label="Pagination">
                        <hr class="my-0" />
                        <ul class="pagination justify-content-center my-4">
                            <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Newer</a></li>
                            <li class="page-item active" aria-current="page"><a class="page-link" href="#!">1</a></li>
                            <li class="page-item"><a class="page-link" href="#!">2</a></li>
                            <li class="page-item"><a class="page-link" href="#!">3</a></li>
                            <li class="page-item disabled"><a class="page-link" href="#!">...</a></li>
                            <li class="page-item"><a class="page-link" href="#!">15</a></li>
                            <li class="page-item"><a class="page-link" href="#!">Older</a></li>
                        </ul>
                    </nav>
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header" style="text-align: center;">CGV-X를 더 안전하고 편리하게 이용하세요</div>
                        <div class="card-body">
                            <div class="input-group">                                                              
                            	<a href="${pageContext.request.contextPath }/memberLoginForm" class="btn btn-primary" style="width:100%;">로그인</a>
                            </div>
                        </div>
                    </div>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header">회원메뉴</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">예매내역</a></li>
                                        <li><a href="#!">HTML</a></li>
                                        <li><a href="#!">Freebies</a></li>
                                    </ul>
                                </div>
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">회원정보</a></li>
                                        <li><a href="#!">로그아웃</a></li>
                                        <li><a href="#!">Tutorials</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header">Side Widget</div>
                        <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use, and feature the Bootstrap 5 card component!</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
    </body>
<script type="text/javascript">
	//let rankMovList = "${rankMovList}";
	//console.log("rankMovList : "+rankMovList);
</script>
</html>
