<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- FullCalendar CSS and JS -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.js'></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/trip.css">



<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>여행계획 세우기</h2>
        </div>
        <div class="trip-planner">
            <h3>나의 여행 계획</h3>
            
            <!-- FullCalendar를 표시할 DIV -->
            <div id="calendar"></div>

            <!-- 새로운 여행 계획을 추가할 폼 -->
            <form id="tripForm" action="/user/saveTripPlan" method="post">
                <label>목적지: <input type="text" name="destination"></label>
                <label>여행 날짜: <input type="date" name="tripDate"></label>
                <label>메모: <textarea name="notes"></textarea></label>
                <button type="submit">계획 저장</button>
            </form>
        </div>
    </div>
</main>
</div>
</body>
</html>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',  // 기본 월간 보기
        height: 650,  // 캘린더 높이 설정
        events: '/user/getFavoritePlans',  // 서버에서 이벤트 가져오기
        dateClick: function(info) {
            document.querySelector('input[name="tripDate"]').value = info.dateStr;
        }
    });

    calendar.render();  // 캘린더 렌더링
});

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
      initialDate: '2023-01-12',
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
        {
          title: 'All Day Event',
          start: '2023-01-01'
        },
        {
          title: 'Long Event',
          start: '2023-01-07',
          end: '2023-01-10'
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2023-01-09T16:00:00'
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2023-01-16T16:00:00'
        },
        {
          title: 'Conference',
          start: '2023-01-11',
          end: '2023-01-13'
        },
        {
          title: 'Meeting',
          start: '2023-01-12T10:30:00',
          end: '2023-01-12T12:30:00'
        },
        {
          title: 'Lunch',
          start: '2023-01-12T12:00:00'
        },
        {
          title: 'Meeting',
          start: '2023-01-12T14:30:00'
        },
        {
          title: 'Happy Hour',
          start: '2023-01-12T17:30:00'
        },
        {
          title: 'Dinner',
          start: '2023-01-12T20:00:00'
        },
        {
          title: 'Birthday Party',
          start: '2023-01-13T07:00:00'
        },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: '2023-01-28'
        }
      ]
    });

    calendar.render();
  });

</script>
