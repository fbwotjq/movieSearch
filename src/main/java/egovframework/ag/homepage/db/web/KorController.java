package egovframework.ag.homepage.db.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.ag.common.Constant;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.CommonListVO;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.db.service.DbService;
import egovframework.ag.homepage.db.service.KorService;
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
import egovframework.ag.homepage.story.service.MovieReviewService;
import egovframework.ag.homepage.story.service.MovieReviewVo;
import egovframework.ag.homepage.story.service.MovieStoryService;
import egovframework.ag.homepage.story.service.MovieStoryVo;

@Controller
@RequestMapping("/db/kor")
public class KorController {

	@Autowired
	private KorService korService;

	@Autowired
	private MovieStoryService movieStoryService;

	@Autowired
	private MovieReviewService movieReviewService;

	@Autowired
	private DbService dbService;

	@Autowired
	private OwnService ownService;

	/**
	 * 영화기본정보상세
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}")
	public String selectMovieDetailInfo(@PathVariable String movieId, @PathVariable String movieSeq, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);
		model.addAttribute("paramMap", paramMap.getMap());

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "5");
		}

		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트

		model.addAttribute("vodInfo", korService.selectVodInfo(paramMap.getMap())); //Vod 정보
		model.addAttribute("imageList", korService.selectImageList(paramMap.getMap())); //이미지 리스트
		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우
		model.addAttribute("staffList", korService.selectStaffList(paramMap.getMap())); //스태프
		model.addAttribute("staffDivList", korService.selectStaffDivList(paramMap.getMap())); //스태프
		model.addAttribute("awardList", korService.selectMovieAwardList(paramMap.getMap())); //수상정보 리스트

		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2
		model.addAttribute("anotherTitleInfo", korService.selectAnotherTitleInfo(paramMap.getMap())); //다른제목
		model.addAttribute("locationList", korService.selectLocationList(paramMap.getMap())); //로케이션

		model.addAttribute("divList", korService.selectDivList(paramMap.getMap())); //리스트 정보

		PageListVo<MovieStoryVo> pageListVo = movieStoryService.selectRelMovieStoryList(paramMap.getMap()); //관련글 리스트
		PageListVo<MovieReviewVo> pageListVo2 = movieReviewService.selectRelMovieReviewList(paramMap.getMap()); //관련리뷰 리스트

		model.addAttribute("pageListVo", pageListVo); //관련글
		model.addAttribute("pageListVo2", pageListVo2); //관련리뷰

		model.addAttribute("relMovieList", korService.selectRelMovieList(paramMap.getMap())); //관련 영화 리스트

		return "/db/kor/movieDetail";
	}

	/**
	 * 영화 크레디트 더보기
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/credit")
	public String selectRelMovieActorInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);

		model.addAttribute("paramMap", paramMap.getMap());

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/

		model.addAttribute("staffList", korService.selectStaffList(paramMap.getMap())); //스태프
		model.addAttribute("staffDivList", korService.selectStaffDivList(paramMap.getMap())); //스태프

		return "/db/kor/movieRelCreditDetail";
	}

	/**
	 * 영화 관련글 더보기
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/story")
	public String selectRelMovieStoryInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "10");
		}
		model.addAttribute("paramMap", paramMap.getMap());

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/


		PageListVo<MovieStoryVo> pageListVo = movieStoryService.selectRelMovieStoryList(paramMap.getMap()); //관련글 리스트

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo); //관련글
		return "/db/kor/movieRelStoryDetail";
	}

	/**
	 * 영화 사용자리뷰 더보기
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/review")
	public String selectRelMovieReviewInfo(@PathVariable String movieId, @PathVariable String movieSeq, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "10");
		}
		model.addAttribute("paramMap", paramMap.getMap());

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/


		PageListVo<MovieReviewVo> pageListVo = movieReviewService.selectRelMovieReviewList(paramMap.getMap()); //사용자리뷰 리스트

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo); //관련글
		return "/db/kor/movieRelReviewDetail";
	}


	/**
	 * 영화 수상정보 더보기
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/award")
	public String selectRelMovieAwardInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);
		model.addAttribute("paramMap", paramMap.getMap());

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/

		model.addAttribute("awardList", korService.selectMovieAwardList(paramMap.getMap())); //수상정보 리스트
		model.addAttribute("awardEtcList", korService.selectMovieAwardEtcList(paramMap.getMap())); //수상정보 리스트

		return "/db/kor/movieRelAwardDetail";
	}

	/**
	 * 영화 스크랩
	 * - 내가 본 영화 등록
	 * @return
	 */
	@RequestMapping("/detail/movie/scrap/{view}/proc")
	@ResponseBody
	public Map<String, String> insertUserViewProc(@PathVariable String view, @RequestParam Map<String, String> paramMap, HttpServletRequest request, Model model) throws Exception {
		String sname= "";
		if(view == "1"){
			sname = "보고 싶은 영화";
		}else{
			sname = "내가 본 영화";
		}
		paramMap.put("view", view);
		paramMap.put("sname", sname);

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
					paramMap.put("userName", userDetails.getName());
					paramMap.put("stype", userDetails.getSex());
				}
			}

			int resultCnt = korService.insertUserViewProc(paramMap);
			resultMap.put("resultCnt", String.valueOf(resultCnt));

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}



	/**
	 * 영화관련  소장 영상자료 상세
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/own/videoData")
	public String selectRelMovieOwnVidoeInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "8");
		}

		PageListVo<MultiVO> pageListVo= ownService.selectMultiList(paramMap.getMap());

		List<FilmVO> filmList= korService.selectFilmList(paramMap.getMap()); //Film 리스트
		List<DcinemaVO> dcinemaList= korService.selectDcinemaList(paramMap.getMap()); //Dcinema 리스트
		List<TapeDiskVO> tapeList= korService.selectTapeList(paramMap.getMap()); //Tape 리스트
		List<TapeDiskVO> diskList= korService.selectDiskList(paramMap.getMap()); //Disk 리스트
		List<VodVO> vodList = korService.selectVodList(paramMap.getMap()); //Vod 리스트

        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));

    	model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("filmList", filmList);
		model.addAttribute("dcinemaList", dcinemaList);
		model.addAttribute("tapeList", tapeList);
		model.addAttribute("diskList", diskList);
		model.addAttribute("multiList", pageListVo);
		model.addAttribute("vodList", vodList); //Vod 리스트

		return "/db/kor/movieRelOwnVideoDetail";
	}

	/**
	 * 영화관련 소장 이미지자료 상세
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/own/image")
	public String selectRelMovieOwnImageInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);
		paramMap.put("typeClss", "2");

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "8");
		}

		PageListVo<PosterVO> list07= ownService.selectPosterList(paramMap.getMap()); // poster 리스트
		PageListVo<StillVO> list08= ownService.selectStillList(paramMap.getMap());   // 스틸 리스트

    	model.addAttribute("paramMap", paramMap.getMap());
    	model.addAttribute("paging", paramMap.getPagingTagString(list07.getTotalCount(),"P"));
    	model.addAttribute("paging2", paramMap.getPagingTagString(list08.getTotalCount(),"S"));
    	model.addAttribute("pageListVo", list07);
    	model.addAttribute("pageListVo2", list08);

    	List<PosterVO> galleryPosterList= korService.selectPosterList(paramMap.getMap()); //갤러리 이미지 리스트
    	List<StillVO> galleryStillList= korService.selectStillList(paramMap.getMap()); //갤러리 이미지 리스트
		model.addAttribute("galleryPosterList", galleryPosterList);
		model.addAttribute("galleryStillList", galleryStillList);

    	paramMap.put("typeClss", "1");
    	List<PosterVO> posterPrintList= korService.selectPosterList(paramMap.getMap()); //Poster 인쇄물 리스트
		List<StillVO> stillPrintList = korService.selectStillList(paramMap.getMap()); //스틸 인쇄물 리스트
		model.addAttribute("posterPrintList", posterPrintList);
		model.addAttribute("stillPrintList", stillPrintList);

		return "/db/kor/movieRelOwnImageDetail";
	}

	/**
	 * 영화관련 소장 이미지자료 상세
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/own/listpage")
	public String selectRelMovieOwnImageListPage(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);
		String typeClss = "2";
		paramMap.put("typeClss", typeClss);

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "8");
		}

    	model.addAttribute("paramMap", paramMap.getMap());
    	if( "P".equals(paramMap.getString("searchType") ) ){
    		PageListVo<PosterVO> pageListVo= ownService.selectPosterList(paramMap.getMap()); // poster 리스트
    		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount(), paramMap.getString("searchType")));
    		model.addAttribute("pageListVo", pageListVo);
    	}else{
    		PageListVo<StillVO> pageListVo= ownService.selectStillList(paramMap.getMap());   // 스틸 리스트
    		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount(), paramMap.getString("searchType")));
    		model.addAttribute("pageListVo", pageListVo);
    	}

		return  "/noLayout/db/kor/listpage";
	}

	/**
	 * 영화관련 소장 문서자료 상세
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/own/document")
	public String selectRelMovieOwnDocumentInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "9999");
		}

		PageListVo<ScenarioVO> list09= ownService.selectScenarioList(paramMap.getMap());
		PageListVo<HandbillVO> list10= ownService.selectHandbillList(paramMap.getMap());
		PageListVo<BookVO> list11= ownService.selectBookList(paramMap.getMap());
		PageListVo<TheoryVO> list12= ownService.selectTheoryList(paramMap.getMap());
		PageListVo<CensorshipVO> list13= ownService.selectCensorshipList(paramMap.getMap());
		PageListVo<NewsVO> list14= ownService.selectNewsList(paramMap.getMap());
		PageListVo<EtcVO> list15= ownService.selectEtcList(paramMap.getMap());

    	model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("scenarioList", list09); //시나리오/콘티 리스트
		model.addAttribute("handbillList", list10); //전단 리스트
		model.addAttribute("bookList", list11); //도서 리스트
		model.addAttribute("theoryList", list12); //논문 리스트
		model.addAttribute("censorshipList", list13); // 심의자료 리스트
		model.addAttribute("newsList", list14); //보도자료 리스트
		model.addAttribute("etcList", list15); //기타자료 리스트

		return "/db/kor/movieRelOwnDocumentDetail";
	}

	/**
	 * 영화관련 소장 기타자료 상세
	 **/
	@RequestMapping("/detail/movie/{movieId}/{movieSeq}/own/etc")
	public String selectRelMovieOwnEtcInfo(@PathVariable String movieId, @PathVariable String movieSeq,  ParamMap paramMap, Model model) throws Exception {
		paramMap.put("movieId", StringUtils.toUpperCase(movieId));
		paramMap.put("movieSeq", movieSeq);

		/****기본 프로필 정보 시작	 ****/
		model.addAttribute("detailInfo", korService.selectMovieDetailInfo(paramMap.getMap()));//영화기본정보
		model.addAttribute("subDetailInfo", korService.selectSubDetailInfo(paramMap.getMap())); //상세정보2

		model.addAttribute("directorList", korService.selectDirectorList(paramMap.getMap())); //감독
		model.addAttribute("actorList", korService.selectActorList(paramMap.getMap())); //배우

		TotalCountVO totalCountVO = ownService.selectOwnDataCount(paramMap.getMap());
		model.addAttribute("ownListCount", totalCountVO);//기본정보 카운트
		/****	****/

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "9999");
		}

		PageListVo<OstVO> list16= ownService.selectOstList(paramMap.getMap());
		PageListVo<EquipVO> list17= ownService.selectEquipList(paramMap.getMap());

    	model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("ostList", list16); //보도자료 리스트
		model.addAttribute("equipList", list17); //기타자료 리스트

		return "/db/kor/movieRelOwnEtcDetail";
	}






	/**
	 * 작품검색 메인
	 **/
	@RequestMapping("")
	public String mainView(Model model, HttpServletResponse res) throws Exception {
		return "/db/kor/korSearch";
	}

	/**
	 * 작품검색 결과
	 **/
	@RequestMapping("/list")
	public String searchResultList(Model model, HttpServletResponse res) throws Exception {
		return "/db/kor/searchList";
	}

	/**
	 * 한국영화 더보기
	 **/
	@RequestMapping("/list/kor")
	public String searchKorList(Model model, HttpServletResponse res) throws Exception {
		return "/db/kor/korList";
	}

	/**
	 * 국외영화 더보기
	 **/
	@RequestMapping("/list/foreign")
	public String searchForeignList(Model model, HttpServletResponse res) throws Exception {
		return "/db/kor/foreignList";
	}



}
