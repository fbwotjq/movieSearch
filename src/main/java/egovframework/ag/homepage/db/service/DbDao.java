package egovframework.ag.homepage.db.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface DbDao {

	public int selectFestivalListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalPageList(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectFestivalInfo(Map<String, Object> paramMap) throws Exception;

	public int selectFestivalPosterPageListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalPosterPageList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalAwardList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalAwardYearList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalOwnImgList(Map<String, Object> paramMap) throws Exception;

	public int selectKeywordListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectKeywordPageList(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectKeywordPreNext(long idx) throws Exception;

	public int selectKeywordSubListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectKeywordSubPageList(Map<String, Object> paramMap) throws Exception;

	public int selectMovieListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectMoviePageList(Map<String, Object> paramMap) throws Exception;

	public int selectKeywordCount(Map<String, String> paramMap) throws Exception;

	public int insertKeywordProc(Map<String, String> paramMap) throws Exception;

	public List<Map<String, Object>> selectDbList() throws Exception;

	public List<Map<String, Object>> selectUserDbViewList(Map<String, Object> paramMap) throws Exception;

	public int selectDbListCount(Map<String, Object> paramMap) throws Exception;

	public int selectUserDbViewCount(Map<String, Object> paramMap) throws Exception;

	public int selectExistDetail(long idx) throws Exception;

	public Map<String, Object> selectDbDetailInfo(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectDbDetailPreNext(long idx) throws Exception;

	public Map<String, Object> selectDbDetailViewInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectDbDetailDivList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectDbDetailDivMovieList(Map<String, Object> paramMap) throws Exception;

	public int deleteUserViewProc(Map<String, String> paramMap) throws Exception;

	public int insertUserViewProc(Map<String, String> paramMap) throws Exception;

	public int selectUserViewCount(Map<String, String> paramMap) throws Exception;

	public List<Map<String, Object>> selectAllMoviePageList(Map<String, Object> paramMap) throws Exception;

	public int selectAllMovieListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * DB 메인 키워드 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DbMainKeywordVo> selectMainKeywordList() throws Exception;

	/**
	 * DB 메인 영화제 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DbMainFestivalVo> selectMainFestivalList() throws Exception;

	/**
	 * DB 메인 테마 키워드 정보 조회
	 * @return
	 * @throws Exception
	 */
	public DbMainThemeVo selectMainThemeKeywordInfo() throws Exception;

	/**
	 * DB 메인 영화리스트 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DbMainMovieListVo> selectMainMovieList() throws Exception;

	/**
	 * DB 메인 배너 정보 조회
	 * @return
	 * @throws Exception
	 */
	public MainContentVo selectMainBannerInfo() throws Exception;

}
