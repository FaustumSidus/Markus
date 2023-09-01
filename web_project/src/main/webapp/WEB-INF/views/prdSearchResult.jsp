<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.prdTitle{
		width: 400px;
		white-space: nowrap;
		overflow: hidden;
		margin: 0;
		display: inline-block;
	}	
	tr{
		border: 1px solid black;
		border-collapse: collapse;
	}
	td>a{
		padding: 3px;
		text-align: center;
		text-decoration: none;
	}
	.prdArea{
		height: 500px;
		overflow: scroll;
		border: 2px solid black;
		padding: 3px;
		margin: 3px;
		margin-top: 90px;
	}
	.prdDiv{
		display: flex;
	}
	table{
		border: 1px solid black;
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<h1 style="text-align: center;">prdSearchResult.jsp</h1>
	 <div class="prdDiv">
	  	<div class="prdArea" style="margin-left: auto;">	
	  	<h1 style="text-align: center;">coopang</h1>
	 	<table>
	 		<thead>
	 			<tr>
	 				<th>쇼핑몰</th>	 			
	 				<th>상품이름</th>	
	 				<th>
	 					<select style="font-weight: bold;" onchange="prdSort(this.value, 'coopang')">
				        <option value="price_desc">상품가격↑</option>
				        <option value="price_asc">상품가격↓</option>
				    	</select>
	 				</th>
	 			</tr>
	 		</thead>
	 		<tbody class="prdBody_coopang">
	 			<c:forEach items="${prdList_coopang }" var="cList">
	 				<tr>
	 					<td>${cList.prdSite }</td>
	 					<td><a class="prdTitle" title="${cList.prdName }" href="${cList.prdUrl }">${cList.prdName }</a></td>
	 					<td class="prdPrice">${cList.prdPrice }</td>
	 				</tr>
	 			</c:forEach>
	 		</tbody>
	 	</table>
	 </div>
	 
	 <div class="prdArea" style="margin-right: auto;">
	 	<h1 style="text-align: center;">gmarket</h1>
	 	<table>
	 		<thead>
	 			<tr>
	 				<th>쇼핑몰</th>	 			
	 				<th>상품이름</th>		
	 				<th>
	 				<select style="font-weight: bold;" onchange="prdSort(this.value, 'gmarket')">
			        <option value="price_desc">상품가격↑</option>
			        <option value="price_asc">상품가격↓</option>
			    	</select>
			    	</th>
	 			</tr>
	 		</thead>
	 		<tbody class="prdBody_gmarket">
	 			<c:forEach items="${prdList_gmarket }" var="gList">
	 				<tr>
	 					<td>${gList.prdSite }</td>
	 					<td><a class="prdTitle" title="${gList.prdName }" href="${gList.prdUrl }">${gList.prdName }</a></td>	 					
	 					<td class="prdPrice">${gList.prdPrice }</td>
	 				</tr>
	 			</c:forEach>
	 		</tbody>
	 	</table>
	 </div>
	</div>
</body>
<script type="text/javascript">
// 정렬기능(가격, 리뷰순)
	/*function prdSort2(sortOption){
		let tbody_tag = sortOption.parentElement
							.parentElement
							.parentElement
							.nextElementSibling;
		let prdList_arr = Array.from(tbody_tag.children);
		let prdSort = [];
		prdSort[0] = prdList_arr.shift();// 0번 인덱스 이동
		for(let prd of prdList_arr){
			let prdPrice = Number(prd.querySelector('.prdPrice').innerText);
			let idx = -1;
			for(let sortIdx in prdSort){
				let sortPrice = Number(prdSort[sortIdx].querySelector('.prdPrice').innerText);
				console.log(sortPrice+" :: "+prdPrice);
				let sortCheck = false;
				switch(sortOption){
				case "price_desc":
						sortCheck = prdPrice > sortPrice;
						break;
				case "price_asc":
						sortCheck = prdPrice < sortPrice;
						break;
				}
				if(sortCheck){
					idx = sortIdx;
					break;
				}
			}
			if(idx > -1){
				prdSort.splice(idx,0,prd);
			} else {
				prdSort.push(prd);
			}
		}
		console.log(prdSort);
		tbody_tag.innerHTML = "";
		for(let item of prdSort){
			tbody_tag.appendChild(item);
		}
	}
	*/
	function prdSort(sortOption, store){
	let prdList = "";
	switch(store){
	case "coopang":
		prdList = document.querySelectorAll('.prdBody_coopang>tr');
		break;
	case "gmarket":
		prdList = document.querySelectorAll('.prdBody_gmarket>tr');
		break;
	}
	let prdList_arr = Array.from(prdList);
	let prdSort = [];
	prdSort[0] = prdList_arr.shift();// 0번 인덱스 이동
	for(let prd_arr of prdList_arr){
		let prdPrice_arr = Number(prd_arr.querySelector('.prdPrice').innerText);
		let idx = -1;
		for(let sortIdx in prdSort){
			let prdPrice_sort = Number(prdSort[sortIdx].querySelector('.prdPrice').innerText);
			//console.log(prdPrice_sort+" :: "+prdPrice_arr);
			let sortCheck = false;
			switch(sortOption){
				case "price_desc":
					sortCheck = prdPrice_arr > prdPrice_sort;
					break;
				case "price_asc":
					sortCheck = prdPrice_arr < prdPrice_sort;
					break;
			}
			if(sortCheck){
				idx = sortIdx;
				break;
			}
		} // sortIdx 종료
		if(idx > -1){
			prdSort.splice(idx,0,prd_arr);
		} else {
			prdSort.push(prd_arr);
		}
	} // prd_arr 종료
	let tbodyTag = "";
	switch(store){
	case "coopang":
		tbodyTag = document.querySelector('.prdBody_coopang');
		break;
	case "gmarket":
		tbodyTag = document.querySelector('.prdBody_gmarket');
		break;
	}
	tbodyTag.innerHTML = "";
	for(let item of prdSort){
		tbodyTag.appendChild(item);
	}
}
</script>
</html>