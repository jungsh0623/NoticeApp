<%@page import="myboard.bean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<html>

<head>
<title>������ ��������</title>
	<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- IE���� �������� ���� �� ���� �ֽ� �������� ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- �ش� ����̽��� ���缭 �ִ��� ȭ�鿡 �µ��� ����ȭ ������� ��ȯ-->
	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>

<body>
<jsp:useBean id="dao" class="myboard.bean.BoardDao"/>
<%
	int num = Integer.parseInt(request.getParameter("b_num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	BoardDto dto = dao.getBoard(num, "read");
%>
<div class="container">
	<div class="row">
		<!-- ===================== ���̵� �޴� ===================== -->
		<div class="col-md-3">
			<h3>������</h3>
			<ul class="nav nav-pills nav-stacked">
					<li class="active"><a href="#tab1" data-toggle="tab">��������</a></li>
					<li><a href="#tab2" data-toggle="tab">�̺�Ʈ</a></li>
					<li><a href="#tab3" data-toggle="tab">1:1����</a></li>
			</ul>
		</div>

		<!-- ===================== ���̵� �޴� �� ===================== -->		




		<div class="col-md-9">	
			<h2 align=left>������ <small>��������</small></h2> <hr/>
			<table class="table">
				<thead>
					<th width="70%"><%=dto.getB_subject()%></th>
					<th width="30%"><%=dto.getB_regdate()%></th>
					<th width="20%"><%=dto.getB_count()%></th>
				</thead>
				<tbody>
					<tr>
					<td><%=dto.getB_content().replace("\n", "<br/>")%></td>
					</tr>
				</tbody>
		</table>
		<hr/>
		</div>
		<div class="col-md-12 form-inline" align="right">	
			<a class="btn btn-default btn-xs" href="List.jsp" role="button">���</a>
			<a class="btn btn-default btn-xs" href="Update.jsp?b_num=<%=num%>" role="button">����</a>
			<a class="btn btn-default btn-xs" href="Delete.jsp?b_num=<%=num%>" role="button">����</a>
			<a class="btn btn-default btn-xs" href="Reply.jsp?b_num=<%=num%>" role="button">�亯</a>
		</div>
	</div>
</div>					






</body>
</html>
