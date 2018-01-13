package egovframework.ag.homepage.story.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KFMapper;

@KFMapper
public interface MovieWebzineDao {


	/**
	 * 웹진 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectMovieWebzineListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 웹진 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<WebzineCoverVo> selectMovieWebzinePageList(Map<String, Object> paramMap) throws Exception;


	/**
	 * 웹진 커버 정보 조회
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public WebzineCoverVo selectMovieWebzineCoverInfo(Long seq) throws Exception;

	/**
	 * 웹진 컨텐츠 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieWebzineContentList(Long upcate) throws Exception;


	/**
	 * 웹진 컨텐츠 상세 조회
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public WebzineContentVo selectMovieWebzineContentInfo(Long seq) throws Exception;

	/**
	 * 웹진 키워드 검색 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectMovieWebzineKeywordSearchListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 웹진 키워드 검색 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<WebzineContentVo> selectMovieWebzineKeywordSearchPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 필자별 웹진글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectWriterWebzineCountList(Map<String, Object> paramMap) throws Exception;


	/**
	 * 필자별 웹진목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectWriterWebzineListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 필자별 웹진목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<WebzineContentVo> selectWriterWebzinePageList(Map<String, Object> paramMap) throws Exception;
}
