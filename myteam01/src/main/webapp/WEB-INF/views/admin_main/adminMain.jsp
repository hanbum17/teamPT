<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.teamproject.myteam01.domain.UserVO" %>
<%@ page import="com.teamproject.myteam01.domain.EventVO" %>
<%@ page import="com.teamproject.myteam01.domain.RestaurantVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp" %>
<%@ include file="../menu/nav.jsp"%>
<%
    UserVO userCounts = (UserVO) request.getAttribute("user");
    Long maleCnt = userCounts.getMaleCnt() != null ? userCounts.getMaleCnt() : 0;
    Long femaleCnt = userCounts.getFemaleCnt() != null ? userCounts.getFemaleCnt() : 0;

    // 비율 계산
    double total = maleCnt + femaleCnt;
    double malePercentage = (total > 0) ? (maleCnt / total) * 100 : 0;
    double femalePercentage = (total > 0) ? (femaleCnt / total) * 100 : 0;

    List<EventVO> eventRegDate = (List<EventVO>) request.getAttribute("eventRegDate");
    List<RestaurantVO> restRegDate = (List<RestaurantVO>) request.getAttribute("restRegDate");
    List<EventVO> recentEvents = (List<EventVO>) request.getAttribute("event");
    List<RestaurantVO> recentRestaurants = (List<RestaurantVO>) request.getAttribute("rest");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    // 행사 등록 수 및 식당 등록 수 세기
    Map<String, Integer> eventCounts = new HashMap<>();
    for (EventVO event : eventRegDate) {
        if (event.getEregdate() != null) {
            String dateKey = sdf.format(event.getEregdate());
            eventCounts.put(dateKey, eventCounts.getOrDefault(dateKey, 0) + 1);
        }
    }

    Map<String, Integer> restaurantCounts = new HashMap<>();
    for (RestaurantVO restaurant : restRegDate) {
        if (restaurant.getFregdate() != null) {
            String dateKey = sdf.format(restaurant.getFregdate());
            restaurantCounts.put(dateKey, restaurantCounts.getOrDefault(dateKey, 0) + 1);
        }
    }

    // 날짜와 개수 리스트 만들기
    List<String> eventLabels = eventCounts.keySet().stream().sorted().collect(Collectors.toList());
    List<Integer> eventData = eventLabels.stream().map(eventCounts::get).collect(Collectors.toList());

    List<String> restaurantLabels = restaurantCounts.keySet().stream().sorted().collect(Collectors.toList());
    List<Integer> restaurantData = restaurantLabels.stream().map(restaurantCounts::get).collect(Collectors.toList());

    // 신규 회원 날짜별 가입 횟수
   Map<String, Long> dateWithCnt = (Map<String, Long>) request.getAttribute("dateWithCnt");
%>

<!DOCTYPE html>
<html>
<head>
    <title>관리자 데이터</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            width: 100%;
            color: #333;
            background: linear-gradient(120deg, #84fab0, #8fd3f4);
        }
        #genderChart {
            width: 300px !important;
            height: 300px !important;
        }
.container {
    display: flex;
    flex-wrap: wrap; /* 요소들이 줄 바꿈되도록 설정 */
    justify-content: space-between; /* 간격 자동 조정 */
    margin:-10px;
}

.chart-container {
    width: calc(100% - 20px); /* 전체 너비로 설정 */
    margin: 10px; /* 간격 추가 */
    min-height: 300px; /* 최소 높이 설정 */
    position: relative; /* 자식 요소에 절대 위치 지정 가능 */
}
canvas {
	position: absolute;
	top: 0; /* 상단 맞춤 */
    left: 50; /* 좌측 맞춤 */
    max-width: 100%; /* 캔버스가 컨테이너를 넘지 않도록 설정 */
    height: 100%; /* 자동 높이 조정 */
    display: block; /* 블록 요소로 설정하여 여백 문제 해결 */
}
        .board {
            width: 100%;
            margin-top: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            background-color: #f9f9f9;
        }
        .board h2 {
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
        .board table {
            width: 100%;
            border-collapse: collapse;
        }
        .board th, .board td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        .board th {
            background-color: #e9e9e9;
        }
        .content-box {
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            margin-top: 3%;
            margin-left: 10%;
            margin-right: 20px;
            width: 80%;
        }
        .summary {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .summary div {
		    background-color: #ffffff;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    padding: 10px;
		    margin: 10px 0; /* 간격 조정 */
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 */
		}
		.summary-container {
		    display: flex; /* Flexbox 사용 */
		    justify-content: space-between; /* 간격을 자동으로 조정 */
		    background-color: transparent; /* 배경색 투명하게 설정 */
		}
		
		.summary-container span {
		    background-color: #ffffff;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    padding: 10px;
		    margin: 0 10px; /* 좌우 간격 조정 */
		    flex: 1; /* 각 항목이 동일한 비율로 공간을 차지하도록 설정 */
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
		    text-align: center; /* 가운데 정렬 */
		}
		.board {
    width: 100%;
    margin-top: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    background-color: #f9f9f9;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 추가 */
       flex: 1; /* 각 보드가 동일한 비율로 공간을 차지하도록 설정 */
    min-width: 300px; /* 최소 너비 설정 (작은 화면에서도 보기 좋게) */
}
    </style>
</head>
<body>
    <div class="content-box">
        <div class="summary">
        	<h3>오늘의 활동</h3>
            <div class="summary-container">
		        <span>신규 회원 수: <strong>${todayNewCnt}</strong></span>
		        <span>신규 행사글 등록 수: <strong>${todayNewEventCnt}</strong></span>
		        <span>신규 식당글 등록 수: <strong>${todayNewRestCnt}</strong></span>
   			 </div>
        </div>

       <!-- 가입한 사용자 성별 비율 및 신규 회원 날짜별 가입 횟수 -->
    <div class="container">
        <div class="board">
            <h2>가입한 사용자 성별 비율</h2>
            <div class="chart-container">
                <canvas id="genderChart"></canvas>
            </div>
        </div>

        <div class="board">
            <h2>신규 회원 날짜별 가입 횟수</h2>
            <div class="chart-container">
                <canvas id="newUserChart"></canvas>
            </div>
        </div>
    </div>

        <script>
            // 성별 비율 차트
            var ctx = document.getElementById('genderChart').getContext('2d');
            var genderChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['남성', '여성'],
                    datasets: [{
                        label: '가입한 사용자 성별 비율',
                        data: [<%= malePercentage %>, <%= femalePercentage %>],
                        backgroundColor: [
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 99, 132, 0.2)'
                        ],
                        borderColor: [
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 99, 132, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: '가입한 사용자 성별 비율'
                        }
                    }
                }
            });
        </script>

        <script>
    var newUserLabels = [<%= dateWithCnt.keySet().stream().map(date -> "'" + date + "'").collect(Collectors.joining(", ")) %>];
    var newUserData = [<%= dateWithCnt.values().stream().map(String::valueOf).collect(Collectors.joining(", ")) %>];

    var newUserCtx = document.getElementById('newUserChart').getContext('2d');
    var newUserChart = new Chart(newUserCtx, {
        type: 'line',
        data: {
            labels: newUserLabels,
            datasets: [{
                label: '신규 회원 수',
                data: newUserData,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1,
                        precision: 0 // 소수점 없애기
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '신규 회원 날짜별 가입 횟수'
                }
            }
        }
    });
</script>

       <div class="container">
        <!-- 행사 등록 수 (최근 1주일) -->
        <div class="board">
            <h2>행사 등록 수 (최근 1주일)</h2>
            <div class="chart-container">
                <canvas id="eventRegChart"></canvas>
            </div>
        </div>

        <!-- 식당 등록 수 (최근 1주일) -->
        <div class="board">
            <h2>식당 등록 수 (최근 1주일)</h2>
            <div class="chart-container">
                <canvas id="restRegChart"></canvas>
            </div>
        </div>
    </div>

        <script>
            // 행사 등록 차트
            var eventRegCtx = document.getElementById('eventRegChart').getContext('2d');
            var eventRegChart = new Chart(eventRegCtx, {
                type: 'line',
                data: {
                    labels: [<%= eventLabels.stream().map(label -> "'" + label + "'").collect(Collectors.joining(", ")) %>],
                    datasets: [{
                        label: '행사 등록 수',
                        data: [<%= eventData.stream().map(String::valueOf).collect(Collectors.joining(", ")) %>],
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1,
                                precision: 0 // 소수점 없애기
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: '행사 등록 수 (최근 1주일)'
                        }
                    }
                }
            });

            // 식당 등록 차트
            var restRegCtx = document.getElementById('restRegChart').getContext('2d');
            var restRegChart = new Chart(restRegCtx, {
                type: 'line',
                data: {
                    labels: [<%= restaurantLabels.stream().map(label -> "'" + label + "'").collect(Collectors.joining(", ")) %>],
                    datasets: [{
                        label: '식당 등록 수',
                        data: [<%= restaurantData.stream().map(String::valueOf).collect(Collectors.joining(", ")) %>],
                        borderColor: 'rgba(153, 102, 255, 1)',
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1,
                                precision: 0 // 소수점 없애기
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: '식당 등록 수 (최근 1주일)'
                        }
                    }
                }
            });
        </script>

        <!-- 최근 등록된 행사 및 식당 테이블 -->
        <div class="container">
            <div class="board">
                <h2>최근 등록된 행사글 10개</h2>
                <table>
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="event" items="${recentEvents}">
                            <c:if test="${not empty event.ename && not empty event.eregdate}">
                                <tr>
                                    <td>${event.ename}</td>
                                    <td><fmt:formatDate value="${event.eregdate}" pattern="yyyy-MM-dd" /></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="board">
                <h2>최근 등록된 식당글 10개</h2>
                <table>
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="restaurant" items="${recentRestaurants}">
                            <c:if test="${not empty restaurant.fname && not empty restaurant.fregdate}">
                                <tr>
                                    <td>${restaurant.fname}</td>
                                    <td><fmt:formatDate value="${restaurant.fregdate}" pattern="yyyy-MM-dd" /></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
