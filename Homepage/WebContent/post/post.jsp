                                                                             <%@page import="homepage.beans.dao.PostDAO"%>
<%@page import="homepage.beans.dto.MemberDTO"%>
<%@page import="homepage.beans.dto.PostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	PostDAO pdao = new PostDAO();
	PostDTO pdto = pdao.getPost(Long.parseLong(request.getParameter("post_no")));
	MemberDTO mdto = (MemberDTO) session.getAttribute("userinfo");
	
	if(!mdto.getMember_id().equals(pdto.getPost_id()) || mdto.getMember_id() == null) {
		
		pdao.getHits(pdto.getPost_no());
		
	}	
	
	pdto = pdao.getPost(Long.parseLong(request.getParameter("post_no")));
	
	String post_id = pdto.getPost_id();
	
	String member_id = mdto.getMember_id();
	
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
				<%if(pdto.getPost_id() != null) { %>
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
	<a href="javascript:history.back()"><input type="button" value="뒤로 가기"></a>
	<%if(member_id.equals(post_id) || mdto.getAccess_auth().equals("운영자")) { %>
		<a href="edit_post.jsp?post_no=<%=pdto.getPost_no()%>"><input type="button" value="수정"></a>
		<a href="delete.do?post_no=<%=pdto.getPost_no()%>"><input type="button" value="삭제"></a>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     