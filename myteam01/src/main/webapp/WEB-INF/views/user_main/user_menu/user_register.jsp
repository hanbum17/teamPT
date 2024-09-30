<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/regist.css">

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>등록한 행사 및 음식점</h2>
            <button id="filter-button" class="filter-button">전체 행사/음식점</button>
        </div>
        <div class="registered-items" id="registered-items">
            <ul>
                <c:forEach var="item" items="${registeredItems}">
                    <li id="item-${item.ITEMID}" data-type="${item.ITEMTYPE}">
                        <div class="item-left">
                            <a href="<c:choose>
                                        
                                        <c:when test="${item.ITEMTYPE == 'RESTAURANT'}">
                                            /vroom/restaurant/details?fno=${item.ITEMID}
                                        </c:when>
                                        <c:when test="${item.ITEMTYPE == 'EVENT'}">
                                            /vroom/event/details?eno=${item.ITEMID}
                                        </c:when>
                                    </c:choose>">
                                <c:out value="${item.ITEMNAME}"/>
                            </a>
                            <c:choose>
                                
                                <c:when test="${item.ITEMTYPE == 'RESTAURANT'}">
                                    <div class="item-address">주소: <c:out value="${item.ITEMADDRESS}"/></div>
                                </c:when>
                                <c:when test="${item.ITEMTYPE == 'EVENT'}">
                                    <div class="item-address">장소: <c:out value="${item.ITEMADDRESS}"/></div>
                                </c:when>
                            </c:choose>
                        </div>
                        <div class="item-right">
                            <div class="item-rating">
                                <c:forEach var="i" begin="1" end="${item.ITEMRATING}">
                                    <span class="star">★</span>
                                </c:forEach>
                                <c:forEach var="i" begin="${item.ITEMRATING + 1}" end="5">
                                    <span class="star">☆</span>
                                </c:forEach>
                            </div>
                            <div class="item-date">등록일: <c:out value="${item.REGISTERDATE}"/></div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var filterType = new URLSearchParams(window.location.search).get('filterType') || 'ALL';
        var items = document.querySelectorAll('#registered-items li');

        function applyFilter() {
            items.forEach(function(item) {
                if (filterType === 'ALL' || item.getAttribute('data-type') === filterType) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        }

        applyFilter();

        var filterButton = document.getElementById('filter-button');
        filterButton.addEventListener('click', function() {
            if (filterType === 'ALL') {
                filterType = 'EVENT';
                this.textContent = '전체 행사';
                window.history.replaceState({}, '', '?filterType=EVENT');
            } else if (filterType === 'EVENT') {
                filterType = 'RESTAURANT';
                this.textContent = '전체 음식점';
                window.history.replaceState({}, '', '?filterType=RESTAURANT');
            } else if (filterType === 'RESTAURANT') {
                filterType = 'ALL';
                this.textContent = '전체 행사/음식점';
                window.history.replaceState({}, '', '?filterType=ALL');
            }

            applyFilter();
        });

    });
</script>
