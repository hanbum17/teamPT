<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>등록한 행사 및 음식점</h2>
        </div>
        <div class="registered-items">
            <h3>내가 등록한 행사 및 음식점</h3>
            <ul>
                <c:forEach var="item" items="${registeredItems}">
                    <li>${item.name} - ${item.type} - <a href="${item.link}">자세히 보기</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>
</div>
</body>
</html>
