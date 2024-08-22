//package com.teamproject.myteam01.websocket;
//
//import org.springframework.http.HttpHeaders;
//import org.springframework.stereotype.Component;
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import java.net.InetSocketAddress;
//import java.util.Map;
//
//@Component
//public class WebSocketHandler extends TextWebSocketHandler {
//
//    @Override
//    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        String remoteAddress = getClientIpAddress(session);
//        System.out.println("Client IP Address: " + remoteAddress);
//    }
//
//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        // Handle disconnection logic here
//    }
//
//    private String getClientIpAddress(WebSocketSession session) {
//        // 먼저 X-Forwarded-For 헤더에서 IP 주소를 시도
//        Map<String, Object> attributes = session.getAttributes();
//        HttpHeaders headers = (HttpHeaders) attributes.get("org.springframework.http.server.ServerHttpRequest.headers");
//        String ipAddress = null;
//        
//        if (headers != null && headers.containsKey("X-Forwarded-For")) {
//            ipAddress = headers.getFirst("X-Forwarded-For");
//        }
//        
//        if (ipAddress == null) {
//            InetSocketAddress remoteAddress = session.getRemoteAddress();
//            if (remoteAddress != null) {
//                ipAddress = remoteAddress.getAddress().getHostAddress();
//            } else {
//                ipAddress = "UNKNOWN";
//            }
//        }
//        
//        return ipAddress;
//    }
//}
