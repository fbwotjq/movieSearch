package egovframework.ag.homepage.db.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;
import egovframework.ag.homepage.own.service.DcinemaVO;
import egovframework.ag.homepage.own.service.FilmVO;
import egovframework.ag.homepage.own.service.PosterVO;
import egovframework.ag.homepage.own.service.StillVO;
import egovframework.ag.homepage.own.service.TapeDiskVO;
import egovframework.ag.homepage.own.service.VodVO;

@KMDBMapper
public interface KorDao {

	public Map<String, Object> selectMovieDetailInfo(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectMovieHeadImg(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectVodInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectDirectorList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectActorList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectImageList(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectStoryInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectStaffList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectStaffDivList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectMovieAwardList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectMovieAwardEtcList(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectSubDetailInfo(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectAnotherTitleInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectLocationList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectDivList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectUserReviewList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectRelMovieList(Map<String, Object> paramMap) throws Exception;

	public Integer selectSnoCount(Map<String, String> paramMap) throws Exception;

	public int insertSnoInfo(Map<String, String> paramMap) throws Exception;

	public int insertUserViewProc(Map<String, String> paramMap) throws Exception;

	public int selectUserViewCount(Map<String, String> paramMap) throws Exception;

	public List<FilmVO> selectFilmList(Map<String, Object> paramMap) throws Exception;

	public List<DcinemaVO> selectDcinemaList(Map<String, Object> paramMap) throws Exception;

	public List<TapeDiskVO> selectTapeList(Map<String, Object> paramMap) throws Exception;

	public List<TapeDiskVO> selectDiskList(Map<String, Object> paramMap) throws Exception;

	public List<VodVO> selectVodList(Map<String, Object> paramMap) throws Exception;

	public List<PosterVO> selectPosterList(Map<String, Object> paramMap) throws Exception;

	public List<StillVO> selectStillList(Map<String, Object> paramMap) throws Exception;
/*
	public int selectFestivalListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalPageList(Map<String, Object> paramMap) throws Exception;

	public int selectFestivalListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalPageList(Map<String, Object> paramMap) throws Exception;

	public int selectFestivalListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalPageList(Map<String, Object> paramMap) throws Exception;

	public int selectFestivalListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFestivalPageList(Map<String, Object> paramMap) throws Exception;

*/
}
