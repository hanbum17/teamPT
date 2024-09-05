<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/fav.css">

<!-- Include SweetAlert2 CSS and JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>즐겨찾기 목록</h2>
            <!-- Add Favorite List Button (moved to the header) -->
            <button id="addFavoriteListBtn" class="add-list-btn">즐겨찾기 목록 추가</button>
        </div>
        <div class="favorite-list">
            <!-- Favorite Lists -->
            <div id="favoriteList" class="favorite-grid">
                <c:forEach var="favoriteList" items="${favoriteLists}">
                    <a href="/user/user_fav_items?listId=${favoriteList.listId}" class="favorite-list-item">
                        <h4>${favoriteList.listName} </h4>
                        <h5>${favoriteList.items.size()} items</h5>
                        <div class="actions">
                            <button class="edit-btn" type="button">수정</button>
                            <button class="delete-btn" type="button">삭제</button>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<script>
    // 즐겨찾기 목록 추가 버튼 클릭 시 SweetAlert2 사용
    document.getElementById('addFavoriteListBtn').onclick = function() {
        Swal.fire({
            title: '즐겨찾기 목록 추가',
            html: '<input type="text" id="listName" class="swal2-input" placeholder="목록 이름" required>',
            showCancelButton: true,
            confirmButtonText: '추가',
            cancelButtonText: '취소',
            preConfirm: () => {
                const listName = Swal.getPopup().querySelector('#listName').value;
                if (!listName) {
                    Swal.showValidationMessage(`목록 이름을 입력해주세요.`);
                }
                return { listName: listName };
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // AJAX or form submission to add the favorite list
                const listName = result.value.listName;
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/user/addFavoriteList';

                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'listName';
                input.value = listName;
                form.appendChild(input);

                document.body.appendChild(form);
                form.submit();
            }
        });
    };

    document.querySelectorAll('.edit-btn').forEach(function(button) {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            event.stopPropagation();

            const listItem = button.closest('.favorite-list-item');
            const listId = listItem.getAttribute('href').split('=')[1]; // URL에서 listId 추출
            const currentName = listItem.querySelector('h4').textContent.trim();

            Swal.fire({
                title: '목록 이름 수정',
                input: 'text',
                inputLabel: '새로운 목록 이름을 입력하세요',
                inputValue: currentName,
                showCancelButton: true,
                confirmButtonText: '수정',
                cancelButtonText: '취소',
                preConfirm: (newName) => {
                    if (!newName) {
                        Swal.showValidationMessage(`목록 이름을 입력해주세요.`);
                    }
                    return { listId: listId, listName: newName };
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    const { listId, listName } = result.value;

                    // 서버로 수정된 데이터 전송
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '/user/updateFavoriteList'; // 수정 요청 URL

                    const inputId = document.createElement('input');
                    inputId.type = 'hidden';
                    inputId.name = 'listId';
                    inputId.value = listId;

                    const inputName = document.createElement('input');
                    inputName.type = 'hidden';
                    inputName.name = 'listName';
                    inputName.value = listName;

                    form.appendChild(inputId);
                    form.appendChild(inputName);

                    document.body.appendChild(form);
                    form.submit();
                }
            });
        });
    });
    
    document.querySelectorAll('.delete-btn').forEach(function(button) {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            event.stopPropagation();

            const listItem = button.closest('.favorite-list-item');
            const listId = listItem.getAttribute('href').split('=')[1]; // URL에서 listId 추출

            Swal.fire({
                title: '정말 삭제하시겠습니까?',
                text: "이 작업은 되돌릴 수 없습니다!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '삭제',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 서버로 삭제 요청 전송
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '/user/deleteFavoriteList'; // 삭제 요청 URL

                    const inputId = document.createElement('input');
                    inputId.type = 'hidden';
                    inputId.name = 'listId';
                    inputId.value = listId;

                    form.appendChild(inputId);

                    document.body.appendChild(form);
                    form.submit();
                }
            });
        });
    });

</script>
s