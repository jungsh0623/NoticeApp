<%@page import="myboard.bean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="dao" class="myboard.bean.BoardDao"/>
<jsp:useBean id="childDto" class="myboard.bean.BoardDto"/>
<jsp:setProperty property="*" name="childDto" />

<%
	BoardDto parentDto = dao.getBoard(childDto.getB_num(), "reply");
	dao.replyUpdatePos(parentDto);

	childDto.setB_depth(parentDto.getB_depth());
	childDto.setB_pos(parentDto.getB_pos());
	dao.replyBoard(childDto);

%>
	<script>
		alert("�亯�� ��ϵǾ����ϴ�.");
		location.href="List.jsp";
	</script>
