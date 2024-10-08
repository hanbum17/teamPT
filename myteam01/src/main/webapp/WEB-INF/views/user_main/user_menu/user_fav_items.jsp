<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- External CSS for styling -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/user_menu/favitem.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<main class="content-box">
	<div class="content">
		<div class="content-header">
			<h2>${favoriteList.listName}</h2> 
			<button id="BackBtn" class="back-btn">뒤로</button>
		</div>

		<div class="fav-playlist-container">
			<div class="fav-items-container">
				<c:forEach var="favoriteItem" items="${favoriteItems}">
					<div class="fav-item" onclick="navigateTo('${favoriteItem.link}')" style="border-right-color: ${favoriteList.color};">
						<div class="fav-item-thumbnail">
							<%-- <img src="${favoriteItem.thumbnail}" alt="Thumbnail"> --%>
						</div>
						<div class="fav-item-info">
							<c:choose>
								<c:when test="${favoriteItem.event != null}">
									<h4>${favoriteItem.event.ename}</h4>
									<p>
										<c:forEach var="i" begin="1" end="${favoriteItem.event.erating}">
											<i class="fa fa-star"></i>
										</c:forEach>
										<c:forEach var="i" begin="${favoriteItem.event.erating + 1}" end="5">
											<i class="fa fa-regular fa-star"></i>
										</c:forEach>
									</p>
									<p class="ellipsis-text">${favoriteItem.event.eaddress}</p>
								</c:when>

								<c:when test="${favoriteItem.restaurant != null}">
									<h4>${favoriteItem.restaurant.fname}</h4>
									<p>
										<c:forEach var="i" begin="1" end="${favoriteItem.restaurant.frating}">
											<i class="fa fa-star"></i>
										</c:forEach>
										<c:forEach var="i" begin="${favoriteItem.restaurant.frating + 1}" end="5">
											<i class="fa fa-regular fa-star"></i>
										</c:forEach>
									</p>
									<p class="ellipsis-text">${favoriteItem.restaurant.faddress}</p>
								</c:when>
							</c:choose>
						</div>

						<div class="fav-item-actions">
							<div class="fav-dropdown">
								<button class="fav-more-btn" onclick="event.stopPropagation();">⋮</button>
								<div class="fav-dropdown-content">
									<button class="fav-edit-btn" type="button" onclick="showEditModal(${favoriteItem.favoriteId}); event.stopPropagation();">수정</button>


									<form action="/user/favorites/remove" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');" onclick="event.stopPropagation();">
										<input type="hidden" name="favoriteId" value="${favoriteItem.favoriteId}">
										<input type="hidden" name="listId" value="${favoriteItem.listId}">
										<button class="fav-delete-btn" type="submit">삭제</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- 수정 모달 -->
	<div id="editModal" class="modal" style="display:none;">
	  <div class="modal-content">
	    <h3>즐겨찾기 수정</h3>
	    <label for="newList">이동할 즐겨찾기 목록을 선택하세요:</label>
	    <select id="newListSelect" size="5">
	      <c:forEach var="list" items="${favoriteLists}">
	        <option value="${list.listId}">${list.listName}</option>
	      </c:forEach>
	    </select>
	    <button id="saveChangesBtn">저장</button>
	    <button id="closeModalBtn">닫기</button>
	  </div>
	</div>
	
</main>

<script>
	// 뒤로가기 버튼
	document.getElementById('BackBtn').onclick = function() {
		window.history.back();
	};

	// 클릭 시 해당 링크로 이동하는 함수
	function navigateTo(url) {
		window.location.href = url;
	}
	
	// 수정 모달 보여주기
	function showEditModal(favoriteId) {
	    document.getElementById('editModal').style.display = 'block';
	    document.getElementById('saveChangesBtn').onclick = function() {
	        const newListId = document.getElementById('newListSelect').value;
	        updateFavoriteList(favoriteId, newListId);
	    };
	}

	// 모달 닫기
	document.getElementById('closeModalBtn').onclick = function() {
	    document.getElementById('editModal').style.display = 'none';
	};
	


	// Ajax로 즐겨찾기 목록 업데이트
	function updateFavoriteList(favoriteId, newListId) {
	    $.ajax({
	        type: 'POST',
	        url: '/user/favorites/updateList',
	        data: {
	            favoriteId: favoriteId,
	            newListId: newListId
	        },
	        success: function(response) {
	            alert('즐겨찾기 목록이 변경되었습니다.');
	            window.location.reload();  // 페이지 새로고침
	        },
	        error: function(xhr, status, error) {
	            alert('즐겨찾기 목록 변경에 실패했습니다.');
	        }
	    });
	}
</script>
