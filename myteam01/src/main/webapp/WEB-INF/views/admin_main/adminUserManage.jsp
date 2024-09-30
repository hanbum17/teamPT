<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../menu/nav.jsp"%>
<%@ include file="../menu/footer.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 관리</title>
<style>
    /* 페이지 전체 배경 색을 지정 */
    body {
        background-color: #f0f0f0;
        font-family: Arial, sans-serif;
    }

    /* 테이블을 가운데 정렬하고 흰색 배경을 지정 */
    .user-table-container, .user-detail-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* 페이지의 전체 높이를 차지하게 설정 */
    }

    .user-table, .user-detail {
        background-color: white; /* 테이블과 수정 폼의 배경을 흰색으로 지정 */
        border-collapse: collapse;
        width: 80%; /* 테이블과 수정 폼의 너비를 80%로 설정 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자를 추가하여 돋보이게 함 */
        padding: 20px;
        max-height: 70vh; /* 높이를 설정하여 스크롤 영역 확보 */
        overflow-y: auto; /* 세로 스크롤을 추가 */
    }

    .user-table th, .user-table td, .user-detail p {
        padding: 12px;
        text-align: left;
        border: 1px solid #ddd; /* 테이블 셀의 경계선 추가 */
    }

    .user-table th {
        background-color: #4CAF50; /* 헤더 배경 색 */
        color: white; /* 헤더 텍스트 색상 */
    }

    .user-detail p strong {
        display: inline-block;
        width: 150px;
    }

    .user-detail input, .user-detail select {
        width: calc(100% - 160px); /* 입력 필드의 너비를 조정하여 배치 */
        padding: 10px;
        border: 1px solid #ddd;
        margin-bottom: 10px;
        border-radius: 4px;
    }

    /* 버튼 영역을 디테일 부분 아래로 배치 */
    .buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 20px; /* 디테일 영역과의 간격 설정 */
    }

    /* 버튼 스타일 */
    .buttons button {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .buttons button:hover {
        background-color: #45a049;
    }

    /* 뒤로가기 버튼 스타일 */
    .buttons #back-btn {
        background-color: #f44336; /* 빨간색으로 설정 */
    }

    .buttons #back-btn:hover {
        background-color: #d32f2f; /* hover 시 더 어두운 빨간색 */
    }
</style>
</head>
<body>

<main>
    <!-- Main content for user management -->
</main>

<script>
$(document).ready(function () {
    // 페이지 로드 시 자동으로 AJAX 호출
    $.ajax({
        type: "get",
        url: "/admin/manage/userList",
        success: function(result) {
            if (Array.isArray(result)) {
                console.log("AJAX 응답 데이터: ", result);
                let th = 
                    "<div class='user-table-container'>" +
                    "<table class='user-table' border='1' cellpadding='10' cellspacing='0'>" +
                    "<thead>" +
                        "<tr>" +
                            "<th>User No</th>" +
                            "<th>아이디</th>" +
                            "<th>닉네임</th>" +
                            "<th>성별</th>" +
                            "<th>마지막 접속일</th>" +
                            "<th>권한</th>" +
                        "</tr>" +
                    "</thead>" +
                    "<tbody></tbody>" +
                    "</table>" +
                    "</div>";
                document.querySelector('main').innerHTML = th; // 테이블 추가

                result.forEach(function(data) {
                    displayData(data);
                });
            } else {
                console.error("AJAX 응답이 배열이 아닙니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
});

// 데이터를 테이블에 표시하는 함수
function displayData(data) {
    const lastLoginFormatted = new Date(data.lastLoginDate).toLocaleDateString('ko-KR');
    let genderText = data.userGender === 'M' ? '남자' : '여자';

    let td = 
        "<tr data-user-id='" + data.userId + "'>" +
            "<td>" + data.userNo + "</td>" +
            "<td><a href='#' class='user-link' data-user-id='" + data.userId + "'>" + data.userId + "</a></td>" +
            "<td>" + data.username + "</td>" +
            "<td>" + genderText + "</td>" +
            "<td>" + lastLoginFormatted + "</td>" +
            "<td>" + data.roles + "</td>" +
        "</tr>";

    document.querySelector("table.user-table tbody").innerHTML += td;
}

$(document).ready(function() {
    $(document).on("click", ".user-link", function (e) {
        e.preventDefault();
        var userId = $(this).data("user-id");

        if (!userId) return;

        $.ajax({
            type: "get",
            url: "/admin/manage/userDetail",
            data: { userId: userId },
            success: function (result) {
                console.log(result);
                let accountStatusText = result.accountStatus === 0 ? "활성화" : "비활성화";
                let genderText = result.userGender === "M" ? "남자" : "여자";

                document.querySelector('main').innerHTML = "";

                let detailPage = 
                    "<div class='user-detail-container'>" +
                        "<div class='user-detail' id='user-info'>" +
                            "<p><strong>User No:</strong> <span id='userNo'>" + result.userNo + "</span></p>" +
                            "<p><strong>아이디:</strong> <span id='userId'>" + result.userId + "</span></p>" +
                            "<p><strong>비밀번호:</strong> <input type='text' id='userPw-input' value='" + result.userPw + "' /></p>" +
                            "<p><strong>닉네임:</strong> <input type='text' id='username-input' value='" + result.username + "' /></p>" +
                            "<p><strong>성별:</strong>" +
                                "<select id='userGender-input'>" +
                                    "<option value='M'" + (result.userGender === 'M' ? " selected" : "") + ">남자</option>" +
                                    "<option value='F'" + (result.userGender === 'F' ? " selected" : "") + ">여자</option>" +
                                "</select>" +
                            "</p>" +
                            "<p><strong>전화번호:</strong> <input type='text' id='userCall-input' value='" + result.userCall + "' /></p>" +
                            "<p><strong>주소:</strong> <input type='text' id='userAddress-input' value='" + result.userAddress + "' /></p>" +
                            "<p><strong>이메일:</strong> <input type='text' id='userEmail-input' value='" + result.userEmail + "' /></p>" +
                            "<p><strong>User Type:</strong> <input type='text' id='userType-input' value='" + result.userType + "' /></p>" +
                            "<p><strong>가입일:</strong> " + result.joinDate + "</p>" +
                            "<p><strong>마지막 접속일:</strong> " + result.lastLoginDate + "</p>" +
                            "<p><strong>계정 상태:</strong>" +
                                "<select id='accountStatus-input'>" +
                                    "<option value='0'" + (result.accountStatus === 0 ? " selected" : "") + ">활성화</option>" +
                                    "<option value='1'" + (result.accountStatus === 1 ? " selected" : "") + ">비활성화</option>" +
                                "</select>" +
                            "</p>" +
                        "</div>" +
                        "<div class='buttons'>" +
                            "<button id='confirm-btn'>수정</button>" +
                            "<button id='back-btn'>뒤로가기</button>" +
                        "</div>" +
                    "</div>";

                document.querySelector('main').innerHTML = detailPage;

                $("#confirm-btn").on("click", function() {
                    const userVO = {
                        userNo: $("#userNo").text(),
                        userId: $("#userId").text(),
                        userPw: $("#userPw-input").val(),
                        userName: $("#username-input").val(),
                        userGender: $("#userGender-input").val(),
                        userCall: $("#userCall-input").val(),
                        userAddress: $("#userAddress-input").val(),
                        userEmail: $("#userEmail-input").val(),
                        userType: $("#userType-input").val(),
                        accountStatus: $("#accountStatus-input").val(),
                    };

                    $.ajax({
                        type: "post",
                        url: "/admin/manage/userUpdate",
                        data: userVO,
                        success: function(response) {
                            alert(response);
                            location.reload(); // 성공 후 페이지 새로고침 또는 다른 동작 처리
                        }
                    });
                });

                // 뒤로가기 버튼 클릭 시 목록으로 돌아가기
                $("#back-btn").on("click", function() {
                    location.reload(); // 페이지를 새로고침하여 목록 화면으로 돌아가기
                });
            }
        });
    });
});
</script>
</body>
</html>
