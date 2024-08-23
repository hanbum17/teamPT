<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css">
    <style>
        .form-step {
            display: none;
        }
        .form-step.active {
            display: block;
        }
        .step-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .step-buttons button:disabled {
            background-color: grey;
            cursor: not-allowed;
        }
    </style>
</head>
<body class="flex-center">
    <div class="container">
        <h2 class="title">VROOM 회원가입</h2>

        <!-- 선택된 회원 유형을 확인하기 위한 디버깅 출력 -->
        <p>선택된 회원 유형: ${param.role}</p>

        <form id="registrationForm" action="/user/register" method="post" class="register-form">
            <!-- 선택된 회원 유형을 숨겨진 필드로 전달 -->
            <input type="hidden" name="role" value="${param.role}">

            <!-- Step 1: 기본 정보 -->
            <div class="form-step active" id="step1">
                <div class="input-wrapper">
                    <label for="userId">User ID</label>
                    <input type="text" id="userId" name="userId" required>
                </div>

                <div class="input-wrapper">
                    <label for="userPw">Password</label>
                    <input type="password" id="userPw" name="userPw" required>
                </div>

                <div class="input-wrapper">
                    <label for="userName">Name</label>
                    <input type="text" id="userName" name="userName" required>
                </div>

                <div class="input-wrapper">
                    <label>Gender</label>
                    <div class="gender-options">
                        <input type="radio" id="male" name="userGender" value="M" required>
                        <label for="male" class="gender-label">Male</label>
                
                        <input type="radio" id="female" name="userGender" value="F" required>
                        <label for="female" class="gender-label">Female</label>
                    </div>
                </div>
            </div>

            <!-- Step 2: 추가 정보 -->
            <div class="form-step" id="step2">
                <div class="input-wrapper">
                    <label for="userCall">Call</label>
                    <input type="text" id="userCall" name="userCall" required>
                </div>

                <div class="input-wrapper">
                    <label for="userAddress">Address</label>
                    <input type="text" id="userAddress" name="userAddress" required>
                </div>

                <div class="input-wrapper">
                    <label for="userEmail">Email</label>
                    <input type="email" id="userEmail" name="userEmail" required>
                </div>
            </div>

            <!-- Step Navigation Buttons -->
            <div class="step-buttons">
                <button type="button" id="prevBtn" onclick="changeStep(-1)" style="display: none;">Previous</button>
                <button type="button" id="nextBtn" onclick="changeStep(1)" disabled>Next</button>
                <button type="submit" id="submitBtn" class="register-button" style="display: none;">Register</button>
            </div>
        </form>

        <form action="/user/login" method="get" class="back-form">
            <div class="button-wrapper flex-center">
                <button type="submit" class="back-button">돌아가기</button>
            </div>
        </form>
    </div>

    <script>
        let currentStep = 1;

        document.querySelectorAll('#step1 input').forEach(input => {
            input.addEventListener('input', checkStep1Completion);
        });

        function checkStep1Completion() {
            const userId = document.getElementById('userId').value.trim();
            const userPw = document.getElementById('userPw').value.trim();
            const userName = document.getElementById('userName').value.trim();
            const userGender = document.querySelector('input[name="userGender"]:checked');

            if (userId && userPw && userName && userGender) {
                document.getElementById('nextBtn').disabled = false;
            } else {
                document.getElementById('nextBtn').disabled = true;
            }
        }

        function changeStep(step) {
            const steps = document.querySelectorAll('.form-step');
            currentStep += step;

            // Step boundary control
            if (currentStep < 1) currentStep = 1;
            if (currentStep > steps.length) currentStep = steps.length;

            // Hide all steps and show the current step
            steps.forEach((stepElement, index) => {
                stepElement.classList.remove('active');
                if (index + 1 === currentStep) {
                    stepElement.classList.add('active');
                }
            });

            // Manage buttons visibility
            document.getElementById('prevBtn').style.display = currentStep > 1 ? 'inline-block' : 'none';
            document.getElementById('nextBtn').style.display = currentStep < steps.length ? 'inline-block' : 'none';
            document.getElementById('submitBtn').style.display = currentStep === steps.length ? 'inline-block' : 'none';
        }
    </script>
</body>
</html>
