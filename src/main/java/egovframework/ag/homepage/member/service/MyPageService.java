package egovframework.ag.homepage.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.ag.common.vo.PageListVo;

@Service
public class MyPageService {

	@Autowired
	private MyPageDao myPageDao;

	/**
	 * 나의 구매 vod 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String,Object>> selectVodList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<Map<String, Object>>(myPageDao.selectVodListCount(paramMap), myPageDao.selectVodPageList(paramMap));
	}

	/**
	 * 나의 구매 도서 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String,Object>> selectBookList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<Map<String, Object>>(myPageDao.selectBookListCount(paramMap), myPageDao.selectBookPageList(paramMap));
	}

	/**
	 * 나의 이용권 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String,Object>> selectCouponList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<Map<String, Object>>(myPageDao.selectCouponListCount(paramMap), myPageDao.selectCouponPageList(paramMap));
	}

	/**
	 * 나의 영화글 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageListVo selectTextList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo(myPageDao.selectTextListCount(paramMap), myPageDao.selectTextPageList(paramMap));
	}

	/**
	 * 나의 영화글 상세
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTextInfo(long seq) throws Exception {
		return myPageDao.selectTextInfo(seq);
	}

	/**
	 * 1:1 문의내역 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageListVo selectAskList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo(myPageDao.selectAskListCount(paramMap), myPageDao.selectAskPageList(paramMap));
	}

	/**
	 * 1:1 문의내역 상세
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAskInfo(long seq) throws Exception {
		return myPageDao.selectAskInfo(seq);
	}

	/**
	 * 나의 영화 카테고리별 카운트 목록
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMovieCountList(Map<String, Object> paramMap) throws Exception {

		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("gubun", "1");
		hm.put("userId", paramMap.get("userId"));
		hm.put("stype", "M");
		int resultCnt = myPageDao.selectMovieCategoryCount(hm);
		if(resultCnt == 0){
			hm.put("sname", "내가 본 영화");
			myPageDao.insertCategory(hm);
		}

		hm.put("gubun", "2");
		resultCnt = myPageDao.selectMovieCategoryCount(hm);
		if(resultCnt == 0){
			hm.put("sname", "보고싶은 영화");
			myPageDao.insertCategory(hm);
		}

		hm.put("category", myPageDao.selectMovieCategoryCountList(paramMap));
		hm.put("year", myPageDao.selectMovieYearCountList(paramMap));
		hm.put("month", myPageDao.selectMovieMonthCountList(paramMap));

		return hm;
	}

	/**
	 * 나의 영화내역 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageListVo selectMovieList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo(myPageDao.selectMovieListCount(paramMap), myPageDao.selectMoviePageList(paramMap));
	}
	/**
	 * 나의 영화내역 삭제
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int removeMovieList(Map<String, Object> paramMap) throws Exception {
		return myPageDao.removeMovieList(paramMap);
	}

	/**
	 * 나의 영화내역 체크
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int selectCategoryCheck(Map<String, Object> paramMap) throws Exception {
		return myPageDao.selectCategoryCheck(paramMap);
	}

	/**
	 * 나의 영화카테고리 등록
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void insertCategoryList(Map<String, Object> paramMap, List<String> paramList ) throws Exception {
		paramMap.put("gubun", "3");
		paramMap.put("stype", "M");
		for(String sname: paramList){
			paramMap.put("sname", sname);
			myPageDao.insertCategory(paramMap);
		}
	}

	/**
	 * 나의 영화카테고리 수정
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void updateCategory(Map<String, Object> paramMap) throws Exception {

		myPageDao.updateCategory(paramMap);
	}

	/**
	 * 나의 영화카테고리 삭제
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void removeCategory(Map<String, Object> paramMap) throws Exception {

		myPageDao.removeCategory(paramMap);
	}

	/**
	 * 나의영화 관람일 등록
	 * @return
	 * @throws Exception
	 */
	public int updateSeeDate(Map<String, Object> paramMap) throws Exception{
		return myPageDao.updateSeeDate(paramMap);
	}
}
