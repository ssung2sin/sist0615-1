<%@page import="data.dao.MemberDao"%>
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
<%
	//절대경로보기
	String root=request.getContextPath();
	String loginok=(String)session.getAttribute("loginok");
	String myid=(String)session.getAttribute("myid");
	
	MemberDao dao=new MemberDao();
	String name=dao.getName(myid);
%> 
<body>
<a href="<%=root%>" style="color: black;"><img alt="" src="<%=root%>/image/sub.jpg" style="width: 200px"></a>
JSP & JQuery Mini Project
<%
if(loginok!=null){
%>
<span><b><%=name %>님 환영합니다!</b></span>
<span>

<button type="button" class="btn btn-outline-danger"
onclick="location.href='login/logoutaction.jsp'">로그아웃</button>
<%
}else{
%>
<button type="button" class="btn btn-outline-success"
onclick="location.href='index.jsp?main=login/loginmain.jsp'">로그인</button>
<%
}
%>
</span>
</body>
</html>