<!-- 
	파일명:M_Attendance.jsp
	설명: 근태현황(매니져) 홈페이지 
	작성일 : 2020-12-30
	수정일 : 2020-01-07
	작성자 : 심재형 
 -->
<%@ page	language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"		%>
<%@ taglib	prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"							%>
<%@ taglib	prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"							%>
<%@ taglib	prefix="s" 		uri="http://www.springframework.org/security/tags"				%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link href='/resources/fullcalendar-5.5.0/lib/main.css' rel='stylesheet' />
<script src='/resources/fullcalendar-5.5.0/lib/main.js'></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Project_HR</title>
<!-- 스타일시트, CDN 모듈화 -->
<jsp:include page="/WEB-INF/views/inc/HeadLink.jsp"></jsp:include>
<!-- CodePen 차용 vertical progress bar -->
<link href="/resources/css/customForAttendance.css" rel="stylesheet" />
<style type="text/css">
#calendar{
max-width: 1300px;
margin: 0 auto;
}
.item{
	flex: 1 1 auto;
}
</style>
</head>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar 모듈화 -->
		<jsp:include page="/WEB-INF/views/inc/Sidebar.jsp"></jsp:include>
		<!-- End Of Sidebar 모듈화 -->
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<jsp:include page="/WEB-INF/views/inc/Topbar.jsp"></jsp:include>
				<!-- End of Topbar -->
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<c:set var="emp" value="${emp}" />
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4"></div>
					<div class="row">
						<div class="col-lg-12">
							<!-- Dropdown Card Example -->
							<div class="card shadow mb-4">
								<!-- 총 근무시간 헤더  -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">이번주 총 근무시간</h6>
								</div>
								<!-- 총 근무시간 카드 -->
								<c:set var="total" value="${workHours}" />
								<c:set var="each" value="${hoursEachList}" />
								<div class="card-body">
									<h5 class="text-center">
										<strong>${total.startOfWeek} ~ ${total.endOfWeek}</strong>
									</h5>
									<div class="d-flex justify-content-around">
										<div class="col-lg-12 d-flex justify-content-around align-items-center">
											<!-- Vertical Progress Bar -->
											<c:forEach var="e" items="${each}" begin="0" end="6" step="1" varStatus="seq">
												<c:if test="${e.start eq null || e.start ne null }">
													<c:set var="superRate" value="${ (e.dayTotalHours + ((e.dayTotalMinutes*5/3)*(1/100)))*(100/8) }" />
													<div class="progress-cus vertical progress-striped-cus active">
														<c:if test="${e.attCode eq 20}">
															<!-- 지각 -->
															<c:set var="barKind" value="progress-bar-warning-cus" />
														</c:if>
														<c:if test="${e.attCode eq 30 ||e.attCode eq 40 }">
															<!-- 조퇴,결근 -->
															<c:set var="barKind" value="progress-bar-danger-cus" />
														</c:if>
														<c:if test="${e.attCode eq 50}">
															<!-- 휴가 -->
															<c:set var="barKind" value="progress-bar-secondary-cus" />
														</c:if>
														<c:if test="${e.attCode eq 10 || e.attCode eq 60 || e.attCode eq 70 || e.attCode eq 80}">
															<c:set var="barKind" value="progress-bar-success-cus" />
														</c:if>
														<div role="progressbar-cus" style="height: ${superRate}%;" data-html="true"
															class="progress-bar-cus progress-bar-striped-cus ${barKind}" data-toggle="tooltip" data-placement="right"
															data-original-title='
															<div class="p-1"> 
																<p class="inner-title mb-1"><fmt:formatDate value="${e.date}" pattern="MM.dd"/> ${e.weekDays}요일</p>
																<p class="inner-title">출근시간 : <b><fmt:formatDate value="${e.start}" pattern="HH:mm"/></b></p>
																<p class="inner-title">퇴근시간 : <b><fmt:formatDate value="${e.end}" pattern="HH:mm"/></b></p>
																<p class="inner-title">처리상태 : ${e.attCode}</p>
															</div> '>
															<!-- Vertical Bar Hover : activate Tooltips -->
															<c:if test="${e.overHours ne 0 || e.overMinutes ne 0}">
																<div role="progressbar-cus" style="height:<c:out value="${superRate-100}"/>%;"
																	class="progress-bar-cus progress-bar-striped-cus progress-bar-extention-cus progress-bar-cus-sub">
																</div>
															</c:if>
														</div>
														<div class="pro-p">
															<p>
																<fmt:formatDate value="${e.date}" pattern="MM.dd" />
																(${e.weekDays})
															</p>
															<span>${e.dayTotalHours}시간 ${e.dayTotalMinutes}분</span>
														</div>
													</div>
												</c:if>
											</c:forEach>
										</div>
									</div>
									<div class="mt-1 pt-1 text-center">
										<hr>
										<div class="d-flex flex-row align-items-center justify-content-around hour-checkboard">
											<div>
												<span class="legend progress-bar-success-cus mb-1"></span>
												&nbsp;근무시간
											</div>
											<div>
												<span class="legend progress-bar-extention-cus mb-1"></span>
												&nbsp;연장근무
											</div>
											<div>
												<span class="legend progress-bar-warning-cus mb-1"></span>
												&nbsp;지각
											</div>
											<div>
												<span class="legend progress-bar-danger-cus mb-1"></span>
												&nbsp;조퇴,결근
											</div>
											<div>
												<span class="legend progress-bar-secondary-cus mb-1"></span>
												&nbsp;휴가
											</div>
											<c:forEach var="e" items="${each}" begin="0" end="6" step="1" varStatus="seq">
												<c:set var="overH" value="${oh = oh + e.overHours}" />
												<c:set var="overM" value="${om = om + e.overMinutes}" />
												<c:set var="totalH" value="${th = th + e.dayTotalHours}" />
												<c:set var="totalM" value="${tm = tm + e.dayTotalMinutes}" />
											</c:forEach>
											<fmt:parseNumber var="overHour" value="${overH + (overM/60)}" integerOnly="true" />
											<c:set var="overMinute" value="${overM%60}" />
											<fmt:parseNumber var="totalHour" value="${totalH + (totalM/60)}" integerOnly="true" />
											<c:set var="totalMinute" value="${totalM%60}" />
											<div class="d1">
												<span class="title1">근무시간</span>
												<span class="st1">${totalHour-overHour}</span>
												시간
												<span class="st1">${totalMinute-overMinute}</span>
												분
											</div>
											<div class="d2">
												<span class="title2">연장근무</span>
												<span class="st2">${overHour}</span>
												시간
												<span class="st2">${overMinute}</span>
												분
											</div>
											<div class="d3">
												<span class="title3">총 근무시간</span>
												<span class="st3">${totalHour}</span>
												시간
												<span class="st3">${totalMinute}</span>
												분
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- End of Main Content -->
					<!-- 계정관리 컨텐츠 시작 -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<s:authorize access="!hasRole('ROLE_MANAGER')">
										<h6 class="m-0 font-weight-bold text-primary">근태 현황</h6>
									</s:authorize>
									<s:authorize access="hasRole('ROLE_MANAGER')">
										<h6 class="m-0 font-weight-bold text-primary">
											근태 관리 :
											<span>${emp.HEADNAME}</span>
											본부
											<span>${emp.DEPTNAME}</span>
											부서
										</h6>
									</s:authorize>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="card-for-flex mb-1">
										<div class="card-body-tridiv d-flex search-tab row justify-content-end mr-5">
											<div class="mb-3">
												<!-- 비동기로 DB다녀오는 친구들 -->
												<s:authorize access="hasRole('ROLE_MANAGER')">
													<form class="form-group d-flex justify-content-end">
														<select class="form-control width-100 mr-2" id="newSearchType">
															<option selected>사번</option>
															<option>이름</option>
															<option>본부</option>
															<option>부서</option>
														</select>
													<input type="text" class="form-control width-250 mr-2 inputState" id="newKeyword"
														placeholder="검색할 키워드를 입력..">
													<input type="button" class="btn btn-info" id="searchBtn" value="검색">
													<!-- //비동기로 DB다녀오는 친구들 -->
													</form>
												</s:authorize>
											</div>
										</div>
										<div class="card-body-tridiv"></div>
									</div>
									<div class="row justify-content-center mx-5">
										<table id="salary_table" class="table text-center">
											<thead>
												<tr>
													<th>날짜</th>
													<th>사번</th>
													<th>이름</th>
													<th>부서</th>
													<th>출근시간</th>
													<th>퇴근시간</th>
													<s:authorize access="hasRole('ROLE_MANAGER')">
													<th>선택</th>
													</s:authorize>
												</tr>
											</thead>
											<tbody id="attListTable">
												<c:forEach var="rectable" items="${list}">
													<tr class="namecal">
													<td><fmt:formatDate value="${rectable.starttime}" pattern="yyyy-MM-dd" /></td>
														<td name="empno"><c:out value="${rectable.empno}" /></td>
														<td><c:out value="${rectable.ename}" /></td>
														<td><c:out value="${rectable.deptname}" /></td>
														<td><fmt:formatDate value="${rectable.starttime}" pattern="HH:mm:ss" /></td>
														<td><fmt:formatDate value="${rectable.endtime}" pattern="HH:mm:ss" /></td>
														<s:authorize access="hasRole('ROLE_MANAGER')">
														<td><label class="userCheck"><input class='filter' type="radio" name="user"></label></td>
														</s:authorize>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<c:set var="criteria" value="${criteria}" />
										<input type="text" value="${criteria.searchType}" id="oldSearchType" hidden>
										<input type="text" value="${criteria.keyword}" id="oldKeyword" hidden>
										<input type="text" value="${criteria.page}" id="oldPage" hidden>
										<input type="text" value="${criteria.perPageNum}" id="oldPerPageNum" hidden>
										<input type="hidden" id="oldSearchType2">
										<input type="hidden" id="oldKeyword2">
										<c:set var="page" value="${pagination}"></c:set>
										<nav aria-label="Page navigation example">
											<ul class="pagination" id="pagination">
												<c:if test="${page.prev}">
													<li class="page-item">
														<a class="page-link page-btn-prev" href="#" aria-label="Previous">
															<span aria-hidden="true">&laquo;</span>
															<span class="sr-only">Previous</span>
														</a>
													</li>
												</c:if>
												<c:forEach var="paging" begin="${page.startPage}" end="${page.endPage}">
													<c:choose>
														<c:when test="${paging eq criteria.page}">
															<li class="page-item page-link">
																<b>${paging}</b>
															</li>
														</c:when>
														<c:otherwise>
															<li class="page-item">
																<a class="page-link page-btn" href="#">${paging}</a>
															</li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<c:if test="${page.next}">
													<li class="page-item">
														<a class="page-link page-btn-next" href="#" aria-label="Next">
															<span aria-hidden="true">&raquo;</span>
															<span class="sr-only">Next</span>
														</a>
													</li>
												</c:if>
											</ul>
										</nav>
									</div>
								</div>
							</div>
							<div class="col-xl-12 col-lg-12 ">
								<div class="card shadow mb-4">
									<!-- Card Header -->
									<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
										<h6 class="m-0 font-weight-bold text-info">캘린더</h6>
									</div>
									<!-- Card Body -->
									<div class="card-body justify-content-center">
										<div class="center-block item">
											<div class="p-30 ">
												<div id='calendar' ></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Footer 모듈화 -->
						<jsp:include page="/WEB-INF/views/inc/Footer.jsp"></jsp:include>
						<!-- End of Footer 모듈화 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End of Page Wrapper -->
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/inc/LogOutModal.jsp"></jsp:include>
	<!-- SearchAndPaging -->
	<script src="/resources/js/Attendance/attendance.js"></script>
	<!-- 캘린더 모듈화  -->
	<script src="/resources/js/Attendance/attendanceCal.js"></script>
	<!-- 모든 스크립트 모듈화 -->
	<jsp:include page="/WEB-INF/views/inc/BottomLink.jsp"></jsp:include>
</body>
</html>