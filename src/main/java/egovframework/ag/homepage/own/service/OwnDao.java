package egovframework.ag.homepage.own.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface OwnDao {

	public TotalCountVO selectOwnDataCount(Map<String, Object> paramMap) throws Exception;

	public int selectFilmListCount(Map<String, Object> paramMap) throws Exception;

	public List<FilmVO> selectFilmPageList(Map<String, Object> paramMap) throws Exception;

	public int selectDcinemaListCount(Map<String, Object> paramMap) throws Exception;

	public List<DcinemaVO> selectDcinemaPageList(Map<String, Object> paramMap) throws Exception;

	public int selectTapeListCount(Map<String, Object> paramMap) throws Exception;

	public List<TapeDiskVO> selectTapePageList(Map<String, Object> paramMap) throws Exception;

	public int selectDiskListCount(Map<String, Object> paramMap) throws Exception;

	public List<TapeDiskVO> selectDiskPageList(Map<String, Object> paramMap) throws Exception;

	public int selectMultiListCount(Map<String, Object> paramMap) throws Exception;

	public List<MultiVO> selectMultiPageList(Map<String, Object> paramMap) throws Exception;

	public int selectVodListCount(Map<String, Object> paramMap) throws Exception;

	public List<VodVO> selectVodPageList(Map<String, Object> paramMap) throws Exception;

	public int selectPosterListCount(Map<String, Object> paramMap) throws Exception;

	public List<PosterVO> selectPosterPageList(Map<String, Object> paramMap) throws Exception;

	public int selectStillListCount(Map<String, Object> paramMap) throws Exception;

	public List<StillVO> selectStillPageList(Map<String, Object> paramMap) throws Exception;

	public int selectScenarioListCount(Map<String, Object> paramMap) throws Exception;

	public List<ScenarioVO> selectScenarioPageList(Map<String, Object> paramMap) throws Exception;

	public int selectHandbillListCount(Map<String, Object> paramMap) throws Exception;

	public List<HandbillVO> selectHandbillPageList(Map<String, Object> paramMap) throws Exception;

	public int selectBookListCount(Map<String, Object> paramMap) throws Exception;

	public List<BookVO> selectBookPageList(Map<String, Object> paramMap) throws Exception;

	public int selectTheoryListCount(Map<String, Object> paramMap) throws Exception;

	public List<TheoryVO> selectTheoryPageList(Map<String, Object> paramMap) throws Exception;

	public int selectCensorshipListCount(Map<String, Object> paramMap) throws Exception;

	public List<CensorshipVO> selectCensorshipPageList(Map<String, Object> paramMap) throws Exception;

	public int selectNewsListCount(Map<String, Object> paramMap) throws Exception;

	public List<NewsVO> selectNewsPageList(Map<String, Object> paramMap) throws Exception;

	public int selectEtcListCount(Map<String, Object> paramMap) throws Exception;

	public List<EtcVO> selectEtcPageList(Map<String, Object> paramMap) throws Exception;

	public int selectOstListCount(Map<String, Object> paramMap) throws Exception;

	public List<OstVO> selectOstPageList(Map<String, Object> paramMap) throws Exception;

	public int selectEquipListCount(Map<String, Object> paramMap) throws Exception;

	public List<EquipVO> selectEquipPageList(Map<String, Object> paramMap) throws Exception;

	public List<PosterStillVO> selectPosterStillList(Map<String, Object> paramMap) throws Exception;
}
