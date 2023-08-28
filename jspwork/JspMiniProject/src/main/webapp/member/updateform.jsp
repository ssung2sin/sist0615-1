<%@page import="java.util.StringTokenizer"%>
<%@page import="data.dto.MemberDto"%>
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
<script type="text/javascript">
$(function(){

	//id중복체크
	$("#btncheck").click(function() {
		
		//id읽기
		var id=$("#id").val();
		//alert(id);
		
		$.ajax({
			
			type:"get",
			url:"member/idsearch.jsp",
			dataType:"json",
			data:{"id":id},
			success:function(data){
				
				//alert(data.count);
				if(data.count==1){
					//alert("이미 가입된 아이디입니다.\n다시 입력해주세요");
					$("span.idsuccess").text("fail").css("color","red");
					$("#id").val("");
					$("#id").focus();
				}else{
					//alert("사용 가능한 아이디입니다.");
					$("span.idsuccess").text("success").css("color","green");

				}
			}
		});
	});	
	//선택 이메일 주소 넣기..혹은 직접입력
	$("#selemail").change(function(){
		var e=$(this).val();
		
		if(e=='-'){
			$("#email2").val("");
			$("#email2").focus();
		}else{
			$("#email2").val(e);
		}
	})
	
});
function check(f){
	alert(f.pass.value);
	if(f.pass.value!=f.pass2.value){
		alert("비밀번호가 서로 다릅니다.");
		f.pass.value="";
		f.pass2.value="";
		
		return false; //액션이 호출되지 않는다.
	}
}

</script>
<%
	String num=request.getParameter("num");

	MemberDao dao=new MemberDao();
	
	MemberDto dto=new MemberDto();
	
	dto=dao.getMember(num);
	
	//이메일 구분하기(@기준으로)_#1
	/* int idx=dto.getEmail().indexOf('@');
	String email1=dto.getEmail().substring(0, idx); //0번부터 idx 앞까지!
	String email2=dto.getEmail().substring(idx+1); //idx 다음부터 끝까지 */
	
	//@을 구분자로 분리_#2
	StringTokenizer st=new StringTokenizer(dto.getEmail(),"@");
	String email1=st.nextToken();
	String email2=st.nextToken();
%>
</head>
<body>
<form action="member/updateproc.jsp" method="post" onsubmit="return check(this)">
	<input type="hidden" name="num" value=<%=num %>>
	<table class="table table-bordered" style="width: 500px;">
		<caption align="top"><b>회원수정</b></caption>
		<tr>
			<th style="width: 100px; background-color: #E2E2E2;">아이디</th>
			<td>
				<input type="text" name="id" id="id" class="form-group" disabled
				required="required" style="width: 120px;" value="<%=dto.getId() %>">
			</td>
		</tr>
		<tr>
			<th style="width: 100px; background-color: #E2E2E2;">비밀번호</th>
			<td>
				<input type="password" name="pass" class="form-group"
				required="required" placeholder="비밀번호" style="width: 120px;">
				<input type="password" name="pass2" class="form-group"
				required="required" placeholder="비밀번호" style="width: 120px;">
			</td>
		</tr>
		<tr>
			<th style="width: 100px; background-color: #E2E2E2;">이름</th>
			<td>
				<input type="text" name="name" class="form-group" value="<%=dto.getName() %>"
				required="required" placeholder="이름" style="width: 150px;">
			</td>
		</tr>
		<tr>
			<th style="width: 100px; background-color: #E2E2E2;">핸드폰</th>
			<td>
				<input type="text" name="hp" class="form-group" value="<%=dto.getHp() %>"
				required="required" placeholder="핸드폰번호" style="width: 200px;">
			</td>
		</tr>
		<tr>
			<th style="width: 100px; background-color: #E2E2E2;">주소</th>
			<td>
				<input type="text" name="addr" class="form-group" value="<%=dto.getAddr() %>"
				required="required" placeholder="주소" style="width: 350px;">
			</td>
		</tr>
		<tr>
			<th style="width: 100px; background-color: #E2E2E2;">이메일</th>
			<td>
				<input type="text" name="email1" class="form-gruop"
				required="required" style="width: 120px;" value="<%=email1 %>">
				<b>@</b>
				<input type="text" name="email2" id="email2" required="required" style="width: 120px;"
				value="<%=email2 %>">
				<select id="selemail">
					<option value="-">직접입력</option>
					<option value="naver.com">네이버</option>
					<option value="gmail.com">구글</option>
					<option value="hanmail.net">다음</option>
					<option value="nate.com">네이트</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="btn btn-outline-info"
				style="width: 100px;">회원수정</button>
			</td>
		</tr>
	</table>

</form>
</body>
</html>