<%@page import="homepage.beans.dao.ReplyDAO"%>
<%@page import="homepage.beans.dto.MemberDTO"%>
<%@page import="homepage.beans.dao.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="homepage.beans.dto.PostDTO"%>
<%@page import="homepage.beans.dao.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 페이지 확인하기
	String pageStr = request.getParameter("page");
	long pageSize = 20;
	long pageNum;
	
	try{
		pageNum = Long.parseLong(pageStr);
		
		if(pageNum <= 0) {
			throw new Exception();
		}
	} catch(Exception e) {
		pageNum = 1;
	}
	long end = pageNum * pageSize;
	long start = end - (pageSize - 1);
	
	// 정보 준비
	PostDAO pdao = new PostDAO();
	PostDTO pdto = new PostDTO();
	ReplyDAO rdao = new ReplyDAO();
	List<PostDTO> list = pdao.userPost(request.getParameter("post_id"), start, end);
	
	// 댓글 개수 가지고 오기
	long count;
	// 회원 정보 가지고 오기
	String keyword = request.getParameter("post_id");
	String url = "?";

	if (request.getParameter("post_sub") != null && request.getParameter("post_title") != null) {
		
 		// 게시글 조회 후 제목 및 말머리로 검색 시
		pdto.setPost_sub(request.getParameter("post_sub"));
		pdto.setPost_title(request.getParameter("post_title"));
		list = pdao.searchPost(pdto, start, end);
		keyword = request.getParameter("post_title");
		String sub = request.getParameter("post_sub");
		url = "?post_sub=" + sub + "&post_title=" + keyword;
	
	}
	
	MemberDTO mdto = (MemberDTO) session.getAttribute("userinfo");
	boolean login = mdto != null;
%>


<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">
	<h2>"<%=keyword %>" 로 검색한 결과</h2>
	<h3>총 <%=list.size() %> 건의 게시글이 있습니다.</h3> 
	
	<table style="width: 1038px;">
		<thead>
			<tr><td colspan="6"><hr></td></tr>
			<tr>
			
				<th width="70">번호</th>
			
				<th width="100">말머리</th>
			
				<th width="500">제목</th>
			
				<th width="200">작성자</th>
			
				<th width="150">조회수</th>
			
				<th width="150">작성일</th>
			
			</tr>
		</thead>
		<tbody>
			<%if(list.isEmpty()) { %>
			<tr height="40">
				<th colspan="6">
					<i><b>게시글을 조회할 수 없습니다.</b></i>
				</th>
			</tr>	
			<%} else {%>
				<%for(PostDTO post : list) {%>
						<%count = rdao.replyCount(post.getPost_no()); %>
						<tr height="40">
			
							<td align="center"><%=post.getPost_no() %></td>
			
							<td align="center"><%=post.getPost_sub() %></td>
			
							<td><a href="<%=request.getContextPath() %>/post/post.jsp?post_no=<%=post.getPost_no() %>"><%=post.getPost_title() %><font size="3" color="gray"><b>    (<%=count %>)</b></font></a></td>
			
							<%if(post.getPost_id() != null) { %>
			
								<td align="center"><a href="<%=request.getContextPath() %>/member/userinfo.jsp?member_id=<%=post.getPost_id()%>"><%=post.getPost_id() %></a></td>
				
							<%}  else {%>
				
								<td align="center"><font color="gray" size="2"><i>탈퇴한 유저</i></font></td>
				
							<%} %>
				
							<td align="center"><%=post.getPost_hits() %></td>
				
							<td><%=post.getPost_date2() %></td>		
				
						</tr>
				<%} %>
			<%} %>	
		</tbody>
	</table>
	<table style="width: 1038px;">
			<tr>
				<td colspan="6" align="center">
				<hr><br>
				<form action="search_my_post.jsp" method="post">
					<select name="post_sub">
				
						<option disabled="disabled">선택</option>
				
						<option value="공지">공지</option>
				
						<option value="일반" selected="selected">일반</option>
				
						<option value="정보">정보</option>
				
						<option value="질문">질문</option>
				
					</select>
					<input type="text" name="post_title" placeholder="제목">
					<input type="submit" value="검색">
				</form>
				<br>
					<a href="<%=request.getContextPath() %>/post/create.jsp"><input type="button" value="글쓰기"></a>
					<a href="delete_my_post.jsp<%=url%>"><input type="button" value="선택 삭제"></a>
					<a href="mypage.jsp"><input type="button" value="마이 페이지"></a>
				</td>
			</tr>
		</table>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>