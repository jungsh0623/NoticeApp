<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<script src="../bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

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
			<div class="tabbable tabs-below">
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
					<jsp:include page ="List.jsp"></jsp:include></div>
					<div class="tab-pane" id="tab2"> �̺�Ʈ ������ </div>
					<div class="tab-pane" id="tab3"> 1:1���� ������</div>
				</div>
				
				<br><br><br><br><br><br><br><br><br>
				<br><br><br><br><br><br><br><br><br>
				<br><br><br><br><br><br><br><br><br>
			</div>
		</div>
		
		
	</div>
</div>

	
</body>
</html>