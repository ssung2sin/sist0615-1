<%@page import="data.dao.GuestDao"%>
<%@page import="data.dto.GuestDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@300&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gowun+Dodum&family=Nanum+Gothic+Coding&family=Nanum+Pen+Script&family=Orbit&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<script type="text/javascript">
	$(function(){
		$("i.camera").click(function(){
		
			$("#photo").trigger("click"); // 이벤트 강제 호출
			
		});
		
	});
	
	 function readURL(input) {
	       if (input.files && input.files[0]) {
	    	   /* console.log(input.files);
	    	   console.log(input.files[0]);
	    	   console.log(input.files && input.files[0]); */
	           var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	           reader.onload = function (e) {
	           //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	               //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 
	               $('#showing').attr('src', e.target.result);
	           }
	           //File내용을 읽어 dataURL형식의 문자열로 저장 
	           reader.readAsDataURL(input.files[0]);
	       }
	 }
	
</script>
<title>Insert title here</title>
<%
	String num=request.getParameter("num");
	System.out.println(num);
	String currentPage=request.getParameter("currentPage");
	
	GuestDao dao=new GuestDao();
	GuestDto dto=new GuestDto();
	
	dto=dao.getData(num);

%>
</head>
<body>
<!-- 이미지 미리보기 -->
<img alt="" src="<%=dto.getPhotoname()==null?"":"save/"+dto.getPhotoname() %>" id="showing" style="position: absolute; left: 800px; top: 100px; max-width: 200px;">

	<form action="guest/updateproc.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		<table class="table table-bordered" style="width: 600px;">
			<caption align="top">
				<b>방명록 등록</b>
				<i class="bi bi-camera camera" style="font-size: 1.5em;"></i>
				<input type="file" name="photo" id="photo" style="visibility: hidden;" onchange="readURL(this)">
			</caption>
			
			<tr height="100">
				<td width="520">
					<textarea style="width: 500px; height: 100px;" class="form-control" name="content" required="required"><%=dto.getContent() %></textarea>
				</td>
				<td>
					<button type="submit" class="btn btn-outline-info" style="width: 100px; height: 100px; font-size: 1.2em;">수정</button>
				</td>
			</tr>
		
		</table>
	
	
	</form>
	
</body>
</html>