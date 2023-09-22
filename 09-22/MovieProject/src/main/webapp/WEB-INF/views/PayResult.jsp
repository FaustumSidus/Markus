<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		let payResult = '${payResult}';
		if(payResult == 'Y'){
			// INSERT, 결제 성공 -> 부모창에 예매 완료
			window.opener.reserveResult_success();
		} else {
			// INSERT 성공, 결제 실패 -> 부모창에 예매 실패, DELETE 
			//window.opener.alert('예매 실패');
			window.opener.failReserve();
			// DELETE
		}
		window.close();
	</script>
</head>
<body>
</body>
</html>