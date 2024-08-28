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
<ul>
	<c:forEach items="${chatList }" var="chatRoom">
		<li><a href="#">채팅방제목: ${chatRoom.title } 방번호(RoomId): ${chatRoom.roomId } 내닉네임: ${userId1 } 상대닉네임: ${userId2 }</a></li>	
	</c:forEach>
</ul>

</body>
</html>