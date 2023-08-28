<%@page import="data.dto.AnswerDto"%>
<%@page import="data.dao.AnswerDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="java.util.Vector"%>
<%@page import="data.dto.GuestDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.GuestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
	//로그인 상태 확인 후 입력폼 나타낼 것_ 회원만 볼 수 있게
	String loginok = (String) session.getAttribute("loginok");

	GuestDao dao = new GuestDao();

	int totalCount = dao.getTotalCount();
	int totalPage; //총 페이지 수
	int startPage; //각 블럭에서 보여질 시작 페이지
	int endPage; //각 블럭에서 보여질 끝 페이지 (밑에 목록 수)
	int startNum; //db에서 가져올 글의 시작 번호(mysql은 첫글이 0, 오라클은 1)
	int perPage = 5; // 한페이지당 몇개의 글을 보여주는지 정하는 것
	int perBlock = 5; //한 블럭당 보여질 페이지 갯수
	int currentPage; //현재블럭
	int no; //각 페이지당 출력 시작번호

	//현재페이지 읽기(단, null일 경우 1페이지)계산을 해야하므로 int로 형변환해줌
	if (request.getParameter("currentPage") == null) {
		currentPage = 1;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	//총 페이지수 구하기
	//총 글의 갯수/1페이지당 보여질 갯수로 나눠주기
	//나머지가 1개라도 있으면 무조건 1페이지 추가(7/5 1+1 => 총 2블럭)
	totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

	//각 블럭당 보여야할 시작페이지
	//perBlock=5일 경우는 현재페이지 1~5 시작:1 끝:5
	//현재페이지13 시작 11 끝 15
	startPage = (currentPage - 1) / perBlock * perBlock + 1;

	endPage = startPage + perBlock - 1;

	//만약 페이지가 23까지 있다면 25가 아니다.
	if (endPage > totalPage) {
		endPage = totalPage;
	}
	//1페이지: 시작번호=0,2페이지:5 ,3페이지:10 ...
	startNum = (currentPage - 1) * perPage;

	//각페이지 출력할 시작번호 구하기
	//총글 갯수가 23이면 1체이지 23 / 18 / 13 / 8 / 3
	no = totalCount - (currentPage - 1) * perPage;

	//페이지에서 보여질 글만 가져오기
	List<GuestDto> list=dao.getList(startNum, perPage);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	if(list.size()==0 &&currentPage!=1){
		%>
		<script type="text/javascript">
		location.href="index.jsp?main=guest/guestlist.jsp?currentPage=<%=currentPage-1%>";
		</script>
		<%
	}
	%>
<%
if (loginok != null) {
%>
<jsp:include page="addform.jsp" />
<hr align="left" width="700">
<%
}
%>
<div>
<script type="text/javascript">
	$(function(){
		$("span.likes").click(function(){
			
			var num=$(this).attr("num");
			var tag=$(this);
			//alert(num);
			
			$.ajax({
				
				type:"get",
				dataType:"json",
				url:"guest/ajaxlikes.jsp",
				data:{"num":num},
				success:function(data){
					//$(this).next().html(data.chu+"나여기있음");
					//alert(data.chu);
					tag.next().text(data.chu);
					tag.next().next().animate({"font-size":"15px"},1500,function(){
						$(this).css("font-size","0px");
					})
				}
			})
		})
		//댓글 부분은 무조건 안보이게 처리
		$("div.answer").hide();
		
		<%
		String toggle=(String)session.getAttribute("toggle");
		String anscnt=(String)session.getAttribute("cnt");
		System.out.println(anscnt);
		if(toggle!=null){
			%>
			$("div.answer").eq(<%=anscnt%>).show();
			<%
			toggle=null;
			session.removeAttribute("toggle");
			anscnt=null;
			session.removeAttribute("cnt");
		}
		%>
		
		//댓글클릭시 댓글 부분이 보였다 안보였다 하기
		$("span.answer").click(function(){
			$(this).prev().slideToggle('slow');
			//$(this).parent().find("div.answer").slideToggle("slow");
		})
		
		
		
		$(".delme").click(function(){
			var num=$(this).attr("num");
			var currentPage=$(this).attr("currentPage");
			alert(currentPage);
			
			var s=confirm("정말 삭제하겠습니까?");
			
			if(s){
				location.href="guest/delete.jsp?num="+num+"&currentPage="+<%=currentPage%>;
				alert("삭제되었습니다.");
			}
			else{
				alert("취소하였습니다.")
			}
		})
		
		$(".delans").click(function(){
			var idx=$(this).attr("idx");
			var cnt=$(this).attr("cnt");
			alert(cnt);
			var tag=$(this);
			//alert(idx);
			
			var s=confirm("댓글을 삭제하시겠습니까?");
			if(s){
				$.ajax({
					
					type:"get",
					dataType:"html",
					url:"guest/answerdelete.jsp",
					data:{"idx":idx,"cnt":cnt},
					success:function(data){
						location.reload();
					}
				})
			}
			else{
				alert("취소하였습니다.")
			}
		})
		
		$(".upans").click(function(){
			var upContent=$(this).parent().parent().find("span.upcont").text();
			var modalcnt1=$(this).attr("cnt");
			var modalIdx=$(this).parent().find("input.ansidx").val();
			//alert(modalId);
			$(".modalCont").text(upContent);
			$("#modalCnt").val(modalcnt1);
			$("#modalidx").val(modalIdx);
			("#myModal").modal();
			
		})
		$(".updateans").click(function(){
				var modalContent=$(".modalCont").val();
				var modalCnt2=$("#modalCnt").val();
				var modalIdx2=$("#modalidx").val();
				alert(modalContent);
				//alert(modalCnt2);
				//alert(modalCnt2);
				$.ajax({
					
					type:"get",
					dataType:"html",
					url:"guest/answerupdate.jsp",
					data:{"content":modalContent,"cnt":modalCnt2,"idx":modalIdx2},
					success:function(data){
						location.reload();
					}
				})
			})
		
	})
		
</script>
<b>총 <%=totalCount %>개의 방명록 글이 있습니다.</b>

<%
	MemberDao mdao=new  MemberDao();
	int cnt=-1;
	for(GuestDto dto:list){
		cnt++;
		//이름 얻기
		String name=mdao.getName(dto.getMyid());
		%>
		<table class="table" style="width: 600px;">
			<tr>
				<td>
					<b><i class="bi bi-person-bounding-box"><%=name %>(<%=dto.getMyid() %>)</i></b>
				<%
				//로그인한 아이디
				String myid=(String)session.getAttribute("myid");
				
				//로그인한 아이디와 글슨아이디가 같을 경우에만 수정|삭제 보여야 함
				if((loginok!=null&&dto.getMyid().equals(myid))||(loginok!=null&&myid.equals("admin"))){
					%>
					
					<a href="index.jsp?main=guest/updateform.jsp?num=<%=dto.getNum() %>&currentPage=<%=currentPage %>" 
					style="color: green; cursor: pointer;"><i class="bi bi-pencil-square"></i></a>
					<a class="delme" num="<%=dto.getNum()%>" currentPage="<%=currentPage %>"
					style="color: red; cursor: pointer;"><i class="bi bi-trash"></i></a>
					<%
				}
				%>
				<span><%=sdf.format(dto.getWriteday()) %></span>
				</td>
			</tr>
			
			<tr height="120">
				<td>
					<%
					if(dto.getPhotoname()!=null){
						%>
						<a href="save/<%=dto.getPhotoname()%>" target="_blank">
						<img src="save/<%=dto.getPhotoname()%>" align="left" 
						style="width: 100px; cursor: pointer;"></a>
						
						
						<%
					}
					%>
					<%=dto.getContent().replace("\n", "<br>") %>
				</td>
			</tr>
			
			<!-- 댓글,추천 -->
			<!-- 추천수 클릭시 추천숫자 옆에 하트 커졌다 사라지게 animate -->
			<tr>
				<td>
				<%
				//각 방명록에 달린 댓글 목록 가져오기
				AnswerDao adao=new AnswerDao();
				List<AnswerDto> alist=adao.getAllAnswer(dto.getNum());
				
				%>
				<div class="answer">
					<%
					if(loginok!=null){
						%>
						<div class="answerform">
							<form action="guest/answerinsert.jsp" method="post">
								<table class="table table-bordered" style="width:500px;">
									<tr>
										<td>
											<textarea style="width: 500px; height: 80px;"
											name="content" required="required"
											class="form-control"></textarea>
										</td>
										<td>
										<button type="submit" class="btn btn-outline-info"
										style="width: 80px; height: 80px;">등록</button>
										<input type="hidden" name="cnt" value="<%=cnt%>">
										<input type="hidden" name="num" value="<%=dto.getNum()%>">
										<input type="hidden" name="myid" value="<%=myid%>">
										<input type="hidden" name="currentPage" value="<%=currentPage%>">
										</td>
									</tr>
								</table>
							</form>
						</div>
						<%
					}
					%>
					<div class="answerlist">
						<table class="table" style="width: 480px;">
							<%
							for(AnswerDto adto:alist){
								%>
								<tr>
									<td width="60">
									<i class="bi bi-person-circle"></i>
									</td>
									<td>
									<%
									//작성자명
									String aname=mdao.getName(adto.getMyid());
									%>
									<br>
									<b><%=aname %></b>
									&nbsp;
									<%
									 	//글쓴이와 댓글쓴이가 같을경우 [작성자]
									 	if(dto.getMyid().equals(adto.getMyid())){
									 		%>
									 		<span style="color: red; border: 1px solid red; border-radius: 20px;">작성자</span>
									 		<%
									 	}
									%>
									<span style="font-size: 9pt; color: gray; margin-left:20px;"><%=sdf.format(adto.getWriteday()) %></span>
									<%
									//수정삭제는 로그인 중이면서 로그인한 아이디와 같은 경우만 보이게
									if(myid.equals(adto.getMyid())){
										%>
										<span style="float: right">
										<input type="hidden" class="ansidx" value="<%=adto.getIdx()%>">
										<a class="upans" style="color: green; cursor: pointer;" cnt="<%=cnt %>"
										data-bs-toggle="modal" data-bs-target="#myModal"><i class="bi bi-pencil-square"></i></a>&nbsp;
										<a class="delans" style="color: red; cursor: pointer;" idx="<%=adto.getIdx()%>" cnt="<%=cnt%>"><i class="bi bi-trash"></i></a>
										</span>
										<%
									}	
									%>
									<br>
									<span class="upcont"><%=adto.getContent().replace("\n", "<br>")%></span>

									</td>
								</tr>
								<%
							}
							%>
						</table>
					</div>
				</div>
					<span class="answer" style="cursor: pointer;"
					num=<%=dto.getNum() %>>댓글</span>
					<span><%=alist.size() %></span>
					<span class="likes" style="margin-left: 20px; cursor: pointer;"
					num=<%=dto.getNum() %>>추천</span>
					<span class="chu"><%=dto.getChu() %></span>
					<i class="bi bi-chat-heart-fill" style="font-size: 0px; color: red;"></i>
				</td>
			</tr>
		</table>
		<%
		
	}

%>
</div>
<!-- 페이지 번호 출력 -->
<div>
	<ul class="pagination justify-content-center">
	<%
		//이전
		if(startPage>1){
			%>
			<li>
				<a class="page-link" href="index.jsp?main=guest/guestlist.jsp?currentPage=<%=startPage-1 %>" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
        		</a>
        	</li>
			<%
		}
		for(int pp=startPage;pp<=endPage;pp++){
			
			if(pp==currentPage){
				%>
				<li class="page-item active">
					<a class="page-link" href="index.jsp?main=guest/guestlist.jsp?currentPage=<%=pp %>"><%=pp %></a>
				</li>
				<%
			}else{
				%>
				<li>
					<a class="page-link" href="index.jsp?main=guest/guestlist.jsp?currentPage=<%=pp %>"><%=pp %></a>
				</li>
				<%
			}
		}
		if(totalPage>endPage){
			%>
			<li class="page-item">
      			<a class="page-link" href="index.jsp?main=guest/guestlist.jsp?currentPage=<%=endPage+1 %>" aria-label="Next">
        			<span aria-hidden="true">&raquo;</span>
      			</a>
    		</li>
			<%
		}
	
	%>
 	</ul>
</div>
<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<textarea style="width: 450px; height: 200px;" class="form-control modalCont"></textarea>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<input type="hidden" id="modalidx" value="">
      	<input type="hidden" id="modalCnt" value="">
      	<input type="hidden" id="modalCont" value="">
        <button type="button" class="btn btn-outline-info updateans" cnt="#">수정</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
</body>
</html>