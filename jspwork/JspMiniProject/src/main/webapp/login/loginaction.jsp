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
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	String saveId=request.getParameter("saveId"); //체크안하면 null
	
	MemberDao dao=new MemberDao();
	
	boolean b=dao.isIdPass(id, pass);
	
	//아이디와 비번이 맞으면 3개의 세션을 저장하고 로그인 메인으로 이동
	if(b){
		session.setMaxInactiveInterval(60*60*3);
		session.setAttribute("loginok", "yes");
		session.setAttribute("myid", id);
		session.setAttribute("saveok", saveId==null?null:"yes");
		
		//로그인메인으로 이동
		response.sendRedirect("../index.jsp?main=login/loginmain.jsp");

	}else{
		%>
		<script type="text/javascript">
		alert("아이디와 비밀번호가 일치하지 않습니다.");
		history.back();
		</script>
		<%
	}
%>
</body>
</html>