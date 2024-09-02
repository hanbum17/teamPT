<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css">
    <title>행사 & 음식점 목록</title>
</head>

<body>
    <header class="header">
        <h2 class="title">행사 & 음식점 목록</h2>
        <div class="top-bar">
            <a href="<c:url value='/logout'/>" class="logout-link">로그아웃</a>
            <button type="button" id="btnToEveRegister" class="register-button">행사 등록</button>
        </div>
    </header>

    <!-- Search and Filter Form -->
    <form id="searchForm" method="get" action="/list" autocomplete="off" class="search-form">
        <div class="form-group">
            <label for="searchType">검색 기준:</label>
            <select id="searchType" name="searchType" class="form-control">
                <option value="name" <c:if test="${searchType == 'name'}">selected</c:if>>이름</option>
                <option value="address" <c:if test="${searchType == 'address'}">selected</c:if>>주소</option>
            </select>
        </div>

        <div class="form-group">
            <input type="text" id="searchKeyword" name="searchKeyword" placeholder="키워드를 입력하세요" value="${searchKeyword}" class="form-control" />
        </div>

        <div class="search-group">
            <button type="submit" class="search-button">검색</button>
            <button type="button" class="reset-button" onclick="resetFilters()">초기화</button>
        </div>

        <div class="form-group">
            <label for="filterType">카테고리:</label>
            <select id="filterType" name="filterType" class="form-control" onchange="updateUrlParam('filterType', this.value)">
                <option value="전체" <c:if test="${filterType == '전체'}">selected</c:if>>전체</option>
                <option value="축제" <c:if test="${filterType == '축제'}">selected</c:if>>축제</option>
                <option value="음식점" <c:if test="${filterType == '음식점'}">selected</c:if>>음식점</option>
            </select>
        </div>

        <div class="form-group">
            <label for="eventType">권한:</label>
            <select id="eventType" name="eventType" class="form-control" onchange="updateUrlParam('eventType', this.value)">
                <option value="" <c:if test="${eventType == ''}">selected</c:if>>전체</option>
                <option value="1" <c:if test="${eventType == '1'}">selected</c:if>>유저</option>
                <option value="0" <c:if test="${eventType == '0'}">selected</c:if>>관리자</option>
            </select>
        </div>

        <div class="form-group">
            <label for="pageSize">페이지 크기:</label>
            <select id="pageSize" name="pageSize" class="form-control" onchange="updateUrlParam('pageSize', this.value)">
                <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10</option>
                <option value="30" <c:if test="${pageSize == 30}">selected</c:if>>30</option>
                <option value="50" <c:if test="${pageSize == 50}">selected</c:if>>50</option>
            </select>
        </div>
    </form>

    <table class="list-table">
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
		            <td>
		                <!-- 이름에 링크 추가 -->
		                <c:choose>
		                    <c:when test="${item.LDICTIONARY == '축제'}">
		                        <form id="eventForm${item.LNUMBER}" action="${pageContext.request.contextPath}/event/detail" method="get" style="display:inline;">
		                            <input type="hidden" name="eno" value="${item.REALNO}" />
		                            <a href="javascript:document.getElementById('eventForm${item.LNUMBER}').submit();" class="no-link-style">${item.LNAME}</a>
		                        </form>
		                    </c:when>
		                    <c:when test="${item.LDICTIONARY == '음식점'}">
		                        <form id="restaurantForm${item.LNUMBER}" action="${pageContext.request.contextPath}/restaurant/detail" method="get" style="display:inline;">
		                            <input type="hidden" name="fno" value="${item.REALNO}" />
		                            <a href="javascript:document.getElementById('restaurantForm${item.LNUMBER}').submit();" class="no-link-style">${item.LNAME}</a>
		                        </form>
		                    </c:when>
		                </c:choose>
		            </td>
		            <td>${item.LADDRESS}</td>
		            <td>${item.LRATING}</td>
		            <td>${item.LVIEWSCNT}</td>
		            <td>
					    <c:choose>
					        <c:when test="${item.LTYPE == 1}">
					            유저
					        </c:when>
					        <c:otherwise>
					            관리자
					        </c:otherwise>
					    </c:choose>
					</td>
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
            <c:set var="pageRange" value="2" />
            <c:set var="startPage" value="${currentPage - pageRange > 1 ? currentPage - pageRange : 1}" />
            <c:set var="endPage" value="${currentPage + pageRange < totalPages ? currentPage + pageRange : totalPages}" />

            <!-- 첫 페이지로 이동 버튼 -->
            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                <a class="page-link" href="?pageNum=1&pageSize=${pageSize}&searchType=${searchType}&searchKeyword=${searchKeyword}&filterType=${filterType}&eventType=${eventType}" aria-label="First">
                    &laquo;
                </a>
            </li>

            <!-- 페이지 번호 반복 -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li class="page-item <c:if test='${currentPage == i}'>active</c:if>'">
                    <a class="page-link" href="?pageNum=${i}&pageSize=${pageSize}&searchType=${searchType}&searchKeyword=${searchKeyword}&filterType=${filterType}&eventType=${eventType}">${i}</a>
                </li>
            </c:forEach>

            <!-- 마지막 페이지로 이동 버튼 -->
            <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
                <a class="page-link" href="?pageNum=${totalPages}&pageSize=${pageSize}&searchType=${searchType}&searchKeyword=${searchKeyword}&filterType=${filterType}&eventType=${eventType}" aria-label="Last">
                    &raquo;
                </a>
            </li>
        </ul>
    </div>

    <script>
    // Function to update URL parameters without duplicating existing ones
    function updateUrlParam(paramName, paramValue) {
        const url = new URL(window.location.href);

        // Set the new value for the parameter
        url.searchParams.set(paramName, paramValue);

        // Remove empty parameters to avoid adding empty query strings
        if (paramValue === '') {
            url.searchParams.delete(paramName);
        }

        // Reload the page with updated parameters
        window.location.href = url.toString();
    }

    // Function to reset all filters and search inputs
    function resetFilters() {
        const url = new URL(window.location.href);

        // Clear all relevant search parameters
        url.searchParams.delete('searchKeyword');
        url.searchParams.delete('searchType');
        url.searchParams.delete('filterType');
        url.searchParams.delete('eventType');
        url.searchParams.delete('pageSize');

        // Reload the page with the reset parameters
        window.location.href = url.toString();
    }

    document.getElementById("btnToEveRegister").addEventListener("click", function(){
        location.href = "${pageContext.request.contextPath}/event/register";
    });
    </script>
</body>
</html>
