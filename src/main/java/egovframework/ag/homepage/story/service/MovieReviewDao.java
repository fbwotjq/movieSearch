package egovframework.ag.homepage.story.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

/**
 * 사용자리뷰 Dao
 * @author 박종호
 *
 */
@KMDBMapper
public interface MovieReviewDao {

	/**
	 * 사용자리뷰 목록 카운트 조회
	 * @return
	 * @throws Exception
	 */
	public int selectUserReviewListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사용자리뷰 목록 조회
	 * @param userReviewCount
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserReviewList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사용자리뷰 상세 조회
	 * @param userReviewCount
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserReviewInfo(Long seq) throws Exception;

	/**
	 * 사용자리뷰 읽은수 카운트 증가
	 * @param reviewSeq
	 * @return
	 * @throws Exception
	 */
	public int updateUserReviewReadCount(Long seq) throws Exception;

	/**
	 * 사용자리뷰 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertUserReviewInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화관련 사용자리뷰 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectRelMovieReviewListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화 관련 사용자리뷰 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieReviewVo> selectRelMovieReviewPageList(Map<String, Object> paramMap) throws Exception;

}
