package com.teamproject.myteam01.service;

import java.util.List;
import java.util.Map;

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
	public String selectTitle(Long uno) {
		return restaurantMapper.selectTitle(uno);
	}
	
	@Override
	public RestaurantVO restaurantDetail(Long fno) {
		return restaurantMapper.restaurantDetail(fno);
	}
	
//삭제예정
//	@Override
//	public List<RestaurantsReviewVO> selectReviews(Long fno) {
//		return restaurantMapper.selectReviews(fno);
//	}
	//영범추가
	@Override
	public List<RestaurantsReviewVO> selectMoreReviews(RestaurantsReviewVO restReviewVO){
		Long offSet = (restReviewVO.getPage()- 1 ) * restReviewVO.getPageSize();
		restReviewVO.setOffset(offSet);
		List<RestaurantsReviewVO> reviews = restaurantMapper.selectMoreReviews(restReviewVO);
		List<Long> forStars = restaurantMapper.selectReviewsForStar(restReviewVO.getFno());
		
		Double frRating = 0.0;
		Long count = 0L;
		if (forStars != null && !forStars.isEmpty()) {
			for (Long forStar : forStars) {
	            frRating += forStar;
	            count++;
	        }
			Double ratingAverage = frRating / count;
	        Double finalRatingAverage = Math.round(ratingAverage * 10) / 10.0;
	        
	     // 모든 리뷰 객체에 평균 평점과 리뷰 개수를 설정하기
	        for (RestaurantsReviewVO review : reviews) {
	            review.setRatingAverage(finalRatingAverage);
	            review.setFrCount(count);
	        }
			
		}
		return reviews;
		
	}
	
	
	@Override
	public List<RestaurantsReviewVO> selectReviews(Long fno) {
	    List<RestaurantsReviewVO> reviews = restaurantMapper.selectReviews(fno);
	    Double frRating = 0.0;
	    Long count = 0L;

	    if (reviews != null && !reviews.isEmpty()) {
	        for (RestaurantsReviewVO review : reviews) {
	            frRating += review.getFrrating();
	            count++;
	        }
	        Double ratingAverage = frRating / count;
	        Double finalRatingAverage = Math.round(ratingAverage * 10) / 10.0;

	        // 모든 리뷰 객체에 평균 평점과 리뷰 개수를 설정하기
	        for (RestaurantsReviewVO review : reviews) {
	            review.setRatingAverage(finalRatingAverage);
	            review.setFrCount(count);
	        }

	        return reviews;
	    }

	    return reviews; // 빈 리스트를 반환
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
	   public Long registerRest(RestaurantVO rest, AttachFileDTO attach) {
	      System.out.println("서비스에 전달된 레스토랑 값: "+rest);
	      
	      
	      restaurantMapper.insertRestaurant(rest);
	      System.out.println("서비스에 전달 후: "+rest);
	      
	      List<AttachFileDTO> attachFilelist = rest.getAttachFileList();
	      if(attachFilelist!=null) {
	         attachFilelist
	               .forEach(attachFile -> {
	            	   attachFile.setUno(rest.getUno());
	            	   System.out.println("첨부파일 데이터: "+ attachFile);
	            	   restAttachFile.insertAttachFile(attachFile) ;
	                       }); //forEach-end
	           }

	      return rest.getFno();
	   }
	
		/* 행사조회 ServiceImple , page번호와 pageSize표시할 개수를 매개변수로 받아
		 * VO에 세팅해준다. 이후 해당 값을 매퍼로 넘겨서 리스트를 10개씩 가져온다. */
		/*
		 * @Override public List<RestaurantVO> getRestList(Long page, Long pageSize){
		 * RestaurantVO restVO = new RestaurantVO(); Long offSet = (page- 1 ) *
		 * pageSize;
		 * 
		 * restVO.setPage(page); restVO.setPageSize(pageSize); restVO.setOffset(offSet);
		 * 
		 * List<RestaurantVO> restList = restaurantMapper.selectRestList(restVO);
		 * System.out.println("테스트3"); return restList; }
		 */
	
		@Override
		public List<RestaurantVO> getRestList(Long page, Long pageSize){
			RestaurantVO restVO = new RestaurantVO();
			Long offSet = (page- 1 ) * pageSize;
			
			restVO.setPage(page);
			restVO.setPageSize(pageSize);
			restVO.setOffset(offSet);
			
			List<RestaurantVO> restList = restaurantMapper.selectRestList(restVO);
			
			for (RestaurantVO restaurant : restList) {
	            List<AttachFileDTO> attachFileList = restAttachFile.getAttachFilesByUno(restaurant.getUno());
	            restaurant.setAttachFileList(attachFileList); // 이미지 리스트를 restaurant에 추가
	        }

			System.out.println("테스트3");
			return restList;
		}
		
		
		@Override
		public List<RestaurantsReviewVO> modifyreview(RestaurantsReviewVO restReviewVO) {
			System.out.println("리뷰 수정 서비스 값: "+restReviewVO);
			restaurantMapper.updaterestreview(restReviewVO);
			return null;
		}
		
		@Override
		public List<RestaurantVO> getRestListByGuName(Map<String, Object> params) {
		    Long offset = (Long) params.get("offset");
		    Long pageSize = (Long) params.get("pageSize");
		    String guName = (String) params.get("guName");
		    System.out.println("서비스에 전달된 구: "+guName);
		    

		    // Mapper 호출
		    return restaurantMapper.selectRestListByGuName(guName, offset, pageSize);
		}

		

	
	
}
