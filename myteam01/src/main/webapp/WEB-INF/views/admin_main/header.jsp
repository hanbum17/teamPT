<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* styles.css */

/* 노멀라이즈 시작 */
body, ul, li {
  margin: 0;
  padding: 0;
  list-style: none;   /* 해당 태그의 list-style을 none으로 하는 것으로 ●을 제거한다 */
}

a {
  color: inherit;   /* 부모 엘리먼트의 값을 물려받는다 */
  text-decoration: none;    /* 해당 태그의 text-decoration 속성을 none 값으로 하는 것으로 밑줄을 제거한다 */
}
/* 노멀라이즈 끝 */

/* 커스텀 시작 */
.side-bar > ul ul {
  display: none;
}

/* 사이트의 높이를 5000px로 만들어 스크롤 생성 */
body {
  height: 5000px;
  background-color: #444;
}

/* 사이드바 시작 */

/* 사이드바의 너비와 높이를 변수를 통해 통제 */
:root {
  --side-bar-width: 270px;
  --side-bar-height: 90vh;
}

.side-bar {
  position: fixed;    /* 스크롤을 따라오도록 지정 */
  background-color: white;
  width: var(--side-bar-width);
  min-height: var(--side-bar-height);   /* 사이드바의 높이를 전체 화면 높이의 90%로 지정 */
  margin-top: calc((100vh - var(--side-bar-height)) / 2);    /* 사이드바 위와 아래의 마진을 동일하게 지정 */
}

/* 아이콘 시작 */
.side-bar__icon-box {
  display: flex;
  justify-content: flex-end;
}

.side-bar__icon-1 {
  position: relative;
  width: 23px;
  height: 17px;
  margin: 15px;
  margin-top: 20px;
  transition: .5s;
}

:root {
  --side-bar__icon: .5s;
}

.side-bar__icon-1 > div {
  position: absolute;
  width: 100%;
  height: 20%;
  background-color: black;
  transition: all var(--side-bar__icon);
}

.side-bar__icon-1 > div:nth-of-type(1) {
  top: 0;
  width: auto;
  left: 0;
  right: 0;
  transition: all var(--side-bar__icon), left calc(var(--side-bar__icon) / 2) calc(var(--side-bar__icon) / 2), right calc(var(--side-bar__icon) / 2) calc(var(--side-bar__icon) / 2), height calc(var(--side-bar__icon) / 2) 0s;
}

.side-bar__icon-1 > div:nth-of-type(2) {
  top: 40%;
  transform-origin:bottom left;
}

.side-bar__icon-1 > div:nth-of-type(3) {
  top: 80%;
  left: auto;
  right: 0;
  transform-origin:bottom right;
}


.side-bar:hover .side-bar__icon-1 {
  transform: translate(-198px, 0);
}

.side-bar:hover .side-bar__icon-1 > div:nth-of-type(2) {
  transform:rotate(45deg);
  width: 70.5%;
  height: 25%;
}

.side-bar:hover .side-bar__icon-1 > div:nth-of-type(3) {
  top: 40%;
  transform:rotate(-45deg);
  width: 70.5%;
  height: 25%;
}

.side-bar:hover .side-bar__icon-1 > div:nth-of-type(1) {
  left: 41%;
  right: 41%;
  height: 100%;
  transition: all var(--side-bar__icon), left calc(var(--side-bar__icon) / 2) 0s, right calc(var(--side-bar__icon) / 2) 0s, height calc(var(--side-bar__icon) / 2) calc(var(--side-bar__icon) / 2);
}
/* 아이콘 끝 */

/* 모든 메뉴의 a에 속성값 부여 */
.side-bar ul > li > a {
  display: block;
  color: black;
  font-size: 1.05rem; /* 글자 크기를 기존 크기의 4분의 3으로 줄임 */
  font-weight: bold;
  padding-top: 20px;
  padding-bottom: 20px;
  padding-left: 50px;
  transition: .5s;
}

/* 자식의 position이 absolute일 때 자식을 영역 안에 가두어 준다 */
.side-bar > ul > li {
  position: relative;
}

/* 모든 메뉴가 마우스 인식 시 반응 */
.side-bar ul > li:hover > a {
  background-color: #555;
  border-bottom: 1px solid #999;
}

/* 1차 메뉴의 항목이 마우스 인식 시에 2차 메뉴 등장 */
.side-bar > ul > li:hover > ul {
  display: block;
  position: absolute;
  background-color: #FFFAFA;
  top: 0;         /* 2차 메뉴의 상단을 1차 메뉴의 상단에 고정 */
  left: 100%;     /* 2차 메뉴를 1차 메뉴의 너비만큼 이동 */
  width: 100%;    /* 1차 메뉴의 너비를 상속 */
}

/* 사이드바 너비의 80%만큼 왼쪽으로 이동 */
.side-bar {
  border-radius: 20px;
  transform: translate(calc(var(--side-bar-width) * -0.8), 0);
  transition: .5s;
}

/* 마우스 인식 시 원래의 위치로 이동 */
.side-bar:hover {
  transform: translate(-20px, 0);   /* 둥근 모서리의 너비만큼 숨겨주기 */
}
/* 사이드바 끝 */

/* 커스텀 끝 */
/* )____________________________________ */

/* 기존 CSS 코드... */


/* 커스텀 끝 */
/* )____________________________________ */

/* styles.css */

body {
    margin: 0;
    font-family: Arial, sans-serif;
}

header {
    background-color: #333; /* 배경색 */
    padding: 10px;
    position: fixed;
    width: 100%;
    top: 0;
    left: 0;
    z-index: 1000; /* 다른 요소 위에 위치하도록 설정 */
    box-sizing: border-box; /* 패딩과 보더를 포함하여 전체 너비 설정 */
    display: flex; /* Flexbox 사용 */
    justify-content: space-between; /* 좌우 공간 분배 */
    align-items: center; /* 세로 중앙 정렬 */
}

.header-content {
    display: flex;
    justify-content: space-between; /* 좌우 공간 분배 */
    align-items: center; /* 세로 중앙 정렬 */
    width: 100%; /* 전체 너비 사용 */
}

.logo {
    color: white; /* 글씨 색상 */
    font-size: 24px; /* 글씨 크기 */
    font-weight: bold; /* 글씨 굵기 */
}

nav {
    max-width: 100%; /* 너비가 화면을 넘어가지 않도록 설정 */
}

nav ul {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
}

nav ul li {
    margin-left: 20px; /* 링크 간의 간격 */
}

nav ul li a {
    text-decoration: none; /* 링크의 밑줄 제거 */
    color: white; /* 글씨 색상 */
    font-size: 16px;
}

nav ul li a:hover {
    text-decoration: none; /* 마우스 오버 시 밑줄 추가 */
}

main {
    padding-top: 50px; /* 헤더가 내용 위에 덮이지 않도록 여백 추가 */
}


</style>

</head>
<body>
    <header>
        <div class="header-content">
            <div class="logo">Vroom__Admin</div>
            <nav>
                <ul>
                    <li><a href="#login">Login</a></li>
                    <li><a href="#aboutus">About Us</a></li>
                    <li><a href="#contactus">Contact Us</a></li>
                </ul>
            </nav>
        </div>
    </header>
<aside class="side-bar">
  <section class="side-bar__icon-box">
    <section class="side-bar__icon-1">
      <div></div>
      <div></div>
      <div></div>
    </section>
  </section>
  <ul>
  	<li>
      <a href="#">대시보드</a>
      <ul>
        <li><a href="#">text1</a></li>
        <li><a href="#">text2</a></li>
        <li><a href="#">text3</a></li>
        <li><a href="#">text4</a></li>
      </ul>
    </li>
    <li>
      <a href="#"><i class="fa-solid fa-cat"></i> 글관리</a>
      <ul>
        <li><a href="#">행사,식당목록</a></li>
        <li><a href="/event/register">행사등록</a></li>
        <li><a href="/restaurant/rest_register">식당등록</a></li>
      </ul>
    </li>
    <li>
      <a href="#">사용자 관리</a>
      <ul>
        <li><a href="#">ex)신고목록</a></li>
        <li><a href="#">ex)</a></li>
        <li><a href="#">text3</a></li>
        <li><a href="#">text4</a></li>
      </ul>
    </li>
    <li>
      <a href="#">통계</a>
      <ul>
        <li><a href="#">text1</a></li>
        <li><a href="#">text2</a></li>
        <li><a href="#">text3</a></li>
        <li><a href="#">text4</a></li>
      </ul>
    </li>
    <li>
      <a href="#">고객지원</a>
      <ul>
        <li><a href="#">text1</a></li>
        <li><a href="#">text2</a></li>
        <li><a href="#">text3</a></li>
        <li><a href="#">text4</a></li>
      </ul>
    </li>
    
  </ul>
</aside>

</body>
</html>