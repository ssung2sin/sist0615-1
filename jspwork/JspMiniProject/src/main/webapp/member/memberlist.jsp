<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.MemberDto"%>
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
<%
	MemberDao dao=new MemberDao();
	List<MemberDto> list=dao.getAllMembers();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	int no=0;

%>
</head>
<body>
	<table class ="table table-bordered" style="width: 1000px;">
		<caption align="top"><b>전체 회원 목록</b></caption>
		<tr>
			<th style="width: 80px;">번호</th>
			<th style="width: 100px;">회원명</th>
			<th style="width: 120px;">아이디</th>
			<th style="width: 200px;">휴대폰번호</th>
			<th style="width: 300px;">주소</th>
			<th style="width: 250px;">이메일</th>
			<th style="width: 200px;">가입일</th>
			<th style="width: 150px;">삭제</th>
		</tr>
		<%
		for(MemberDto dto:list){
			%>
			<tr>
				<td><%=list.size()-(no++) %></td>
				<td><%=dto.getName() %></td>
				<td><%=dto.getId() %></td>
				<td><%=dto.getHp() %></td>
				<td><%=dto.getAddr() %></td>
				<td><%=dto.getEmail() %></td>
				<td><%=sdf.format(dto.getGaipday()) %></td>
				<td><button type="button" class="btn btn-outline-danger btn-sm"
				onclick="delfunc(<%=dto.getNum()%>)">강퇴</button></td>
			</tr>
			<%
		}
		%>
	</table>
	<script type="text/javascript">
	function delfunc(num){
		var y=confirm("정말 강퇴하겠습니까?");
		if(y){
		alert("강퇴처리되었습니다.");
		location.href="member/memberdelete.jsp?num="+num;
		}
		else{
			alert("취소되었습니다.");
		}
	}
	</script>
</body>
</html>