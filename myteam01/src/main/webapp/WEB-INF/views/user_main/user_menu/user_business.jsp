<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>비지니스 - 등록된 사업 정보</h2>
        </div>
        <div class="business-info">
            <h3>내가 등록한 사업</h3>
            <ul>
                <c:forEach var="business" items="${userBusinesses}">
                    <li>${business.name} - ${business.type} - <a href="${business.link}">자세히 보기</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>
</div>
</body>
</html>
