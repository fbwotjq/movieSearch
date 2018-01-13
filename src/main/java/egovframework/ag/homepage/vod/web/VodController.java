package egovframework.ag.homepage.vod.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.vod.service.VodService;

@Controller
@RequestMapping("/vod")
public class VodController {
	private final Logger logger = LogManager.getLogger();

	@Autowired
	private VodService vodService;

	@Autowired
	private CommonService commonService;


	@RequestMapping("/main")
	public String mainView(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		Map<String, Object> info = vodService.selectVodMain("VOD_PLAN");
		model.addAttribute("detailInfo", info);
		model.addAttribute("detailInfoList", vodService.selectVodMainList((String)info.get("key1")) );

		paramMap.put("codeGroupId", "C104");
		model.addAttribute("searchTypeCodeSubList", commonService.selectSearchCodeList(paramMap.getMap()));
		model.addAttribute("vodSearchTextList", vodService.selectVodSearchTextList());

		Map<String, Object> movieInfo = vodService.selectVodMain("VOD_MULTI");
		movieInfo.put("category", "kmdbVOD");
		movieInfo.put("movieId", (String)movieInfo.get("key1"));
		movieInfo.put("movieSeq", (String)movieInfo.get("key2"));
		model.addAttribute("movieInfo", movieInfo);
		model.addAttribute("movieVodInfo", vodService.selectVodMainInfo(movieInfo));

		model.addAttribute("paramMap", paramMap.getMap());

		return "/vod/main";
	}

	@RequestMapping("/plan")
	public String selectPlanList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		if (paramMap.getString("siteTypeCd").equals("")) {
        	paramMap.put("siteTypeCd", "KOR");
        }

		PageListVo pageListVo = vodService.selectPlanList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("pageTotal", paramMap.getTotalPageCount(pageListVo.getTotalCount()));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return  "/vod/plan";
	}

	@RequestMapping("/plan/page/ajax")
	@ResponseBody
	public Map<String, Object> selectPlanAjaxList(ParamMap paramMap) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", "N");

		PageListVo pageListVo = vodService.selectPlanList(paramMap.getMap());

		resultMap.put("pageListVo", pageListVo);

		if (pageListVo != null && pageListVo.getResultList() != null && pageListVo.getResultList().size() > 0) {
			resultMap.put("result", "Y");
		}

		return resultMap;
	}

	@RequestMapping("/plan/{planSeq}")
	public String selectPlanInfo(@PathVariable long planSeq, ParamMap paramMap, Model model) throws Exception {

		Map<String, Object> detailInfo = vodService.selectPlanInfo(planSeq);

		if(detailInfo != null && detailInfo.size() > 0){
			//편집기 태그 정리
			detailInfo.put("summaryDesc", StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("summaryDesc"))));
			detailInfo.put("contentDesc", StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contentDesc"))));
		}

		model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("detailInfo", detailInfo);
		model.addAttribute("relMovieList", vodService.selectPlanRelMovieList(planSeq));

		return  "/vod/planView";
	}

	@RequestMapping("/old/movie")
	public String selectOldMovieList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		String orderKey1 = StringUtils.trimToEmpty(paramMap.getString("orderKey1"));
		if("".equals(orderKey1)){
			paramMap.put("orderKey1", "title");
		}
		String orderKey2 = StringUtils.trimToEmpty(paramMap.getString("orderKey2"));
		if("".equals(orderKey2)){
			paramMap.put("orderKey2", "desc");
		}

		PageListVo pageListVo = vodService.selectOldMovieList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("pageTotal", paramMap.getTotalPageCount(pageListVo.getTotalCount()));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("vodSearchTextList", vodService.selectVodSearchTextList());

		return  "/vod/old/movie";
	}

	@RequestMapping("/old/docu")
	public String selectOldDocuList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		String orderKey1 = StringUtils.trimToEmpty(paramMap.getString("orderKey1"));
		if("".equals(orderKey1)){
			paramMap.put("orderKey1", "title");
		}
		String orderKey2 = StringUtils.trimToEmpty(paramMap.getString("orderKey2"));
		if("".equals(orderKey2)){
			paramMap.put("orderKey2", "desc");
		}

		PageListVo pageListVo = vodService.selectOldDocuList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("pageTotal", paramMap.getTotalPageCount(pageListVo.getTotalCount()));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return  "/vod/old/docu";
	}

	@RequestMapping("/player/movie")
	public String selectMovieInfo(HttpServletRequest request, Model model
			, @RequestParam(value="fileNm", defaultValue="") String fileNm) throws Exception {

		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("fileNm", fileNm);

		if(!"".equals(fileNm)){
			int index = fileNm.lastIndexOf(".");
			if(index > 0){
				fileNm = fileNm.substring(0, index);
			}
			String splits[] = fileNm.split("_");
			if(splits.length > 1){
				fileNm = splits[0] + "_" + splits[1];
				model.addAttribute("fno",fileNm);
			}
		}

		String userId = "";
		Authentication auth = (Authentication) request.getUserPrincipal();
		MemberDetails userDetails = null;
		if(auth != null) {
			userDetails = (MemberDetails) auth.getPrincipal();
			userId = userDetails.getUserid();
			model.addAttribute("userId",userId);
		}

		Map<String,Object> returnMap = vodService.selectMovieInfo(paramMap);
		if(returnMap == null){
			model.addAttribute("resultYn","N");
			model.addAttribute("resultMsg","지정된 동영상이 없습니다.");
		}else{
			model.addAttribute("resultYn","Y");
		}

		model.addAttribute("result",returnMap);

		return  "/noLayout/vod/pop/mPlayer";
	}


	@RequestMapping("/player")
	public String selectVodInfo(HttpServletRequest request, Model model
			, @RequestParam(value="movieId", defaultValue="") String movieId
			, @RequestParam(value="movieSeq", defaultValue="") String movieSeq
			, @RequestParam(value="fileNm", defaultValue="") String fileNm
			, @RequestParam(value="fileId", defaultValue="") String fileId
			, @RequestParam(value="mulId", defaultValue="") String mulId) throws Exception {

		Map<String,Object> paramMap = new HashMap<String,Object>();
		Map<String,Object> returnMap = new HashMap<String,Object>();

		if("".equals(movieId) && "".equals(movieSeq)&& !"".equals(mulId)){
			paramMap.put("mulId", mulId);
			paramMap.put("fileId", fileId);
		}else{
			paramMap.put("movieId", movieId);
			paramMap.put("movieSeq", movieSeq);
		}
		returnMap = vodService.selectVodInfo(paramMap);

		String userId = "";
		Authentication auth = (Authentication) request.getUserPrincipal();
		MemberDetails userDetails = null;
		if(auth != null) {
			userDetails = (MemberDetails) auth.getPrincipal();
			userId = userDetails.getUserid();
		}
		returnMap.put("userId",userId);

		if(!"".equals(fileNm)){
			int index = fileNm.lastIndexOf(".");
			if(index > 0){
				fileNm = fileNm.substring(0, index);
			}
			String splits[] = fileNm.split("_");
			if(splits.length > 1){
				fileNm = splits[0] + "_" + splits[1];
				returnMap.put("fno",fileNm);
			}
		}

		returnMap.put("movieId",movieId);
		returnMap.put("movieSeq",movieSeq);

		model.addAttribute("result",returnMap);

		return  "/noLayout/vod/pop/player";
	}

	@RequestMapping("/player/count")
	@ResponseBody
	public Map<String, String> updatePlayerCount(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {
			vodService.updatePlayerCount(param);
		} catch (Exception e) {
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	@RequestMapping("/player/check")
	@ResponseBody
	public Map<String, Object> selectPlayerCheck(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			Authentication auth = (Authentication) request.getUserPrincipal();
			if(auth == null){
				resultMap.put("result", "false");
				resultMap.put("errorType", "01");
				return resultMap;
			}

			resultMap = vodService.selectVodViewCheck(param);
		} catch (Exception e) {
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	@RequestMapping("/add/cart")
	@ResponseBody
	public Map<String, Object> insertVodCart(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			vodService.insertVodCart(param);
			resultMap.put("result", "true");
		} catch (Exception e) {
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	@RequestMapping("/charge/check")
	@ResponseBody
	public Map<String, Object> selectVodChargeCheck(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Authentication auth = (Authentication) request.getUserPrincipal();
			if(auth == null){
				resultMap.put("result", "false");
				resultMap.put("errorType", "01");
				return resultMap;
			}else{
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				param.put("userId",userDetails.getUserid());
			}

			resultMap = vodService.selectVodChargeCheck(param);
		} catch (Exception e) {
			resultMap.put("result", "false");
			resultMap.put("errorType", "99");
		}

		return resultMap;
	}

}
