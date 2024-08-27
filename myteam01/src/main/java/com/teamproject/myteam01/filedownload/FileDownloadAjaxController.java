package com.teamproject.myteam01.filedownload;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
            // 파일명 디코딩
            fileName = URLDecoder.decode(fileName, "UTF-8");
            File downloadFile = new File(fileName);

            // 파일 존재 여부 확인
            if (!downloadFile.exists() || downloadFile.isDirectory()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            // 원본 파일명 추출 및 인코딩 처리
            String originalFileName = downloadFile.getName();
            String downloadName = originalFileName.substring(originalFileName.indexOf("_") + 1);
            String encodedDownloadName = URLEncoder.encode(downloadName, "UTF-8").replaceAll("\\+", "%20");

            // 응답 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedDownloadName + "\"");
            headers.add("Content-Type", Files.probeContentType(downloadFile.toPath()));

            // 파일 자원 반환
            FileSystemResource fileResource = new FileSystemResource(downloadFile);
            return new ResponseEntity<>(fileResource, headers, HttpStatus.OK);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
