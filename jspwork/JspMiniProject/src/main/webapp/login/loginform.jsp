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
String saveok=(String)session.getAttribute("saveok");

String myid="";
if(saveok!=null){
	myid=(String)session.getAttribute("myid");
	
}
%>
<body>
	<div style="margin: 100px 200px;">
		<form action="login/loginaction.jsp" method="post">
			<table>
				<caption align="top"><b>세션로그인</b></caption>
				<tr>
					<th valign="middle" align="center">아이디</th>
					<td>
						<input type="text" class="form-control" name="id"
						required="required" placeholder="아이디 입력" value="<%=myid%>">
					</td>				
				</tr>
				<tr>
					<th valign="middle" align="center">비밀번호</th>
					<td>
						<input type="password" class="form-control" name="pass"
						required="required" placeholder="비밀번호 입력">
					</td>				
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="로그인" class="btn btn-outline-success">
						<input type="checkbox" name="saveId" <%=saveok!=null?"checked":"" %>>아이디저장
					</td>				
				</tr>
			</table>
		</form>
	</div>
</body>
</html>