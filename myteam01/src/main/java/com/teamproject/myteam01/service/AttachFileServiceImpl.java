package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.mapper.AttachFileMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AttachFileServiceImpl implements AttachFileService{
	
	private final AttachFileMapper attachFileMapper ;
	
	@Override
	public List<AttachFileDTO> getAllFiles(String uno) {
		
		return attachFileMapper.getAllFiles(uno);
	}

	
	@Override
	public AttachFileDTO getFile(String uuid) {
		return attachFileMapper.findByUuid(uuid);
	}
<<<<<<< HEAD
	
	
	
	
	
	
=======

>>>>>>> a428ef37d1514c8334ac0e3c6392b2ec71d68e4a
}
