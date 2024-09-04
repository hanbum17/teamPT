<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/fav.css">

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>즐겨찾기 목록</h2>
        </div>
        <div class="favorite-list">
            <h3>나의 즐겨찾기</h3>

            <!-- Add Favorite List Button -->
            <button id="addFavoriteListBtn">즐겨찾기 목록 추가</button>

            <!-- Favorite Lists -->
            <ul id="favoriteList">
                <c:forEach var="favoriteList" items="${favoriteLists}">
                    <li>${favoriteList.listName} - <a href="/user/user_fav_items?listId=${favoriteList.listId}">자세히 보기</a></li>
                </c:forEach>
            </ul>
        </div>

        <!-- Modal for Adding a Favorite List -->
        <div id="favoriteListModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>즐겨찾기 목록 추가</h2>
                <form action="/user/addFavoriteList" method="post">
                    <label for="listName">목록 이름:</label>
                    <input type="text" id="listName" name="listName" required>
                    <button type="submit">추가</button>
                </form>
            </div>
        </div>

    </div>
</main>
</div>
</body>
</html>

<script>
//Get the modal elements
var modal = document.getElementById("favoriteListModal");
var btn = document.getElementById("addFavoriteListBtn");
var span = document.getElementsByClassName("close")[0];

// Open the modal
btn.onclick = function() {
    modal.style.display = "block";
}

// Close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// Close modal when clicking outside of it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
