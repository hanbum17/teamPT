<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <title>Chat List</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
</head>
<body>
	<c:forEach items="${chatList }" var="chatRoom">
		<a href="${chatRoom.roomId }">채팅방제목: ${chatRoom.title } &nbsp&nbsp&nbsp 방번호(RoomId): ${chatRoom.roomId } &nbsp&nbsp&nbsp 내닉네임: ${userId1 } 상대닉네임: ${userId2 }</a><br>	
	</c:forEach>
<script>
	$('a').on("click", function(e){
		e.preventDefault();
		alert($(this).attr('href'));		
	});
</script>
</body>
</html>