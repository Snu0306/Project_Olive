<!-- 
	파일명: Email.jsp
	설명: 이메일 홈페이지 
	작성일 : 2020-12-28
	작성자 : 심재형 
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin 2 - Forgot Password</title>
<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->

<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #3498db;
  border-bottop: 16px solid #3498db; 
  width: 120px;
  height: 120px;
  animation: spin 2s linear infinite;
  
  position: absolute;
  top: 40%;
  left: 50%;
  box-shadow: 0px 0px 50px #888888;
  /* transform: translateX(-50%); */
  visibility: hidden;
  oppacity: 0;
  transition:all 0.3s;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.swal-overlay {
  background-color: rgba(43, 165, 137, 0.45);
}
</style>


</head>
<body class="bg-gradient-primary">
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center">
			<div class="col-xl-10 col-lg-12 col-md-9">
				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<sec:authentication var="principal" property="principal" />
										<h1 class="h4 text-gray-900 mb-2">이메일 인증</h1>
										<p class="mb-4">
											사번 : ${principal.username} 님. 환영합니다!<br> 본인의 이메일 계정을 통해 인증 시 <br>해당 계정에 로그인할 수 있습니다.<br>이메일을
											인증해주세요.
										</p>
									</div>
									<form method="POST" class="user" id="emailForm">
										<div class="form-group">
											<input type="email" class="form-control form-control-user" id="email" name="email"
												aria-describedby="emailHelp" placeholder="Enter 이메일 주소..." required>
												<span id="checkEmail"></span>
										</div>
										<button type="button" id="submitBtn" class="btn btn-primary btn-user btn-block" style="margin-bottom: 30px">인증번호
											발송</button>
									</form>
									<form class="user">
										<div class="form-group" id="codeForm">
											<input type="number" class="form-control form-control-user" id="code" name="code"
												aria-describedby="emailHelp" placeholder="Enter 이메일 인증코드..." readonly>
										</div>
										<button type="button" id="finalCheck" class="btn btn-secondary btn-user btn-block" disabled>인증하기</button>
									</form>
									<hr>
									<div class="form-group" id="goToMain">
									
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="loader"></div>
	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>
	<!-- SweetAlert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- Email validation JavaScript -->
	<script src="/resources/js/email.js"></script>
</body>
</html>