package egovframework.ag.homepage.own.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.own.service.BookVO;
import egovframework.ag.homepage.own.service.CensorshipVO;
import egovframework.ag.homepage.own.service.DcinemaVO;
import egovframework.ag.homepage.own.service.EquipVO;
import egovframework.ag.homepage.own.service.EtcVO;
import egovframework.ag.homepage.own.service.FilmVO;
import egovframework.ag.homepage.own.service.HandbillVO;
import egovframework.ag.homepage.own.service.MultiVO;
import egovframework.ag.homepage.own.service.NewsVO;
import egovframework.ag.homepage.own.service.OstVO;
import egovframework.ag.homepage.own.service.OwnService;
import egovframework.ag.homepage.own.service.PosterVO;
import egovframework.ag.homepage.own.service.ScenarioVO;
import egovframework.ag.homepage.own.service.StillVO;
import egovframework.ag.homepage.own.service.TapeDiskVO;
import egovframework.ag.homepage.own.service.TheoryVO;
import egovframework.ag.homepage.own.service.TotalCountVO;
import egovframework.ag.homepage.own.service.VodVO;

@Controller
@RequestMapping("/own")
public class OwnController {
	private final static Logger logger = LogManager.getLogger();

	@Autowired
	private OwnService ownService;

	@RequestMapping("/list")
	public void list(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		paramMap.put("movieId", "K");
		paramMap.put("movieSeq", "07273");
		logger.info("---------------------------");
		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());

		PageListVo<FilmVO> list01= ownService.selectFilmList(paramMap.getMap());
		PageListVo<DcinemaVO> list02= ownService.selectDcinemaList(paramMap.getMap());
		PageListVo<TapeDiskVO> list03= ownService.selectTapeList(paramMap.getMap());
		PageListVo<TapeDiskVO> list04= ownService.selectDiskList(paramMap.getMap());
		PageListVo<MultiVO> list05= ownService.selectMultiList(paramMap.getMap());
		PageListVo<VodVO> list06= ownService.selectVodList(paramMap.getMap());
		PageListVo<PosterVO> list07= ownService.selectPosterList(paramMap.getMap());
		PageListVo<StillVO> list08= ownService.selectStillList(paramMap.getMap());
		PageListVo<ScenarioVO> list09= ownService.selectScenarioList(paramMap.getMap());
		PageListVo<HandbillVO> list10= ownService.selectHandbillList(paramMap.getMap());
		PageListVo<BookVO> list11= ownService.selectBookList(paramMap.getMap());
		PageListVo<TheoryVO> list12= ownService.selectTheoryList(paramMap.getMap());
		PageListVo<CensorshipVO> list13= ownService.selectCensorshipList(paramMap.getMap());
		PageListVo<NewsVO> list14= ownService.selectNewsList(paramMap.getMap());
		PageListVo<EtcVO> list15= ownService.selectEtcList(paramMap.getMap());
		PageListVo<OstVO> list16= ownService.selectOstList(paramMap.getMap());
		PageListVo<EquipVO> list17= ownService.selectEquipList(paramMap.getMap());

		logger.info("======================");
		logger.info(totalCountVO);
		logger.info("======================");
		logger.info(list01.getResultList());
		logger.info("======================");
		logger.info(list02.getResultList());
		logger.info("======================");
		logger.info(list03.getResultList());
		logger.info("======================");
		logger.info(list04.getResultList());
		logger.info("======================");
		logger.info(list05.getResultList());
		logger.info("======================");
		logger.info(list06.getResultList());
		logger.info("======================");
		logger.info(list07.getResultList());
		logger.info("======================");
		logger.info(list08.getResultList());
		logger.info("======================");
		logger.info(list09.getResultList());
		logger.info("======================");
		logger.info(list10.getResultList());
		logger.info("======================");
		logger.info(list11.getResultList());
		logger.info("======================");
		logger.info(list12.getResultList());
		logger.info("======================");
		logger.info(list13.getResultList());
		logger.info("======================");
		logger.info(list14.getResultList());
		logger.info("======================");
		logger.info(list15.getResultList());
		logger.info("======================");
		logger.info(list16.getResultList());
		logger.info("======================");
		logger.info(list17.getResultList());
		logger.info("======================");

		logger.info("---------------------------");

	}
}
