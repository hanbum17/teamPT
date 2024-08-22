package com.teamproject.myteam01.fileupload;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.myteam01.domain.AttachFileDTO;

@Controller
public class FileUploadAjaxController {

	private String uploadFileRepoDir = "C:/yourupload";

	private String getDatePathName() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		return sdf.format(new Date());
	}

	private boolean isImageFile(File file) {
		String fileContentType = null;

		try {
			fileContentType = Files.probeContentType(file.toPath());
			System.out.println("fileContentType:" + fileContentType);
			return fileContentType.startsWith("image");
		} catch (IOException e) {
			System.out.println("오류:" + e.getMessage());
			return false;
		}
	}

	@PostMapping(value = "/doFileUploadByAjax", produces = { "application/json; charset=UTF-8" })
	@ResponseBody
	public List<AttachFileDTO> doFileUploadByAjax(MultipartFile[] uploadFiles) {

		List<AttachFileDTO> attachFileList = new ArrayList<>();
		AttachFileDTO attachFile;

		String dateDir = getDatePathName();

		File fileUploadPath = new File(uploadFileRepoDir, dateDir);
		System.out.println("폴더 생성 결과: " + fileUploadPath.mkdirs());

		for (MultipartFile uploadFile : uploadFiles) {
			System.out.println("업로드 파일이름: " + uploadFile.getOriginalFilename());
			System.out.println("업로드 파일크기: " + uploadFile.getSize());

			attachFile = new AttachFileDTO();
			attachFile.setUploadPath(dateDir);
			attachFile.setRepoPath(uploadFileRepoDir);

			String uploadFileName = uploadFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			attachFile.setFileName(uploadFileName);

			String uuid = UUID.randomUUID().toString();
			attachFile.setUuid(uuid);

			System.out.println("uuid:" + uuid);

			uploadFileName = uuid + "_" + uploadFileName;
			System.out.println("uploadFileName: " + uploadFileName);

			File saveUploadFile = new File(fileUploadPath, uploadFileName);

			try {
				uploadFile.transferTo(saveUploadFile);
				if(isImageFile(saveUploadFile)) {
	                attachFile.setFileType("I") ; //파일유형 저장
	            } else {
	            	attachFile.setFileType("F") ; //파일유형 저장
	            }

			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			attachFileList.add(attachFile);
		}
		return attachFileList;
	}

	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName, String fileType) {
		System.out.println("fileName: " + fileName);
		System.out.println("fileType: " + fileType);

		try {
			fileName = URLDecoder.decode(fileName, "utf-8");
			System.out.println("Decoded fileName: " + fileName); // 디코드된 파일 이름 로그 추가
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		File delFile = new File(fileName);
		boolean delResult = delFile.delete();

		System.out.println("Delete result: " + delResult); // 삭제 결과 로그 추가

		if (!delResult) {
			return new ResponseEntity<String>("F", HttpStatus.NOT_FOUND);
		}


		return delResult ? new ResponseEntity<String>("DelSuccess", HttpStatus.OK)
				: new ResponseEntity<String>("DelFail", HttpStatus.OK);
	}
}
