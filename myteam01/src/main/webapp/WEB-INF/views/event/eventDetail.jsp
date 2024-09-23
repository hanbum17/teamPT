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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	<button id="addFavoriteBtn" class="add-fav-btn">즐겨찾기 추가</button>
	<div id="imgDiv">
		<ul>
			
		</ul>
	</div>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width:500px;height:350px;"></div>
	
	<!-- 첨부파일 div -->
	<div id="attachFiles">
		
	</div>
	
<script>
var uno = ${Event.uno} ;
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
		<form action="${contextPath }/event/registerReview" method="post">
			<input type="text" id="ertitle" name="ertitle" placeholder="제목"><br>
			<textarea id="ercontent" name="ercontent" placeholder="내용"></textarea><br>
			<input type="text" id="erwriter" name="erwriter" placeholder="작성자"><br>
			<input type="text" id="errating" name="errating" placeholder="별점 0~5"><br>
			<input type="text" id="eno" name="eno" value="${Event.eno }" readonly> <!-- 나중에 type="hidden" 으로 변경 -->
			<button id="review_register_btn">리뷰등록</button>
		</form>
		<!-- 리뷰 표시 div -->
		<div class="review_div">
			<c:forEach items="${Reviews }" var="review">
				<ul class="review_ul" data-erno="${review.erno }" data-uno="${review.uno }" data-eno="${review.eno }">
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
<script>
var erno;
$(".review_div").on("click", ".review_blind_btn", function(){
    erno = $(this).siblings(".review_ul").data("erno");
    eno = ${Event.eno }
    $.ajax({
        type: "POST",
        url: "${contextPath}/event/deleteReview",  // 요청을 보낼 URL
        data: {erno: erno, eno: eno},  // 서버로 전송할 데이터
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
/* 
var overlay ;

var x = ${Event.excoord} ;
var y = ${Event.eycoord} ;

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
*/

function loadMap(){
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	       center: new kakao.maps.LatLng(${Event.eycoord }, ${Event.excoord }), // 지도의 중심좌표
	       level: 3 // 지도의 확대 레벨
	};
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var markerPosition  = new kakao.maps.LatLng(${Event.eycoord }, ${Event.excoord }); 
	
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
	   '                <div class="ellipsis">${Event.ecost }<br>${Event.eaddress }</div>' + 
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

loadMap();

// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}
	
//-------즐찾
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>


	document.addEventListener('DOMContentLoaded', function() {
	    const addFavoriteBtn = document.getElementById('addFavoriteBtn');

	    if (addFavoriteBtn) {
	        addFavoriteBtn.onclick = function() {
	            $.ajax({
	                url: '/user/getFavoriteLists',  // 즐겨찾기 목록을 가져오는 API 엔드포인트
	                method: 'GET',
	                success: function(favoriteLists) {
	                    let optionsHtml = '';

	                    if (favoriteLists.length === 0) {
	                        optionsHtml = "<option value=''>목록이 없습니다. 새로 추가해주세요.</option>";
	                    } else {
	                        favoriteLists.forEach(list => {
	                            // 문자열 연결 방식을 사용하여 <option> 태그를 생성
	                            optionsHtml += "<option value=" + list.listId + ">" + list.listName + "</option>";
	                        });
	                    }

	                    Swal.fire({
	                        title: '즐겨찾기 목록 선택',
	                        html: 
	                            "<label>즐겨찾기 목록 : </label>" +
	                            "<select id='favoriteListSelect' class='swal2-input'>" +
	                            optionsHtml +
	                            "</select>" +
	                            "<button type='button' id='addNewListBtn' class='swal2-confirm swal2-styled' style='margin-top: 10px;'>새 목록 추가</button>",
	                        showCancelButton: true,
	                        confirmButtonText: '저장',
	                        cancelButtonText: '취소',
	                        preConfirm: () => {
	                            const listId = Swal.getPopup().querySelector('#favoriteListSelect').value;
	                            const pageUrl = window.location.href; // 현재 페이지 URL을 즐겨찾기 링크로 사용
	                            const eno = urlParams.get('eno');
	                            const fno = urlParams.get('fno');
	                            const date = new Date().toISOString().slice(0, 10);

	                            if (!listId) {
	                                Swal.showValidationMessage('목록을 선택해주세요.');
	                            }

	                            return { listId, pageUrl, eno, fno, date };
	                        }
	                    }).then((result) => {
	                        if (result.isConfirmed) {
	                            const { listId, pageUrl, eno, fno, date } = result.value;
	                            const form = document.createElement('form');
	                            form.method = 'POST';
	                            form.action = '/user/addFavoriteItem';

	                            form.appendChild(createHiddenInput('listId', listId));
	                            form.appendChild(createHiddenInput('link', pageUrl));
	                            form.appendChild(createHiddenInput('eno', eno || ''));
	                            form.appendChild(createHiddenInput('fno', fno || ''));
	                            form.appendChild(createHiddenInput('createdDate', date));

	                            document.body.appendChild(form);
	                            form.submit();
	                        }
	                    });


	                    $(document).on('click', '#addNewListBtn', function() {
	                    	Swal.fire({
	                    	    title: '새 즐겨찾기 목록 추가',
	                    	    html: 
	                    	        '<input type="text" id="newListName" class="swal2-input" placeholder="목록 이름" required>' +
	                    	        '<div style="display: flex; flex-direction: column; align-items: center;">' +
	                    	        '<label for="listColor" style="margin-top: 10px;">목록 색상:</label>' +
	                    	        '<input type="color" id="listColor" class="swal2-input" style="width: 280px; margin-top: 5px;" value="#007bff">' +
	                    	        '</div>',
	                    	    confirmButtonText: '추가',
	                    	    showCancelButton: true,
	                    	    preConfirm: () => {
	                    	        const newListName = Swal.getPopup().querySelector('#newListName').value;
	                    	        const listColor = Swal.getPopup().querySelector('#listColor').value;

	                    	        if (!newListName || !listColor) {
	                    	            Swal.showValidationMessage('목록 이름과 색상을 입력해주세요.');
	                    	        }

	                    	        return { newListName, listColor };
	                    	    }
	                    	}).then((result) => {
	                            if (result.isConfirmed) {
	                                const { newListName, listColor } = result.value;

	                                $.ajax({
	                                    url: '/user/addFavoriteList',
	                                    method: 'POST',
	                                    data: {
	                                        listName: newListName,
	                                        listColor: listColor
	                                    },
	                                    success: function(response) {
	                                        const newOption = "<option value=" + response.listId + ">" + response.listName + "</option>";
	                                        $('#favoriteListSelect').append(newOption).val(response.listId);
	                                    },
	                                    error: function(error) {
	                                        Swal.fire('오류', '새 목록 추가 중 문제가 발생했습니다.', 'error');
	                                    }
	                                });
	                            }
	                        });
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error('Error fetching favorite lists:', xhr.responseText);
	                    Swal.fire('오류', '즐겨찾기 목록을 불러오는 중 오류가 발생했습니다.', 'error');
	                }
	            });
	        };
	    }
	});

	const urlParams = new URLSearchParams(window.location.search);

	function createHiddenInput(name, value) {
	    const input = document.createElement('input');
	    input.type = 'hidden';
	    input.name = name;
	    input.value = value;
	    return input;
	}



</script>

</body>
</html>