<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Detail Page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
</head>
<body>
	<%-- ${Restaurant} --%>
	<h3>fname: ${Restaurant.fname }</h3>
	<p>fno: ${Restaurant.fno }</p>
	<p>fcategory: ${Restaurant.fcategory }</p>
	<p>faddress: ${Restaurant.faddress }</p>
	<p>fviewscnt: ${Restaurant.fviewscnt }</p>
	<p>frating: ${Restaurant.frating }</p>
	<div id="imgDiv">
		<ul>
			
		</ul>
	</div>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width:500px;height:350px;"></div>
	<div id="reviews_wrap">
		<form action="${contextPath }/restaurant/registerReview" method="post">
			<input type="text" id="frtitle" name="frtitle" placeholder="제목"><br>
			<textarea id="frcontent" name="frcontent" placeholder="내용"></textarea><br>
			<input type="text" id="frwriter" name="frwriter" placeholder="작성자"><br>
			<input type="text" id="frrating" name="frrating" placeholder="별점 0~5"><br>
			<input type="text" id="fno" name="fno" value="${Restaurant.fno }" readonly> <!-- 나중에 type="hidden" 으로 변경 -->
			<button id="review_register_btn">리뷰등록</button>
		</form>
		
		<c:forEach items="${Reviews }" var="review">
			<div class="review_div">
				<ul class="review_ul" data-frno="${review.frno }" data-uno="${review.uno }" data-fno="${review.fno }">
					<li>frno: ${review.frno }</li>
					<li>frtitle: ${review.frtitle }</li>
					<li>frcontent: ${review.frcontent }</li>
					<li>frwriter: ${review.frwriter }</li>
					<li>frregDate: ${review.frregDate }</li>
					<li>frrating: ${review.frrating }</li>
					<li>uno: ${review.uno }</li>
					<li>fno: ${review.fno }</li>
				</ul>
				<button class="review_blind_btn">블라인드처리</button>
			</div>
		</c:forEach>
	</div>


<script>
var frno;
$(".review_div").on("click", ".review_blind_btn", function(){
    frno = $(this).siblings(".review_ul").data("frno");
    fno = ${Restaurant.fno }
    $.ajax({
        type: "POST",
        url: "/restaurant/deleteReview",  // 요청을 보낼 URL
        data: { frno: frno, fno: fno},  // 서버로 전송할 데이터
        success: function(response) {
            // 요청이 성공적으로 완료되었을 때 실행할 코드
            alert("리뷰가 성공적으로 삭제 처리되었습니다.");
            location.reload(true);
        },
        error: function(error) {
            // 요청이 실패했을 때 실행할 코드
            alert("리뷰 삭제 처리 중 오류가 발생했습니다.");
        }
    });
});
</script>
<!-- 이미지 썸네일 표시 스크립트 -->
<script>
	function displayThumbnail(uploadResult){
	
	var fileUploadResultUL = $("#imgDiv ul") ;
	var resultHTML = "";
	
	if(uploadResult == null || uploadResult.length == 0){
		return ;
	}
	
	$(uploadResult).each(function(i, attachFile){
		if(attachFile.fileType == "F"){
			resultHTML += '<li>'
			 		   +  		'<img alt=""> <p>' + attachFile.fileName + '</p>';
					   +  		'&emsp; '
					   +  '</li>' ;
		}else{
			var thumbnail = encodeURI(attachFile.repoPath + "/"
									  + attachFile.uploadPath + "/s_"
									  + attachFile.uuid + "_"
									  + attachFile.fileName );
			resultHTML += '<li>'
					   +  		'<img src="${contextPath}/attachFile/displayThumbnail?thumbnail=' + thumbnail + '"><p>' + attachFile.fileName + '</p>';
					   +  		'&emsp; '
					   +  '</li>' ;
		}
	});
	fileUploadResultUL.html(resultHTML);
}
</script>


<!-- 카카오api 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a"></script>
<script>
var overlay ;

var x = ${Restaurant.fxcoord} ;
var y = ${Restaurant.fycoord} ;
var input_coord = "TM" ;
var output_coord = "WGS84" ;
var data = {x: x, y: y, input_coord: input_coord, output_coord: output_coord} ;

$(document).ready(function(){
	$.ajax({
		type: "get",
		url: "https://dapi.kakao.com/v2/local/geo/transcoord.json",
		data: data,
		beforeSend: function (xhr) {
	        xhr.setRequestHeader("Authorization","KakaoAK 6b861044f2ac4d9e31f7e31184ac5a2b");
	    },
		success: function(result){
			//console.log(result);
			loadMap(result) ;
		}//success end
	}); // ajax end
})// document ready end


function loadMap(result){
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	       center: new kakao.maps.LatLng(result.documents[0].y, result.documents[0].x), // 지도의 중심좌표
	       level: 3 // 지도의 확대 레벨
	};
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var markerPosition  = new kakao.maps.LatLng(result.documents[0].y, result.documents[0].x); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	var content = '<div class="wrap">' + 
	   '    <div class="info">' + 
	   '        <div class="title">' + 
	   '            ${Restaurant.fname} '+ 
	   '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	   '        </div>' + 
	   '        <div class="body">' + 
	   '            <div class="img">' +
	   '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
	   '           </div>' + 
	   '            <div class="desc">' + 
	   '                <div class="ellipsis">${Restaurant.faddress }</div>' + 
	   '            </div>' + 
	   '        </div>' + 
	   '    </div>' +    
	   '</div>';
	
	// 마커 위에 커스텀오버레이를 표시합니다
	// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
	 	overlay = new kakao.maps.CustomOverlay({
	    content: content,
	    map: map,
	    position: marker.getPosition()       
	});
	
	// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
	kakao.maps.event.addListener(marker, 'click', function() {
	    overlay.setMap(map);
	});
	
} //loadMap() end

// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}
	
</script>

</body>
</html>