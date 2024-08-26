<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<title>Test</title>
	<meta charset="UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<script>
//6b861044f2ac4d9e31f7e31184ac5a2b
var x = 206067.040577222 ;
var y = 404408.638877875 ;
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
			console.log(result);
		}
	});
})
</script>
</body>
</html>
