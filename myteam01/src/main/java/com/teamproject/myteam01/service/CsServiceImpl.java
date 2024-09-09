package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.CsVO;
import com.teamproject.myteam01.mapper.CsMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class CsServiceImpl implements CsService{

	private final CsMapper csMapper ;
	


	//희준
	//FAQ 목록
	@Override
	public List<CsVO> csList(){
		return csMapper.selectFAQList();
	}
	
	//FAQ 등록
	@Override
	public Long regiFAQ(CsVO faq) {
		csMapper.registerFAQ(faq);
		return faq.getFaqno();
	}
	
	//FAQ 조회
	@Override
	public CsVO getFAQ(Long faqno) {
		CsVO faq = csMapper.selectFAQ(faqno);
		return faq ;
	}
	
	
	//FAQ 수정
	@Override
	public boolean modifyFAQ(CsVO faq) {
		System.out.println("서비스 : FAQ 수정");
		return csMapper.updateFAQ(faq) == 1;
	}
	
	//FAQ 삭제
	@Override
	public boolean removeFAQ(Long faqno) {
		System.out.println("서비스 : FAQ 삭제");
		return csMapper.delFAQ(faqno) == 1;
		
	}
	
}
