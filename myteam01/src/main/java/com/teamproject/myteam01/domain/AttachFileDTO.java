package com.teamproject.myteam01.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AttachFileDTO {
	
	private int fileDelFlag ;
	private Integer filedelflag;
	
	private String uuid;
	private String uploadPath;
	private String fileName ;
	private String fileType ;
	private String repoPath = "C:/myupload" ;
}
