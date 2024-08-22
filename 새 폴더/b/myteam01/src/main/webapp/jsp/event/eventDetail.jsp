<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event Detail Page</title>
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
	<h3>ename: ${Event.ename }</h3>
	<p>eno: ${Event.eno }</p>
	<p>eperiod: ${Event.eperiod }</p>
	<p>ecost: ${Event.ecost }</p>
	<p>eaddress: ${Event.eaddress }</p>
	<p>eplace: ${Event.eplace }</p>
	<p>esite: ${Event.esite }</p>
	<p>ehost: ${Event.ehost }</p>
	<p>econtent: ${Event.econtent }</p>
	<p>eviewscnt: ${Event.eviewsCnt }</p>
	<p>excoord: ${Event.excoord }</p>
	<p>eycoord: ${Event.eycoord }</p>
	
	<div id="imgDiv">
		<ul>
			
		</ul>
	</div>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width:500px;height:350px;"></div>
<<<<<<< HEAD
	
	<!-- 첨부파일 div -->
	<div id="attachFiles">
		
	</div>
	
<script>
var uno = ${Event.uno } ;
var thumbnail ;
var resultHTML ;
	$.ajax({
		type: "GET",
		url: "/attachFile/getFiles",
		data: {uno: uno},
		success: function(fileList){
			console.log(fileList) ;
			thumbnail = fileList[0].repoPath + "/"+ fileList[0].uploadPath + "/" + fileList[0].uuid + fileList[0].fileName ;
			resultHTML += '<li>'
					   +  		'<img src="${contextPath}/attachFile/displayThumbnail?thumbnail=' + thumbnail + '" style="height:250px; width:300px;"><p>' + fileList[0].fileName + '</p>';
					   +  		'&emsp; '
					   +  '</li>' ;
			$("#attachFiles").append(resultHTML);		   
			
		}
	});
</script>	
	
	
	<!-- 리뷰 wrap Div -->
	<div id="reviews_wrap">
		<!-- 리뷰등록 form -->
=======
	<div id="reviews_wrap">
>>>>>>> CHYJ
		<form action="${contextPath }/event/registerReview" method="post">
			<input type="text" id="ertitle" name="ertitle" placeholder="제목"><br>
			<textarea id="ercontent" name="ercontent" placeholder="내용"></textarea><br>
			<input type="text" id="erwriter" name="erwriter" placeholder="작성자"><br>
			<input type="text" id="errating" name="errating" placeholder="별점 0~5"><br>
			<input type="text" id="eno" name="eno" value="${Event.eno }" readonly> <!-- 나중에 type="hidden" 으로 변경 -->
			<button id="review_register_btn">리뷰등록</button>
		</form>
<<<<<<< HEAD
		<!-- 리뷰 표시 div -->
		<div class="review_div">
			<c:forEach items="${Reviews }" var="review">
				<ul class="review_ul" data-erno="${review.erno }" data-uno="${review.uno }" data-eno="${review.eno }">
=======
		
		<c:forEach items="${Reviews }" var="review">
			<div class="review_div">
				<ul class="review_ul" data-frno="${review.erno }" data-uno="${review.uno }" data-fno="${review.fno }">
>>>>>>> CHYJ
					<li>erno: ${review.erno }</li>
					<li>ertitle: ${review.ertitle }</li>
					<li>ercontent: ${review.ercontent }</li>
					<li>erwriter: ${review.erwriter }</li>
					<li>erregDate: ${review.erregDate }</li>
					<li>errating: ${review.errating }</li>
					<li>uno: ${review.uno }</li>
					<li>eno: ${review.eno }</li>
				</ul>
				<button class="review_blind_btn">블라인드처리</button>
<<<<<<< HEAD
			</c:forEach>
		</div>
		<button id="review_Btn">리뷰더보기</button>
	</div>

<script>
var pageNum = ${PageNum} ;
var resultHTML = "";
$("#review_Btn").on("click", function(){
	var eno = ${Event.eno } ;
	pageNum = pageNum + 1 ; 	
	$.ajax({
		type: "GET",
		url: "/event/reviews/" + pageNum,
		data: {eno: eno},
		success: function(result){
			if(result.length != 0){
				for(var i in result){
					resultHTML 
					+= '<ul class="review_ul" data-erno="'+ result[i].erno +'" data-uno="'+ result[i].uno +'" data-eno="'+ result[i].eno +'">'
					+ '<li>erno: '+ result[i].erno +'</li>'
					+	 '<li>ertitle: '+ result[i].ertitle +'</li>'
					+	 '<li>ercontent: '+ result[i].ercontent +'</li>'
					+	 '<li>erwriter: '+ result[i].erwriter +'</li>'
					+	 '<li>erregDate: '+ result[i].erregDate +'</li>'
					+	 '<li>errating: '+ result[i].errating +'</li>'
					+	 '<li>uno: '+ result[i].uno +'</li>'
					+	 '<li>eno: '+ result[i].eno +'</li>'
					+ '</ul>' 
					+ '<button class="review_blind_btn">블라인드처리</button>' ;	
				}// for - end
				
				$(".review_div").append(resultHTML) ;
				
			}// if - end
			else if(!result.length){
				alert("리뷰가 더 없음.");
				$("#review_Btn").hide();
			}
		}//success - end
	}); //ajax-end
});
</script>
=======
			</div>
		</c:forEach>
	</div>


>>>>>>> CHYJ
<script>
var erno;
$(".review_div").on("click", ".review_blind_btn", function(){
    erno = $(this).siblings(".review_ul").data("erno");
    eno = ${Event.eno }
    $.ajax({
        type: "POST",
<<<<<<< HEAD
        url: "${contextPath}/event/deleteReview",  // 요청을 보낼 URL
        data: {erno: erno, eno: eno},  // 서버로 전송할 데이터
=======
        url: "/event/deleteReview",  // 요청을 보낼 URL
        data: { erno: erno, eno: eno},  // 서버로 전송할 데이터
>>>>>>> CHYJ
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
<<<<<<< HEAD
/* 
var overlay ;

var x = ${Event.excoord} ;
var y = ${Event.eycoord} ;

=======
/* var overlay ;

var x = ${Event.excoord} ;
var y = ${Event.eycoord} ;
>>>>>>> CHYJ
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
<<<<<<< HEAD
})// document ready end
*/

function loadMap(){
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	       center: new kakao.maps.LatLng(${Event.eycoord }, ${Event.excoord }), // 지도의 중심좌표
=======
})// document ready end */


function loadMap(result){
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	       center: new kakao.maps.LatLng(result.documents[0].y, result.documents[0].x), // 지도의 중심좌표
>>>>>>> CHYJ
	       level: 3 // 지도의 확대 레벨
	};
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
<<<<<<< HEAD
	var markerPosition  = new kakao.maps.LatLng(${Event.eycoord }, ${Event.excoord }); 
=======
	var markerPosition  = new kakao.maps.LatLng(result.documents[0].y, result.documents[0].x); 
>>>>>>> CHYJ
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	var content = '<div class="wrap">' + 
	   '    <div class="info">' + 
	   '        <div class="title">' + 
	   '            ${Event.ename} '+ 
	   '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	   '        </div>' + 
	   '        <div class="body">' + 
	   '            <div class="img">' +
	   '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
	   '           </div>' + 
	   '            <div class="desc">' + 
<<<<<<< HEAD
	   '                <div class="ellipsis">${Event.ecost }<br>${Event.eaddress }</div>' + 
=======
	   '                <div class="ellipsis">${Event.eaddress }</div>' + 
>>>>>>> CHYJ
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

<<<<<<< HEAD
loadMap();

=======
>>>>>>> CHYJ
// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}
	
</script>

</body>
</html>