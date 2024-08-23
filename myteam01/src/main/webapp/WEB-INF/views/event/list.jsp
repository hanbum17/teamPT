<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>행사&음식점 리스트</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
        }
        .pagination li {
            margin: 0 5px;
        }
        .pagination a {
            text-decoration: none;
        }
        .no_data_msg {
            text-align: center;
            color: #888;
        }
    </style>
</head>
<body>

<h2>리스트</h2>
<a href="<c:url value='/logout'/>">로그아웃</a>
<button type="button" id="btnToEveRegister">행사 등록</button>

<!-- Search and Filter Form -->
<form id="searchForm" method="get" action="/list" autocomplete="off">
    <label for="searchType">Search by:</label>
    <select id="searchType" name="searchType">
        <option value="name" <c:if test="${searchType == 'name'}">selected</c:if>>Name</option>
        <option value="address" <c:if test="${searchType == 'address'}">selected</c:if>>Address</option>
    </select>
    <input type="text" id="searchKeyword" name="searchKeyword" placeholder="Enter keyword" value="${searchKeyword}" />

    <label for="filterType">Filter by Type:</label>
    <select id="filterType" name="filterType" onchange="this.form.submit()">
        <option value="전체" <c:if test="${filterType == '전체'}">selected</c:if>>전체</option>
        <option value="축제" <c:if test="${filterType == '축제'}">selected</c:if>>축제</option>
        <option value="음식점" <c:if test="${filterType == '음식점'}">selected</c:if>>음식점</option>
    </select>

    <label for="eventType">Event Type:</label>
    <select id="eventType" name="eventType" onchange="this.form.submit()">
        <option value="" <c:if test="${eventType == null || eventType == ''}">selected</c:if>>All</option>
        <option value="1" <c:if test="${eventType == '1'}">selected</c:if>>유저</option>
        <option value="0" <c:if test="${eventType == '0'}">selected</c:if>>관리자</option>
    </select>

    <button type="submit">Search</button>
</form>

<!-- Page Size Selector -->
<form method="get" action="/list" id="pageSizeForm">
    <label for="pageSize">Page Size:</label>
    <select id="pageSize" name="pageSize" onchange="this.form.submit()">
        <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10</option>
        <option value="30" <c:if test="${pageSize == 30}">selected</c:if>>30</option>
        <option value="50" <c:if test="${pageSize == 50}">selected</c:if>>50</option>
    </select>
    <input type="hidden" name="pageNum" value="${currentPage}" />
    <input type="hidden" name="searchType" value="${searchType}" />
    <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
    <input type="hidden" name="filterType" value="${filterType}" />
    <input type="hidden" name="eventType" value="${eventType}" />
</form>

<table>
    <thead>
        <tr>
            <th>No.</th>
            <th>Type</th>
            <th>Name</th>
            <th>Address</th>
            <th>Rating</th>
            <th>Views</th>
            <th>Event Type</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${combinedList}">
            <tr>
                <td>${item.LNUMBER}</td>
                <td>${item.LDICTIONARY}</td>
                <td>${item.LNAME}</td>
                <td>${item.LADDRESS}</td>
                <td>${item.LRATING}</td>
                <td>${item.LVIEWSCNT}</td>
                <td>${item.LTYPE}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty combinedList}">
            <tr>
                <td colspan="7">
                    <div class="no_data_msg">검색된 결과가 없습니다.</div>
                </td>
            </tr>
        </c:if>
    </tbody>
</table>

<!-- Pagination Controls -->
<div class="paging">
    <ul class="pagination">
        <c:set var="pageRange" value="3" />
        <c:set var="startPage" value="${currentPage - pageRange > 1 ? currentPage - pageRange : 1}" />
        <c:set var="endPage" value="${currentPage + pageRange < totalPages ? currentPage + pageRange : totalPages}" />

        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
            <a class="page-link" href="?pageNum=1&pageSize=${pageSize}&searchType=${searchType}&searchKeyword=${searchKeyword}&filterType=${filterType}&eventType=${eventType}" aria-label="First">
                &laquo;
            </a>
        </li>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <li class="page-item <c:if test='${currentPage == i}'>active</c:if>'">
                <a class="page-link" href="?pageNum=${i}&pageSize=${pageSize}&searchType=${searchType}&searchKeyword=${searchKeyword}&filterType=${filterType}&eventType=${eventType}">${i}</a>
            </li>
        </c:forEach>

        <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
            <a class="page-link" href="?pageNum=${totalPages}&pageSize=${pageSize}&searchType=${searchType}&searchKeyword=${searchKeyword}&filterType=${filterType}&eventType=${eventType}" aria-label="Last">
                &raquo;
            </a>
        </li>
    </ul>
</div>
<script>
<%-- 행사 등록 버튼--%>
document.getElementById("btnToEveRegister").addEventListener("click", function(){
    location.href = "${contextPath}/event/register";
});
</script>
</body>
</html>
