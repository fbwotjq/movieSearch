package egovframework.ag.homepage.db.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.homepage.own.service.OwnDao;

@Service
public class DbService {

	@Autowired
	private DbDao dbDao;

	@Autowired
	private OwnDao ownDao;

	/**
	 * 영화제 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String, Object>> selectFestivalList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectFestivalListCount(paramMap), dbDao.selectFestivalPageList(paramMap));

	}

	/**
	 * 영화제 상세
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectFestivalInfo(Map<String, Object> paramMap) throws Exception{

		Map<String, Object> result = selectFestivalBasic(paramMap);
		paramMap.put("_pageSize", "4");
		result.put("posterList", dbDao.selectFestivalPosterPageList(paramMap));
		result.put("awardList", dbDao.selectFestivalAwardList(paramMap));
		result.put("ownImgList", ownDao.selectPosterStillList(paramMap));

		return result;

	}

	/**
	 * 영화제 기본
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectFestivalBasic(Map<String, Object> paramMap) throws Exception{

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("info", dbDao.selectFestivalInfo(paramMap));
		result.put("cntInfo", ownDao.selectOwnDataCount(paramMap));

		return result;

	}

	/**
	 * 소장정보 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectOwnDataCount(Map<String, Object> paramMap) throws Exception{

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("ownInfoCount", ownDao.selectOwnDataCount(paramMap));
		return result;

	}




	/**
	 * 영화제 포스터 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String, Object>> selectFestivalPosterList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectFestivalPosterPageListCount(paramMap), dbDao.selectFestivalPosterPageList(paramMap));

	}

	/**
	 * 영화제 수상 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAwardList(Map<String, Object> paramMap) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("awardList", dbDao.selectFestivalAwardList(paramMap));
		result.put("awardYearList", dbDao.selectFestivalAwardYearList(paramMap));

		return result;

	}


	/**
	 * 키워드 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<Map<String, Object>> selectKeywordList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectKeywordListCount(paramMap), dbDao.selectKeywordPageList(paramMap));

	}

	public Map<String, Object> selectKeywordPreNext(long idx) throws Exception{

		return dbDao.selectKeywordPreNext(idx);

	}

	/**
	 * 키워드 상세 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<Map<String, Object>> selectKeywordSubList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectKeywordSubListCount(paramMap), dbDao.selectKeywordSubPageList(paramMap));

	}

	/**
	 * 영화 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<Map<String, Object>> selectMovieList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectMovieListCount(paramMap), dbDao.selectMoviePageList(paramMap));

	}

	/**
	 * 키워드 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public int insertKeywordProc(Map<String, String> paramMap) throws Exception {

		int keywordCnt = dbDao.selectKeywordCount(paramMap);
		if(keywordCnt > 0){
			return keywordCnt;
		}else{
			dbDao.insertKeywordProc(paramMap);
		}
		return keywordCnt;

	}

	/**
	 * DB 영화 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectDbList() throws Exception {
	    return dbDao.selectDbList();
	}


	/**
	 * DB 분류별 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public  List<Map<String, Object>>  selectUserDbViewList(Map<String, Object> paramMap) throws Exception {
		return dbDao.selectUserDbViewList(paramMap);
	}

	/**
	 * 총 영화수 조회
	 * @return
	 * @throws Exception
	 */
	public int selectDbListCount(Map<String, Object> paramMap) throws Exception {
	    return dbDao.selectDbListCount(paramMap);
	}


	/**
	 * 회원이 본 영화수 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectUserDbViewCount(Map<String, Object> paramMap) throws Exception {
		return dbDao.selectUserDbViewCount(paramMap);
	}

	/**
	 * 영화리스트상세 존재유무 조회
	 * @return
	 * @throws Exception
	 */
	public int selectExistDetail(long idx) throws Exception {
	    return dbDao.selectExistDetail(idx);
	}

	/**
	 * 영화리스트 상세
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDbDetailInfo(Map<String, Object> paramMap) throws Exception{
		return  dbDao.selectDbDetailInfo(paramMap);
	}

	/**
	 * 영화리스트 상세 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDbDetailListInfo(Map<String, Object> paramMap) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("viewInfo", dbDao.selectDbDetailViewInfo(paramMap));
		result.put("divList", dbDao.selectDbDetailDivList(paramMap));
		result.put("movieList", dbDao.selectDbDetailDivMovieList(paramMap));

		return result;

	}

	/**
	 * 영화리스트 상세 앞 뒤
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDbDetailPreNext(long idx) throws Exception{
		return dbDao.selectDbDetailPreNext(idx);
	}

	/**
	 * 내가본 영화 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public int insertUserViewProc(Map<String, String> paramMap) throws Exception {

		int userViewCnt = dbDao.selectUserViewCount(paramMap);
		if(userViewCnt > 0){
			dbDao.deleteUserViewProc(paramMap);
			return 0;
		}else{
			dbDao.insertUserViewProc(paramMap);
			return 1;
		}
	}

	/**
	 * 전체 리스트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String,Object>> selectAllMovieList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<Map<String,Object>>(dbDao.selectAllMovieListCount(paramMap), dbDao.selectAllMoviePageList(paramMap));
	}

	/**
	 * DB 메인 키워드 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DbMainKeywordVo> selectMainKeywordList() throws Exception {
		return dbDao.selectMainKeywordList();
	}

	/**
	 * DB 메인 영화제 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DbMainFestivalVo> selectMainFestivalList() throws Exception {
		return dbDao.selectMainFestivalList();
	}

	/**
	 * DB 메인 테마 키워드 정보 조회
	 * @return
	 * @throws Exception
	 */
	public DbMainThemeVo selectMainThemeKeywordInfo() throws Exception {
		return dbDao.selectMainThemeKeywordInfo();
	}

	/**
	 * DB 메인 영화리스트 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DbMainMovieListVo> selectMainMovieList() throws Exception {
		return dbDao.selectMainMovieList();
	}

	/**
	 * DB 메인 배너 정보 조회
	 * @return
	 * @throws Exception
	 */
	public MainContentVo selectMainBannerInfo() throws Exception {
		return dbDao.selectMainBannerInfo();
	}


}
