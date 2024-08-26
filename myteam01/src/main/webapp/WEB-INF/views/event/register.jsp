<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 등록 페이지</title>
</head>
<body>
	<h3>행사 등록</h3>
	<form role="form" action="${contextPath}/event/register" method="post" id="frmRegister">
	    <div class="form-group">
	        <label>행사 이름</label> <input class="form-control" name="ename">
	    </div>
	    
	    <div class="form-group">
	        <label>행사 기간</label> <input class="form-control" name="eperiod">
	    </div>
	    
	    <div class="form-group">
	        <label>행사 비용</label> <input class="form-control" name="ecost">
	    </div>
	    
	    <div class="form-group">
	        <label>행사 주소</label> <textarea class="form-control" name="eaddress"></textarea>
	    </div>
	    
	    <div class="form-group">
	        <label>행사 장소</label> <input class="form-control" name="eplace">
	    </div>
	    
	    <div class="form-group">
	        <label>행사 사이트</label> <textarea class="form-control" rows="3" name="esite"></textarea>
	    </div>
	    
	    <div class="form-group">
	        <label>행사 주최</label> <input class="form-control" name="ehost">
	    </div>
	    
	    <div class="form-group">
	        <label>행사 내용</label> <textarea class="form-control" rows="3" name="econtent"></textarea>
	    </div>
	    
	    <button type="submit" class="btn btn-primary">등록</button>
	    <button type="button" class="btn btn-warning" data-oper="list"
	             onclick="location.href='${contextPath}/event/list'">취소</button>
	</form>
    <form action="/user/login" method="get">
    	<div>
	        <button type="submit">돌아가기</button>
	    </div>
    </form>

</body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31f5a876a3944363b897938706793bd9"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
</html>