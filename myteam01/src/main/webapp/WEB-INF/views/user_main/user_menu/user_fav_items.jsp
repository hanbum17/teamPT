<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/fav.css">

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>${favoriteList.listName}</h2>
            <button id="addFavoriteBtn" class="add-fav-btn">즐겨찾기 추가</button>
            <button id="backBtn" class="back-btn">뒤로</button>
        </div>
        <div class="favorite-items">
            <div class="favorite-grid">
                <c:forEach var="favoriteItem" items="${favoriteItems}">
                    <div class="favorite-item">
                        <img src="${favoriteItem.itemImage}" alt="${favoriteItem.itemName}">
                        <p class="item-name">${favoriteItem.itemName}</p>
                        <form action="/user/favorites/remove" method="post" style="display:inline;">
                            <input type="hidden" name="favoriteId" value="${favoriteItem.favoriteId}">
                            <input type="hidden" name="listId" value="${favoriteItem.listId}">
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
    // 현재 페이지의 URL을 가져옴
    const currentUrl = window.location.href;

    // URL에서 query parameter를 분석하여 eno 또는 fno 확인
    const urlParams = new URLSearchParams(window.location.search);
    const eno = urlParams.get('eno');
    const fno = urlParams.get('fno');

    // 뒤로 버튼 클릭 시 이전 페이지로 이동
    document.getElementById('backBtn').onclick = function() {
        window.history.back();
    };

    // 즐겨찾기 추가 버튼 클릭 시 모달 창 표시
    document.getElementById('addFavoriteBtn').onclick = function() {
        Swal.fire({
            title: '즐겨찾기 항목 추가',
            html: `
                <input type="text" id="itemName" class="swal2-input" placeholder="항목 이름" required>
                <input type="url" id="link" class="swal2-input" placeholder="링크 (URL)" value="${currentUrl}">
                <p>행사 또는 음식점 중 하나만 선택 가능합니다.</p>
            `,
            showCancelButton: true,
            confirmButtonText: '추가',
            cancelButtonText: '취소',
            preConfirm: () => {
                const itemName = Swal.getPopup().querySelector('#itemName').value;
                const link = Swal.getPopup().querySelector('#link').value;

                if (!itemName) {
                    Swal.showValidationMessage('항목 이름을 입력해주세요.');
                }

                return { itemName, link };
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // 서버로 전송하기 위한 POST 요청 생성
                const { itemName, link } = result.value;
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/user/addFavoriteItem'; // 서버로 전송할 URL

                const inputName = document.createElement('input');
                inputName.type = 'hidden';
                inputName.name = 'itemName';
                inputName.value = itemName;

                const inputLink = document.createElement('input');
                inputLink.type = 'hidden';
                inputLink.name = 'link';
                inputLink.value = link;

                const inputEno = document.createElement('input');
                inputEno.type = 'hidden';
                inputEno.name = 'eno';
                inputEno.value = eno || ''; // URL에 eno가 있으면 값 설정, 없으면 빈 문자열

                const inputFno = document.createElement('input');
                inputFno.type = 'hidden';
                inputFno.name = 'fno';
                inputFno.value = fno || ''; // URL에 fno가 있으면 값 설정, 없으면 빈 문자열

                const inputListId = document.createElement('input');
                inputListId.type = 'hidden';
                inputListId.name = 'listId';
                inputListId.value = '${favoriteList.listId}'; // 해당 목록 ID

                form.appendChild(inputName);
                form.appendChild(inputLink);
                form.appendChild(inputEno);
                form.appendChild(inputFno);
                form.appendChild(inputListId);

                document.body.appendChild(form);
                form.submit();
            }
        });
    };
</script>
