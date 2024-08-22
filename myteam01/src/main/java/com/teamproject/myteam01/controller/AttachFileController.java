package com.teamproject.myteam01.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.service.AttachFileServiceImpl;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/attachFile")
public class AttachFileController {

	//_____________록귀의 첨부파일 컨트롤러________________________________________
	
	private final AttachFileServiceImpl fileService; // 파일 정보를 관리하는 서비스

//    @GetMapping("/getFiles")
//    public ResponseEntity<List<AttachFileDTO>> getFiles(String uno) {
//        List<AttachFileDTO> fileList = fileService.getAllFiles(uno); // DB에서 파일 정보 조회
//        return new ResponseEntity<>(fileList, HttpStatus.OK);
//    }
//	
//	@GetMapping("/displayThumbnail")
//	public ResponseEntity<byte[]> sendThumbnail(String thumbnail){
//		System.out.println(thumbnail);
//		File thumbnailFile = new File(thumbnail);
//		System.out.println("썸네일: " + thumbnailFile);
//		
//		//썸네일파일이 없으면 NOTFOUND 상태 리턴
//		if(!thumbnailFile.exists()) {
//			return new ResponseEntity<byte[]>(new byte[0], HttpStatus.NOT_FOUND);
//		} 
//		
//		ResponseEntity<byte[]> result = null ;
//		HttpHeaders httpHeaders = new HttpHeaders() ;
//		
//		try {
//			httpHeaders.add("Content-Type", Files.probeContentType(thumbnailFile.toPath()));
//			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(thumbnailFile), httpHeaders, HttpStatus.OK);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
	
}
