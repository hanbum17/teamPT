/*
 * package com.teamproject.myteam01.service;
 * 
 * import net.nurigo.sdk.NurigoApp; import net.nurigo.sdk.message.model.Message;
 * import net.nurigo.sdk.message.service.DefaultMessageService; import
 * net.nurigo.sdk.message.request.SingleMessageSendingRequest; import
 * net.nurigo.sdk.message.response.SingleMessageSentResponse; import
 * org.springframework.stereotype.Service;
 * 
 * @Service public class SendMessageService { // private static final Logger
 * logger = LoggerFactory.getLogger(SendMessageService.class);
 * 
 * final DefaultMessageService messageService;
 * 
 * public SendMessageService(){ this.messageService =
 * NurigoApp.INSTANCE.initialize("NCS9DWF8BMQL0NQW",
 * "DPKMKGEFKOILIUZACSGH7GQKMSZRFIRV", "https://api.coolsms.co.kr"); } public
 * void sendMessage(){ Message message = new Message();
 * message.setFrom("01093826974"); // 01012345678 형태여야 함. message.setTo("010");
 * // 01012345678 형태여야 함. message.setText("보낼 메세지"); SingleMessageSentResponse
 * response = this.messageService.sendOne(new
 * SingleMessageSendingRequest(message)); System.out.println(response); } }
 */