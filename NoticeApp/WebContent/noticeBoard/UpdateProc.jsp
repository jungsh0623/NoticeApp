<%@page import="myboard.bean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="dao" class="myboard.bean.BoardDao"/>
<%
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	int num = Integer.parseInt(request.getParameter("b_num"));
	
	BoardDto dto = dao.getBoard(num, "update");
	
	if(dto.getB_pass().equals(pass)){
		BoardDto board = new BoardDto();
		board.setB_name(name);
		board.setB_email(email);
		board.setB_subject(subject);
		board.setB_content(content);
		board.setB_pass(pass);
		board.setB_num(num);
		
		dao.updateBoard(board);
		response.sendRedirect("List.jsp");
	}
	else{
%>
	<script>
		alert("패스워드가 다릅니다.");
		history.back();
	</script>
<%
	}
%>

