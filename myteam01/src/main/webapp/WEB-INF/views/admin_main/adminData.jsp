<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
%>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 데이터</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
         body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        #genderChart {
            width: 300px !important;
            height: 300px !important;
        }
        .container {
            display: flex;
            justify-content: space-between;
        }
        .chart-container {
            width: 45%;
        }
        .board {
            width: 45%;
            margin-top: 20px;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px; /* 모서리 둥글게 */
            padding: 10px; /* 내부 여백 */
            background-color: #f9f9f9; /* 배경색 */
        }
        .board h2 {
            border-bottom: 2px solid #ddd; /* 제목 아래 선 추가 */
            padding-bottom: 10px;
        }
        .board table {
            width: 100%;
            border-collapse: collapse;
        }
        .board th, .board td {
            border: 1px solid #ccc; /* 각 셀 테두리 */
            padding: 10px;
            text-align: left;
        }
        .board th {
            background-color: #e9e9e9; /* 헤더 배경색 */
        }
        #genderChart {
            width: 300px !important;
            height: 300px !important;
        }
        .container {
            display: flex;
            justify-content: space-between;
        }
        .chart-container {
            width: 45%;
        }
        .board {
            width: 45%;
            margin-top: 20px;
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
    </style>
</head>
<body>
    <h2>가입한 사용자 성별 비율</h2>
    <canvas id="genderChart"></canvas>
    
    <script>
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

    <div class="container">
        <div class="chart-container">
            <h2>행사 등록 수 (최근 1주일)</h2>
            <canvas id="eventRegChart"></canvas>
        </div>

        <div class="chart-container">
            <h2>식당 등록 수 (최근 1주일)</h2>
            <canvas id="restRegChart"></canvas>
        </div>
    </div>

<script>
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

</body>
</html>
