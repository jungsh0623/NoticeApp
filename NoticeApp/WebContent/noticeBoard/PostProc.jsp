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
		alert("글이 등록되었습니다.");
		location.href="main_customerCenter.jsp";
	</script>
	
<%
}
else {
%>
<script>
	alert("공백인 칸이 있습니다.");
	history.back();
</script>
<% 
}
%>
