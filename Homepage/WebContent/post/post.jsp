<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="homepage.beans.dao.PostDAO"%>
<%@page import="homepage.beans.dto.MemberDTO"%>
<%@page import="homepage.beans.dto.PostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	PostDAO pdao = new PostDAO();
	int post_no = Integer.parseInt(request.getParameter("post_no"));
	MemberDTO mdto = (MemberDTO) session.getAttribute("userinfo");
	
	// 조회수 검사 및 증가
	Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
	
	if(memory == null) {
		memory = new HashSet<>();
	}
	
	boolean isFirst = memory.add(post_no);
	
	session.setAttribute("memory", memory);
	
	if(isFirst) {
		
		pdao.getHits(post_no, mdto.getMember_id()); 
		
	}
	
	// 작성자와 현재 회원 비교
	PostDTO pdto = pdao.getPost(post_no);
	
	String post_id = pdto.getPost_id();
	String member_id = mdto.getMember_id();
	
	boolean isAdmin = mdto.getAccess_auth().equals("운영자");
	boolean isMine = member_id.equals(post_id);
	boolean isPost_id = pdto.getPost_id() != null;
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2><%=pdto.getPost_title() %></h2>
	<table style="width: 1038px;">
		<tbody>
			<tr>
				<th>말머리</th>
				<td height="80" colspan="2"><%=pdto.getPost_sub() %></td>
				<th>작성자</th>
				<%if(isPost_id) { %>
					<td height="80" colspan="2"><a href="<%=request.getContextPath()%>/member/userinfo.jsp?member_id=<%=pdto.getPost_id()%>"><%=pdto.getPost_id() %></a></td>
				<%} else {%>
					<td height="80" colspan="2"><font color="red" size="3"><i><b>탈퇴한 유저</b></i></font></td>
				<%} %>
			</tr>
			<tr>
				<td colspan="6">
					<hr>
				</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td colspan="2" height="80"><%=pdto.getPost_hits() %></td>
				<th>작성일</th>
				<td colspan="2" height="80"><%=pdto.getPost_date() %>
			</tr>
			<tr>
				<td colspan="6">
					<hr>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="6" height="80"><font size="5"><%=pdto.getPost_title() %></font></td>
			</tr>
			<tr>
				<td colspan="6">
					<hr>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td width="300" height="250" colspan="6"><%=pdto.getPost_content() %></td>
			</tr>
			<tr>
				<td colspan="6">
					<hr>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<a href="board.jsp"><input type="button" value="뒤로 가기"></a>
	<%if(isAdmin || isMine) { %>
		<a href="edit_post.jsp?post_no=<%=pdto.getPost_no()%>"><input type="button" value="수정"></a>
		<a href="delete.do?post_no=<%=pdto.getPost_no()%>"><input type="button" value="삭제"></a>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     