package egovframework.ag.homepage.history.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.history.service.ArchivesMasterVo;
import egovframework.ag.homepage.history.service.HistoryService;

@Controller
@RequestMapping("/history/document")
public class DocumentController {
	private final String CODE_ID = "C117";
	private final String FILE_TYPE_CD = "80";

	@Autowired
	private CommonService commonService;

	@Autowired
	private HistoryService historyService;

	/**
	 * 공문서 목록 조회
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String documentList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> codeList = commonService.selectSearchCodeList(CODE_ID);

		//구술채록문 구분 code01 : 10 국문, 20 영문
		String code01 = paramMap.getString("code01");
		String headYear = paramMap.getString("headYear");
		String year = paramMap.getString("year");

		if ("".equals(code01) == false) {
			List<Map<String, Object>> headYearList = historyService.selectArchivesSubCodeHeadYearList(Constant.ARCHIVE_PUBLIC_CODE, code01, "");

			if (headYearList != null && headYearList.size() > 0 && StringUtils.isEmpty(headYear) == true ) {
				paramMap.put("headYear", StringUtils.getString(headYearList.get(0).get("year")));
			}

			model.addAttribute("headYearList", headYearList);
		}


		headYear = paramMap.getString("headYear");

		if ("".equals(headYear) == false) {
			List<Map<String, Object>> yearList = historyService.selectArchivesSubCodeYearList(Constant.ARCHIVE_PUBLIC_CODE, code01, "", headYear);

			if (yearList != null && yearList.size() > 0 && StringUtils.isEmpty(year) == true ) {
				paramMap.put("year", StringUtils.getString(yearList.get(0).get("year")));
			}

			model.addAttribute("yearList", yearList);
		}

		paramMap.put("archivesTypeCd", Constant.ARCHIVE_PUBLIC_CODE);
		paramMap.put("fileTypeCd", FILE_TYPE_CD);

		PageListVo<ArchivesMasterVo> pageListVo = historyService.selectArchivesList(paramMap.getMap(), codeList);


        model.addAttribute("paramMap", paramMap.getMap());

		model.addAttribute("code01List", commonService.selectSearchCodeList(CODE_ID));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return "/history/documentList";
	}


	/**
	 * 공문서 사업소개
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/intro")
	public String intro(ParamMap paramMap, Model model) throws Exception {
		Map<String, Object> introMap = historyService.selectArchivesIntroInfo(Constant.ARCHIVE_PUBLIC_CODE);

		introMap.put("contents",StringUtils.getStripTagByPattern(StringUtils.getString(introMap.get("contents"))));

		model.addAttribute("introInfo", introMap);

		return "/history/introDocument";
	}

}
