<%@page import="data.dto.MemberDao"%>
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
<div style="margin: 100px 200px;">
	<img alt="" src="image/cat123.gif" style="width: 200px; align: left;">
	
	<%
	//세션으로 부터 아이디를 얻는다
	String myid=(String)session.getAttribute("myid");
	
	//db에 있는 이름 가져온다
	MemberDao dao=new MemberDao();
	String name=dao.getName(myid);
	%>
	<br><br>
	<b><%=name %>님, 환영합니다!</b>
	<button type="button" class="btn btn-outline-danger"
	onclick="location.href='login/logoutaction.jsp'">로그아웃</button>

</div>
</body>
</html>