<%@page import="data.dao.GuestDao"%>
<%@page import="data.dto.GuestDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	//db에 저장할 아이디 얻기
	String myid=(String)session.getAttribute("myid");
	GuestDto lastDto=new GuestDto();
	GuestDao dao=new GuestDao();
	
	
	

	//실제경로
	String realpath=getServletContext().getRealPath("/save");
	System.out.println(realpath);
	
	int uploadSize=1024*1024*5;
	
	MultipartRequest multi=null;
	
	try{
		multi=new MultipartRequest(request,realpath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
	
		//주의: request가 아닌 multi 변수로 모든 폼데이터를 읽어야 한다
		
		String content=multi.getParameter("content");
		String photoname=multi.getFilesystemName("photo");
		String num=multi.getParameter("num");
		String currentPage=multi.getParameter("currentPage");
		
		lastDto=dao.getData(num);
		
		GuestDto dto=new GuestDto();
		dto.setNum(num);
		dto.setMyid(myid);
		dto.setContent(content);
		
		//기존 사진 가져오기
		lastDto.getPhotoname();
		if(dto.getPhotoname()==null){
			dto.setPhotoname(lastDto.getPhotoname());
		}
		else{
			dto.setPhotoname(photoname);
		}
		
		dao.updateGuest(dto);
		
		response.sendRedirect("../index.jsp?main=guest/guestlist.jsp?currentPage="+currentPage);
		
	}catch(Exception e){
		
	}


%>
</body>
</html>