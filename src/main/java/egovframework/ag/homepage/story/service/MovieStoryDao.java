package egovframework.ag.homepage.story.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

/**
 * 영화글 Dao
 * @author tipgi
 *
 */
@KMDBMapper
public interface MovieStoryDao {

	/**
	 * 영화글 메인 대표글 정보 조회
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMovieStroyHeadInfo() throws Exception;

	/**
	 * 영화글 메인 영화글 목록 조회
	 * @param movieStoryCount
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMainMovieStoryList(Integer mainMovieStoryCount) throws Exception;

	/**
	 * 영화글 조회 대상 구분정보 조회
	 * @param storyDivSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSearchTargetStoryDivSeqInfo(Long storyDivSeq) throws Exception;

	/**
	 * 영화글 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectMovieStoryListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화글 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectMovieStoryPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화글 목록 조회 - (top 건수 별 조회)
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectTopCountMovieStoryList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 종료연재 영화글 구분 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEndStoryDivList() throws Exception;

	/**
	 * 영화글 읽은수 카운트 증가
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public int updateMovieStoryReadCount(Long storySeq) throws Exception;

	/**
	 * 영화글 상세정보 조회
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public MovieStoryVo selectMovieStoryInfo(Long storySeq) throws Exception;

	/**
	 * 영화글 필자의 이전 영화글 조회
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public Long selectWriterPreMovieStorySeq(MovieStoryVo movieStoryVo) throws Exception;

	/**
	 * 영화글 추천 영화글 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectChoiceMovieStoryList() throws Exception;

	/**
	 * 영화글 연관 영화 목록 조회
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryRelMovieVo> selectMovieStoryRelMovieList(Long storySeq) throws Exception;

	/**
	 * 영화의 관련 영화글 목록 조회
	 * @param movieStoryRelMovieVo
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectMovieRelMovieStoryList(MovieStoryRelMovieVo movieStoryRelMovieVo) throws Exception;

	/**
	 * 영화글 연관 영화인 목록 조회
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryRelPersonVo> selectMovieStoryRelPersonList(Long storySeq) throws Exception;

	/**
	 * 영화인의 관련 영화글 목록 조회
	 * @param movieStoryRelMovieVo
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectPersonRelMovieStoryList(MovieStoryRelPersonVo movieStoryRelPersonVo) throws Exception;

	/**
	 * 필자별 영화글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectWriterMovieStoryCountList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 필자 정보 조회
	 * @param writerSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectWriterInfo(Long writerSeq) throws Exception;

	/**
	 * 관련영화인 영화글 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectRelPersonMovieStoryListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 관련 영화인 영화글 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectRelPersonMovieStoryPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화관련 영화글 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectRelMovieStoryListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화 관련 영화글 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectRelMovieStoryPageList(Map<String, Object> paramMap) throws Exception;
}
