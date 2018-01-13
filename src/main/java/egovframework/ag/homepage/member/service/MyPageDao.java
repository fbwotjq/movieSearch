package egovframework.ag.homepage.member.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface MyPageDao {

	/**
	 * 나의 구매 vod 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectVodListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 구매 vod 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectVodPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 구매 도서 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectBookListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 구매 도서 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBookPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 구매 이용권 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectCouponListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 구매 이용권 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCouponPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 영화글 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectTextListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 영화글 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTextPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의 영화글  상세
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTextInfo(long seq) throws Exception;

	/**
	 * 1:1내역 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectAskListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 1:1내역 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectAskPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 1:1내역  상세
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAskInfo(long seq) throws Exception;

	/**
	 * 나의영화 카테고리 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectMovieCategoryCount(Map<String, Object> paramMap) throws Exception;


	/**
	 * 나의영화 카테고리 등록
	 * @return
	 * @throws Exception
	 */
	public int insertCategory(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의영화 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieCategoryCountList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의영화 목록 년도 리스트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieYearCountList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의영화 목록 월 리스트
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieMonthCountList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의영화 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectMovieListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의영화 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMoviePageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 나의영화 삭제
	 * @return
	 * @throws Exception
	 */
	public int removeMovieList(Map<String, Object> paramMap) throws Exception ;

	/**
	 * 나의영화 체크
	 * @return
	 * @throws Exception
	 */
	public int selectCategoryCheck(Map<String, Object> paramMap) throws Exception ;

	/**
	 * 카테고리 삭제
	 * @return
	 * @throws Exception
	 */
	public int removeCategory(Map<String, Object> paramMap) throws Exception ;

	/**
	 * 나의 영화카테고리 수정
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void updateCategory(Map<String, Object> paramMap) throws Exception ;

	/**
	 * 나의영화 관람일 등록
	 * @return
	 * @throws Exception
	 */
	public int updateSeeDate(Map<String, Object> paramMap) throws Exception;
}
