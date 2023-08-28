<%@page import="data.dao.AnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idx=request.getParameter("idx");
	String cnt=request.getParameter("cnt");
	//dao
	AnswerDao dao=new AnswerDao();
	dao.deleteAnswer(idx);
	
	session.setAttribute("cnt",cnt);
	session.setAttribute("toggle","yes");
%>