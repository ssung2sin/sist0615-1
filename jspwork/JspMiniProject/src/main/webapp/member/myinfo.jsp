<%@page import="data.dto.MemberDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
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
<%
	MemberDao dao=new MemberDao();
	List<MemberDto> list=dao.getAllMembers();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String myid=(String)session.getAttribute("myid");
	int no=0;

%>
</head>
<body>
	
	<table class="table table-bordered" style="width: 900px;">
		<%
		for(MemberDto dto:list){
			if(myid.equals(dto.getId())){
		
		%>
			<tr>
				<td rowspan="6" style="width: 350px; height: 300px;" align="center" valign="middle"><img alt="" src="image/cat123.gif" style="width: 300px;"></td>
				<td>이름: <%=dto.getName()%></td>
				<td rowspan="6" align="center" valign="middle" style="width: 200px;">
					<button type="button" class="btn btn-outline-warning btn-sm" onclick="location.href='index.jsp?main=member/updateform.jsp?num=<%=dto.getNum()%>'" style="width: 50px;">수정</button><br><br>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="funcdel(<%=dto.getNum() %>)" style="width: 50px;">강퇴</button>
				</td>
			</tr>
			<tr>
				<td>아이디: <%=dto.getId() %></td>
			</tr>
			<tr>
				<td>핸드폰: <%=dto.getHp() %></td>
			</tr>
			<tr>
				<td>주소: <%=dto.getAddr() %></td>
			</tr>
			<tr>
				<td>이메일: <%=dto.getEmail() %></td>
			</tr>
			<tr>
				<td>가입일:<%=sdf.format(dto.getGaipday()) %></td>
			</tr>			
			
		<%}
		}
		%>	
	</table>

</body>

</html>