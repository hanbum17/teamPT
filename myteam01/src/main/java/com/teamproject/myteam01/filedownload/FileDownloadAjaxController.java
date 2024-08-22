package com.teamproject.myteam01.filedownload;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileDownloadAjaxController {

    @GetMapping(value = "/doFileDownloadByAjax")
    public ResponseEntity<Resource> doFileDownloadByAjax(@RequestParam("fileName") String fileName) {
        try {
            fileName = URLDecoder.decode(fileName, "UTF-8"); // 클라이언트에서 URL 인코딩된 파일 경로를 디코딩합니다.
            File downloadFile = new File(fileName);

            if (!downloadFile.exists()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            String originalFileName = downloadFile.getName(); // 파일의 원본 이름을 가져옵니다.

            // 다운로드할 파일명에서 UUID 제거
            String downloadName = originalFileName.substring(originalFileName.indexOf("_") + 1);

            // ISO-8859-1 형식으로 인코딩하여 한글 파일명이 깨지지 않도록 처리합니다.
            String encodedDownloadName = new String(downloadName.getBytes("UTF-8"), "ISO-8859-1");

            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedDownloadName + "\"");

            FileSystemResource fileResource = new FileSystemResource(downloadFile);
            return new ResponseEntity<>(fileResource, headers, HttpStatus.OK);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
