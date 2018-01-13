package egovframework.ag.homepage.own.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.ag.common.vo.PageListVo;

@Service
public class OwnService {

	@Autowired
	private OwnDao ownDao;

	/**
	 * 소장정보 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public TotalCountVO selectOwnDataCount(Map<String, Object> paramMap) throws Exception{
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		Device device = DeviceUtils.getCurrentDevice(sra.getRequest());
		//모바일이나 태블릿 체크
        if (device != null && (device.isMobile() || device.isTablet())) {
        	paramMap.put("mobileYN", "Y");
        }
		return ownDao.selectOwnDataCount(paramMap);
	}

	public PageListVo<FilmVO> selectFilmList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<FilmVO>(ownDao.selectFilmListCount(paramMap), ownDao.selectFilmPageList(paramMap));

	}

	public PageListVo<DcinemaVO> selectDcinemaList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<DcinemaVO>(ownDao.selectDcinemaListCount(paramMap), ownDao.selectDcinemaPageList(paramMap));

	}
	public PageListVo<TapeDiskVO> selectTapeList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<TapeDiskVO>(ownDao.selectTapeListCount(paramMap), ownDao.selectTapePageList(paramMap));

	}
	public PageListVo<TapeDiskVO> selectDiskList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<TapeDiskVO>(ownDao.selectDiskListCount(paramMap), ownDao.selectDiskPageList(paramMap));

	}
	public PageListVo<MultiVO> selectMultiList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<MultiVO>(ownDao.selectMultiListCount(paramMap), ownDao.selectMultiPageList(paramMap));

	}
	public PageListVo<VodVO> selectVodList(Map<String, Object> paramMap) throws Exception {

		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		Device device = DeviceUtils.getCurrentDevice(sra.getRequest());
		//모바일이나 태블릿 체크
        if (device != null && (device.isMobile() || device.isTablet())) {
        	paramMap.put("mobileYN", "Y");
        }

		return new PageListVo<VodVO>(ownDao.selectVodListCount(paramMap), ownDao.selectVodPageList(paramMap));

	}

	public PageListVo<PosterVO> selectPosterList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<PosterVO>(ownDao.selectPosterListCount(paramMap), ownDao.selectPosterPageList(paramMap));

	}
	public PageListVo<StillVO> selectStillList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<StillVO>(ownDao.selectStillListCount(paramMap), ownDao.selectStillPageList(paramMap));

	}
	public PageListVo<ScenarioVO> selectScenarioList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<ScenarioVO>(ownDao.selectScenarioListCount(paramMap), ownDao.selectScenarioPageList(paramMap));

	}
	public PageListVo<HandbillVO> selectHandbillList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<HandbillVO>(ownDao.selectHandbillListCount(paramMap), ownDao.selectHandbillPageList(paramMap));

	}
	public PageListVo<BookVO> selectBookList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<BookVO>(ownDao.selectBookListCount(paramMap), ownDao.selectBookPageList(paramMap));

	}
	public PageListVo<TheoryVO> selectTheoryList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<TheoryVO>(ownDao.selectTheoryListCount(paramMap), ownDao.selectTheoryPageList(paramMap));

	}
	public PageListVo<CensorshipVO> selectCensorshipList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<CensorshipVO>(ownDao.selectCensorshipListCount(paramMap), ownDao.selectCensorshipPageList(paramMap));

	}
	public PageListVo<NewsVO> selectNewsList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<NewsVO>(ownDao.selectNewsListCount(paramMap), ownDao.selectNewsPageList(paramMap));

	}
	public PageListVo<EtcVO> selectEtcList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<EtcVO>(ownDao.selectEtcListCount(paramMap), ownDao.selectEtcPageList(paramMap));

	}
	public PageListVo<OstVO> selectOstList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<OstVO>(ownDao.selectOstListCount(paramMap), ownDao.selectOstPageList(paramMap));

	}
	public PageListVo<EquipVO> selectEquipList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<EquipVO>(ownDao.selectEquipListCount(paramMap), ownDao.selectEquipPageList(paramMap));

	}
}
