<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/fav.css">

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <button id="backBtn" class="back-btn">뒤로</button>
            <h2>${favoriteList.LISTNAME}</h2>
            <button id="addFavoriteBtn" class="add-fav-btn">즐겨찾기 추가</button>
        </div>
        <div class="favorite-items">
            <div class="favorite-grid">
                <c:forEach var="favoriteItem" items="${favoriteItems}">
                    <div class="favorite-item">
                        <img src="${favoriteItem.itemImage}" alt="${favoriteItem.ITEMNAME}">
                        <p class="item-name">${favoriteItem.ITEMNAME}</p>
                        <form action="/user/favorites/remove" method="post" style="display:inline;">
                            <input type="hidden" name="favoriteId" value="${favoriteItem.ITEMID}">
                            <input type="hidden" name="listId" value="${favoriteList.LISTID}">
                            <button type="submit" class="delete-btn">삭제</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<!-- Include SweetAlert2 CSS and JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<script>
    // 뒤로 버튼 클릭 시 이전 페이지로 이동
    document.getElementById('backBtn').onclick = function() {
        window.history.back();
    };

    // 즐겨찾기 추가 버튼 클릭 시 모달 창 표시
    document.getElementById('addFavoriteBtn').onclick = function() {
        Swal.fire({
            title: '즐겨찾기 항목 추가 (임시)',
            html: '<input type="text" id="itemName" class="swal2-input" placeholder="항목 이름" required>',
            showCancelButton: true,
            confirmButtonText: '추가',
            cancelButtonText: '취소',
            preConfirm: () => {
                const itemName = Swal.getPopup().querySelector('#itemName').value;
                if (!itemName) {
                    Swal.showValidationMessage('항목 이름을 입력해주세요.');
                }
                return { itemName: itemName };
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // 임시 항목 추가 로직
                Swal.fire('등록 완료', '즐겨찾기 항목이 추가되었습니다.', 'success');
            }
        });
    };
</script>
