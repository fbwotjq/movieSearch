package egovframework.ag.homepage.db.web;

import java.util.HashMap;
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

import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.db.service.DbService;

@Controller
@RequestMapping("/db")
public class DbController {

	@Autowired
	private DbService dbService;

	@RequestMapping("/main")
	public String mainView(Model model, HttpServletResponse res) throws Exception {
		model.addAttribute("keywordList", dbService.selectMainKeywordList());
		model.addAttribute("festivalList", dbService.selectMainFestivalList());
		model.addAttribute("themeKeywordInfo", dbService.selectMainThemeKeywordInfo());
		model.addAttribute("movieList", dbService.selectMainMovieList());
		model.addAttribute("bannerInfo", dbService.selectMainBannerInfo());

		return "/db/main";
	}

	@RequestMapping("/festival")
	public String selectFestivalList(ParamMap paramMap,Model model, HttpServletResponse res) throws Exception {

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "8");
		}

		PageListVo<Map<String, Object>> pageListVo = dbService.selectFestivalList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
		return "/db/festival";
	}

	@RequestMapping("/festival/{feNo}/{fedNo}")
	public String selectFestivalInfo(@PathVariable long feNo, @PathVariable long fedNo, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("feNo", feNo);
		paramMap.put("fedNo", fedNo);

		model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("detailInfo", dbService.selectFestivalInfo(paramMap.getMap()));

		return  "/db/festivalView";
	}

	@RequestMapping("/festival/{feNo}/{fedNo}/poster")
	public String selectFestivalPosterList(@PathVariable long feNo, @PathVariable long fedNo, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("feNo", feNo);
		paramMap.put("fedNo", fedNo);
		PageListVo<Map<String, Object>> pageListVo = dbService.selectFestivalPosterList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
        model.addAttribute("detailInfo", dbService.selectFestivalBasic(paramMap.getMap()));

		return  "/db/festivalPoster";
	}

	@RequestMapping("/festival/{feNo}/{fedNo}/award")
	public String selectAwardList(@PathVariable long feNo, @PathVariable long fedNo, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("feNo", feNo);
		paramMap.put("fedNo", fedNo);

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("result", dbService.selectAwardList(paramMap.getMap()));
        model.addAttribute("detailInfo", dbService.selectFestivalBasic(paramMap.getMap()));

		return  "/db/festivalAward";
	}

	@RequestMapping("/keyword")
	public String selectKeyword(ParamMap paramMap,Model model, HttpServletResponse res) throws Exception {

		PageListVo<Map<String, Object>>  pageListVo = dbService.selectKeywordList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
		return "/db/keyword";
	}

	@RequestMapping("/keyword/{idx}")
	public String selectKeywordInfo(@PathVariable long idx, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("idx", idx);
		PageListVo<Map<String, Object>>  pageListVo = dbService.selectKeywordSubList(paramMap.getMap());

		model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
		model.addAttribute("preNextMap", dbService.selectKeywordPreNext(idx));

		return  "/db/keywordView";
	}

	@RequestMapping("/keyword/{idx}/form")
	public String selectKeywordReg(@PathVariable long idx, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("idx", idx);
		model.addAttribute("preNextMap", dbService.selectKeywordPreNext(idx));
		model.addAttribute("paramMap", paramMap.getMap());

		return  "/db/keywordForm";
	}

	@RequestMapping("/keyword/{idx}/listpage")
	public String selectKeywordListPage(@PathVariable long idx, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("idx", idx);

		PageListVo<Map<String, Object>>  pageListVo = dbService.selectMovieList(paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount(), paramMap.getString("searchType")));
        model.addAttribute("pageListVo", pageListVo);
		model.addAttribute("paramMap", paramMap.getMap());
		return  "/noLayout/db/listpage";
	}

	@RequestMapping("/keyword/{idx}/proc")
	@ResponseBody
	public Map<String, String> insertKeywordProc(@RequestParam Map<String, String> param, HttpServletRequest request, Model model) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					param.put("userId", userDetails.getUserid());
			        param.put("userName", userDetails.getName());
				}
			}

			//dbService
			int resultCnt = dbService.insertKeywordProc(param);
			resultMap.put("resultCnt", String.valueOf(resultCnt));
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * DB 리스트
	 * -  DB 리스트  목록
	 *
	 *
	 * @return
	 */
	@RequestMapping("/list")
	public String listView(@RequestParam Map<String, Object> paramMap, Model model, HttpServletResponse res) throws Exception {
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
				}
			}
		} catch (Exception e) {
			paramMap.put("userId", "");
		}
		model.addAttribute("dbList", dbService.selectDbList());//DB영화 목록
		model.addAttribute("userDbViewList", dbService.selectUserDbViewList(paramMap));//DB 분류별 목록 조회
		model.addAttribute("dbListCount", dbService.selectDbListCount(paramMap));//총 영화수 조회
		model.addAttribute("userDbViewCount", dbService.selectUserDbViewCount(paramMap)); //회원이 본 영화수 조회

		return "/db/dbList";
	}

	/**
	 * DB 리스트
	 * -  DB 리스트  목록
	 *
	 *
	 * @return
	 */
	@RequestMapping("/list/{idx}")
	public String selectListInfo(@PathVariable long idx, ParamMap paramMap, Model model) throws Exception {

		int existDetail = dbService.selectExistDetail(idx);
		String movielistNo = paramMap.getString("movielistNo");
		paramMap.put("idx", idx);

		if(existDetail > 0){
			model.addAttribute("paramMap", paramMap.getMap());
	        model.addAttribute("detailInfo", dbService.selectDbDetailInfo(paramMap.getMap()));

			return  "/db/dbDetailView";
		}else{
			return "redirect:/db/list/detail/"+idx+"/"+movielistNo;
		}
	}

	/**
	 * DB 리스트
	 * -  DB 리스트 상세
	 *
	 *
	 * @return
	 */
	@RequestMapping("/list/detail/{idx}/{movielistNo}")
	public String selectDbDetailListInfo(@PathVariable long idx,@PathVariable long movielistNo, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("idx", idx);
		paramMap.put("movielistNo", movielistNo);
		try {

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
					paramMap.put("userName", userDetails.getName());
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			paramMap.put("userId", "");
		}

		model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("detailInfo", dbService.selectDbDetailListInfo(paramMap.getMap())); //DB리스트 상세 정보
		model.addAttribute("preNextMap", dbService.selectDbDetailPreNext(idx));
		return  "/db/dbListDetailView";
	}


	/**
	 * 내가 본 영화 등록
	 * - 내가 본 영화 등록
	 *
	 *
	 * @return
	 */
	@RequestMapping("/list/detail/{idx}/proc")
	@ResponseBody
	public Map<String, String> insertUserViewProc(@RequestParam Map<String, String> param, HttpServletRequest request, Model model) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					param.put("userId", userDetails.getUserid());
			        param.put("userName", userDetails.getName());
				}
			}
			//dbService
			int resultCnt = dbService.insertUserViewProc(param);
			resultMap.put("resultCnt", String.valueOf(resultCnt));
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * DB 통합리스트
	 * -  DB 리스트  목록
	 *
	 *
	 * @return
	 */
	@RequestMapping("/united/list")
	public String selectAllMovieList(ParamMap paramMap, Model model, HttpServletResponse res) throws Exception {
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
				}
			}
		} catch (Exception e) {
			paramMap.put("userId", "");
		}

		String pageSize = StringUtils.trimToEmpty(paramMap.getString("_pageSize"));
		if("".equals(pageSize)||"10".equals(pageSize)){
			paramMap.put("_pageSize", "10");
		}

		PageListVo<Map<String, Object>> pageListVo = dbService.selectAllMovieList(paramMap.getMap());

		int totalpage = (int) Math.ceil(pageListVo.getTotalCount()/ (double)10 );

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("totalpage", totalpage);
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
		model.addAttribute("userDbViewCount", dbService.selectUserDbViewCount(paramMap.getMap())); //회원이 본 영화수 조회

		return "/db/dbUnitedList";
	}
}
