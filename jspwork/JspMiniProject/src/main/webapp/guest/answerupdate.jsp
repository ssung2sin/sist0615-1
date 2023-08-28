<%@page import="data.dto.AnswerDto"%>
<%@page import="data.dao.AnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String idx=request.getParameter("idx");
	String content=request.getParameter("content");
	String cnt=request.getParameter("cnt");
	System.out.println(cnt);
	session.setAttribute("toggle","yes");
	session.setAttribute("cnt",cnt);
	
	AnswerDao dao=new AnswerDao();
	AnswerDto dto=new AnswerDto();
	
	dto.setContent(content);
	dto.setIdx(idx);
	
	dao.updateAnswer(dto);

%>