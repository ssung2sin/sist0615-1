<%@page import="data.dto.AnswerDto"%>
<%@page import="data.dao.AnswerDao"%>
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
<%
	request.setCharacterEncoding("utf-8");	

	String num=request.getParameter("num");
	String myid=request.getParameter("myid");
	String content=request.getParameter("content");
	String cnt=request.getParameter("cnt");
	String currentPage=request.getParameter("currentPage");
	session.setAttribute("toggle","yes");
	session.setAttribute("cnt",cnt);
	
	AnswerDao dao=new AnswerDao();
	AnswerDto dto=new AnswerDto();
	dto.setNum(num);
	dto.setMyid(myid);
	dto.setContent(content);
	
	dao.insertAnswer(dto);
	
	response.sendRedirect("../index.jsp?main=guest/guestlist.jsp?currentPage="+currentPage);

%>
</body>
</html>