package com.teamproject.myteam01.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.myteam01.domain.AttachFileDTO;
import com.teamproject.myteam01.domain.RestaurantVO;
import com.teamproject.myteam01.domain.RestaurantsReviewVO;
import com.teamproject.myteam01.mapper.AttachFileMapper;
import com.teamproject.myteam01.mapper.RestaurantMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class RestaurantServiceImpl implements RestaurantService{

	private final RestaurantMapper restaurantMapper ;
	private final AttachFileMapper restAttachFile;
	
	//록귀 파트
	@Override
	public RestaurantVO restaurantDetail(Long fno) {
		return restaurantMapper.restaurantDetail(fno);
	}
	
	@Override
	public List<RestaurantsReviewVO> selectReviews(Long fno) {
		return restaurantMapper.selectReviews(fno);
	}
	
	@Override
	public int registerReview(RestaurantsReviewVO restReviewVO) {
		return restaurantMapper.registerReview(restReviewVO);
	}
	
	@Override
	public int copyReview(Long frno) {
		return restaurantMapper.copyReview(frno);
	}

	@Override
	public int deleteReview(Long frno) {
		return restaurantMapper.deleteReview(frno);
	}

	
	//윤정 파트
	@Override
	public Long registerRest(RestaurantVO rest) {
		System.out.println("서비스에 전달된 레스토랑 값: "+rest);
		restaurantMapper.insertRestaurant(rest);
		System.out.println("서비스에 전달 후: "+rest);
		
		List<AttachFileDTO> attachFilelist = rest.getAttachFileList();
		if(attachFilelist!=null) {
			attachFilelist
	            .forEach(attachFile -> {restAttachFile.insertAttachFile(attachFile) ;
	                    }); //forEach-end
	        }

		return rest.getFno();
	}
	
}
