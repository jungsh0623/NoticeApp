<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="myboard.bean.BoardDao"/>
<jsp:useBean id="dto" class="myboard.bean.BoardDto"/>
<jsp:setProperty property="*" name="dto"/>

<%
request.setCharacterEncoding("euc-kr");
String b_subject = request.getParameter("b_subject");
String b_content = request.getParameter("b_content");
String b_pass = request.getParameter("b_pass");

if(b_subject != "" && b_content != "" && b_pass != "") {
	dao.insertBoard(dto);
%>
	<script>
		alert("���� ��ϵǾ����ϴ�.");
		location.href="main_customerCenter.jsp";
	</script>
	
<%
}
else {
%>
<script>
	alert("������ ĭ�� �ֽ��ϴ�.");
	history.back();
</script>
<% 
}
%>
