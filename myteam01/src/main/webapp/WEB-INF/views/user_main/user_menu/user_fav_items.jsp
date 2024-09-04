<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>${favoriteList.listName}</h2>
        </div>
        <div class="favorite-items">
            <h3>즐겨찾기 항목</h3>
            
            <button id="addFavoriteBtn">즐겨찾기 추가</button>

            <div class="favorite-grid">
                <c:forEach var="favorite" items="${favorites}">
                    <div class="favorite-item">
                        <img src="${favorite.itemImage}" alt="${favorite.itemName}">
                        <p>${favorite.itemName}</p>
                        <form action="/user/favorites/remove" method="post" style="display:inline;">
                            <input type="hidden" name="favoriteId" value="${favorite.id}">
                            <button type="submit">삭제</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>
</div>
</body>
</html>
