package com.teamproject.myteam01.mapper;

import java.util.List;


import com.teamproject.myteam01.domain.AttachFileDTO;

public interface AttachFileMapper {

	//록귀
	public List<AttachFileDTO> getAllFiles(String uno);
	
	//윤정
	public void insertAttachFile(AttachFileDTO attachFile);
	
	public AttachFileDTO findByUuid(String uuid);


	
}
