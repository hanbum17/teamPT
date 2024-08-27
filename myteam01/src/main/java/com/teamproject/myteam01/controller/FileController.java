package com.teamproject.myteam01.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.core.io.Resource;
import org.springframework.core.io.FileSystemResource;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.service.AttachFileService;


@RestController
@RequestMapping("/files")
public class FileController {

    @Autowired
    private AttachFileService fileService;

    @GetMapping("/image/{uuid}")
    public ResponseEntity<Resource> getImage(@PathVariable String uuid) {
        AttachFileDTO file = fileService.getFile(uuid);

        if (file == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        File imageFile = new File(file.getRepoPath() + "/" + file.getUploadPath() + "/" + file.getUuid() + "_" + file.getFileName());
        if (!imageFile.exists()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        Resource resource = new FileSystemResource(imageFile);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG); // MIME 타입을 적절히 설정
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }
}

