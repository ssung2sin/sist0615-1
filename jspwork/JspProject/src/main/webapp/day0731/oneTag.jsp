<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h3>oneInclude.jsp를 include하기</h3>
	<jsp:include page="oneInclude.jsp">
		<jsp:param value="안녕 오늘은 월요일이야!!" name="msg"/>
		<jsp:param value="../image/cartoonImg/16.png" name="imgname"/>
	</jsp:include>
</body>
</html>