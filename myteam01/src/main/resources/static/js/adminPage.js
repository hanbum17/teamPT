// 날짜를 yyyy-MM-dd 형식으로 변환하는 함수
function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1 더해줌
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`; // 시간 부분은 제거
}

$("#selectUserList").on("click", function (e) {
    e.preventDefault();

    $.ajax({
        type: "get",
        url: "/admin/manage/userList",
        success: function(result) {
            console.log(result);
            // 테이블 구조 정의
            let th = `
                <div class="user-table-container">
                    <table class="user-table" border="1" cellpadding="10" cellspacing="0">
                        <thead>
                            <tr>
                                <th>User No</th>
                                <th>아이디</th>
                                <th>닉네임</th>
                                <th>성별</th>
                                <th>마지막 접속일</th>
                                <th>권한</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>`;
            document.querySelector('main').innerHTML = th; // 테이블 추가

            for (var i in result) {
                displayData(result[i]);
            }
        }
    });
});

// 데이터를 테이블에 표시하는 함수
function displayData(data) {
    const lastLoginFormatted = formatDate(data.lastLoginDate); // 마지막 접속일 포맷 적용

    // 성별 표시 변경 (M -> 남자, F -> 여자)
    let genderText = data.userGender === 'M' ? '남자' : '여자';

    let td = `
        <tr data-user-id="${data.userId}">
            <td>${data.userNo}</td>
            <td><a href="#" class="user-link" data-user-id="${data.userId}">${data.userId}</a></td>
            <td>${data.username}</td>
            <td>${genderText}</td>
            <td>${lastLoginFormatted}</td>
            <td>${data.roles}</td>
        </tr>`;

    // <tbody>에 행 추가
    document.querySelector('table.user-table tbody').innerHTML += td;
}


$(document).ready(function() {
    // 클릭 시 사용자 정보 요청 (a 태그 클릭 시 작동)
    $(document).on("click", ".user-link", function (e) {
        e.preventDefault();  // a 태그의 기본 동작(페이지 이동) 막기
        var userId = $(this).data("user-id"); // 클릭한 a 태그의 data-user-id에서 userId 가져옴

        if (!userId) return; // userId가 없으면 실행하지 않음

        $.ajax({
            type: "get",
            url: "/admin/manage/userDetail",
            data: { userId: userId }, // userId를 서버로 전송
            success: function (result) {
                console.log(result);

                // 계정 상태에 따른 표시
                let accountStatusText = result.accountStatus === 0 ? "활성화" : "비활성화";
                let genderText = result.userGender === "M" ? "남자" : "여자";

                // 기존 내용을 삭제
                document.querySelector('main').innerHTML = '';

                // 새로운 상세 페이지 구조 정의 (수정 버튼 추가)
                let detailPage = `
                    <div class="user-detail-container">
                        <h2>사용자 상세 정보</h2>
                        <div class="user-detail" id="user-info">
                            <p><strong>User No:</strong> <span id="userNo">${result.userNo}</span></p>
                            <p><strong>아이디:</strong> <span id="userId">${result.userId}</span></p>
                            <p><strong>비밀번호:</strong> <span id="userPw">${result.userPw}</span></p>
                            <p><strong>닉네임:</strong> <span id="username">${result.username}</span></p>
                            <p><strong>성별:</strong> <span id="userGender">${genderText}</span></p>
                            <p><strong>전화번호:</strong> <span id="userCall">${result.userCall}</span></p>
                            <p><strong>주소:</strong> <span id="userAddress">${result.userAddress}</span></p>
                            <p><strong>이메일:</strong> <span id="userEmail">${result.userEmail}</span></p>
                            <p><strong>User Type:</strong> <span id="userType">${result.userType}</span></p>
                            <p><strong>가입일:</strong> <span>${formatDate(result.joinDate)}</span></p>
                            <p><strong>마지막 접속일:</strong> <span>${formatDate(result.lastLoginDate)}</span></p>
                            <p><strong>계정 상태:</strong> <span id="accountStatus">${accountStatusText}</span></p>
                            <p><strong>권한:</strong> <span id="roles">${result.roles}</span></p>
                        </div>
                        <div class="buttons">
                            <button id="edit-btn">수정</button>
                        </div>
                    </div>`;

                // 새로운 상세 페이지를 main 태그에 추가
                document.querySelector('main').innerHTML = detailPage;

                // 수정 버튼 클릭 시
                $("#edit-btn").on("click", function() {
                    enableEditMode(result); // 수정 모드로 변경
                });
            }
        });
    });

    // 수정 모드 활성화 함수
    function enableEditMode(user) {
        const originalState = $("#user-info").html(); // 수정 전 상태를 저장

        // 계정 상태를 select box로 변경
        let accountStatusSelect = `
            <select id="accountStatus-input">
                <option value="0" ${user.accountStatus === 0 ? "selected" : ""}>활성화</option>
                <option value="1" ${user.accountStatus === 1 ? "selected" : ""}>비활성화</option>
            </select>`;

        // 성별을 select box로 변경
        let genderSelect = `
            <select id="userGender-input">
                <option value="M" ${user.userGender === "M" ? "selected" : ""}>남자</option>
                <option value="F" ${user.userGender === "F" ? "selected" : ""}>여자</option>
            </select>`;

        $("#userPw").html(`<input type="text" id="userPw-input" value="${user.userPw}">`);
        $("#username").html(`<input type="text" id="username-input" value="${user.username}">`);
        $("#userGender").html(genderSelect);
        $("#userCall").html(`<input type="text" id="userCall-input" value="${user.userCall}">`);
        $("#userAddress").html(`<input type="text" id="userAddress-input" value="${user.userAddress}">`);
        $("#userEmail").html(`<input type="text" id="userEmail-input" value="${user.userEmail}">`);
        $("#userType").html(`<input type="text" id="userType-input" value="${user.userType}">`);
        $("#accountStatus").html(accountStatusSelect);

        // 버튼 변경
        $(".buttons").html(`
            <button id="confirm-btn">확인</button>
            <button id="cancel-btn">취소</button>
        `);

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

            // 서버로 수정된 데이터 전송
            $.ajax({
                type: "post",
                url: "/admin/manage/userUpdate",
                data: userVO,
                success: function(response) {
                    alert(response);

                    // 수정된 내용을 바로 확인하기 위해 상세 정보를 다시 표시
                    $.ajax({
                        type: "get",
                        url: "/admin/manage/userDetail",
                        data: { userId: userVO.userId },
                        success: function (result) {
                            let accountStatusText = result.accountStatus === 0 ? "활성화" : "비활성화";
                            let genderText = result.userGender === "M" ? "남자" : "여자";

                            $("#userPw").html(result.userPw);
                            $("#username").html(result.username);
                            $("#userGender").html(genderText);
                            $("#userCall").html(result.userCall);
                            $("#userAddress").html(result.userAddress);
                            $("#userEmail").html(result.userEmail);
                            $("#userType").html(result.userType);
                            $("#accountStatus").html(accountStatusText);
                        }
                    });
                }
            });
        });

        $("#cancel-btn").on("click", function() {
            $("#user-info").html(originalState);
            $(".buttons").html(`<button id="edit-btn">수정</button>`);
            $("#edit-btn").on("click", function() {
                enableEditMode(user);
            });
        });
    }
});
