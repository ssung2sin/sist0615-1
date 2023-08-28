
<%@page import="data.dao.GuestDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	//num
 	String num=request.getParameter("num");
	//dao
	GuestDao dao=new GuestDao();
	
	//num에 해당하는 chu 증가
	dao.updateChu(num);
	
	//증가된 chu 값을 json형식으로 변환
	int chu=dao.getData(num).getChu();
	
	JSONObject ob=new JSONObject();
	ob.put("chu",chu);
	
%>
<%=ob.toString()%>