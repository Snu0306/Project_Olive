
document.addEventListener('DOMContentLoaded', function() {

	var calendarEl = document.getElementById('calendar');
	//db일정 받아오기 
	var eventFeed = function(info, successCallback,
		failureCallback) {
		$.ajax({
			type: "GET",
			url: "/Annual/calendarList.do",
			dataType: "json",
			success: function(data) {
				successCallback(data);
				console.log(data);
			},
			error: function(xhr) {
				console.log(xhr.status)
			}
		});
	}

	var calendar = new FullCalendar.Calendar(
		calendarEl,
		{
			
			dateClick: function(info) {
			
				$("#myModal").modal();
				$("#sname").val(info.dateStr);
				$("#ename").val(info.dateStr);
				$("#modal-body").html("");
			},
			
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'custom,dayGridMonth,timeGridWeek,timeGridDay,listWeek'
			},
			buttonText: {
				today: '오늘',
				month: '월',
				week: '주',
				day: '일',
				list: '주간 일정표'
			},

			//initialDate : '2020-09-12', // 캘린더 지정날짜로 보이게하기 
			navLinks: true, // can click day/week names to navigate views
			nowIndicator: true,
			weekNumbers: true,
			weekNumberCalculation: 'ISO',
			editable: true,
			selectable: true,
			dayMaxEvents: true, // allow "more" link when too many events
			/*events:[
				{
					
					  title: '휴가',
					  start: '2021-01-07',
					  end: '2021-01-10'
					} 

				]*/

			events: eventFeed

		});
	calendar.render();

});
/*
$("#salary_table").on("click", '#namecal', function(){
	alert("캘린더")
	$.ajax({
		url: "/Annual/calendarList.do",
		type: "GET",
		dataType:  "JSON",
		data: {
		},
		success: (data) => {
			insertDatabyAjax(data);
		}
	})
});
*/
