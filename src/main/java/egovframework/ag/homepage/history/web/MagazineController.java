package egovframework.ag.homepage.history.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.Constant;
import egovframework.ag.common.annotation.LoginUser;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.history.service.ArchivesMasterVo;
import egovframework.ag.homepage.history.service.HistoryService;

@Controller
@RequestMapping("/history/magazine")
public class MagazineController {
	private final String CODE_ID = "C115";
	private final String FILE_TYPE_CD = "50";
	private final String GALLARY_FILE_TYPE_CD = "60";

	@Autowired
	private CommonService commonService;

	@Autowired
	private HistoryService historyService;

	/**
	 * 영화잡지 목록 조회
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String magazineList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> codeList = commonService.selectSearchCodeList(CODE_ID);

		//구술채록문 구분 code01 : 10 국문, 20 영문
		String code01 = paramMap.getString("code01");
		String year = paramMap.getString("year");

		if ("".equals(code01) == false) {
			List<Map<String, Object>> yearList = historyService.selectArchivesSubCodeYearList(Constant.ARCHIVE_MAGAZ_CODE, code01, "");

			if (yearList != null && yearList.size() > 0 && StringUtils.isEmpty(year) == true ) {
				paramMap.put("year", StringUtils.getString(yearList.get(0).get("year")));
			}

			model.addAttribute("yearList", yearList);
		}


		paramMap.put("archivesTypeCd", Constant.ARCHIVE_MAGAZ_CODE);
		paramMap.put("fileTypeCd", FILE_TYPE_CD);

		PageListVo<ArchivesMasterVo> pageListVo = historyService.selectArchivesList(paramMap.getMap(), codeList);


        model.addAttribute("paramMap", paramMap.getMap());

		model.addAttribute("code01List", commonService.selectSearchCodeList(CODE_ID));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return "/history/magazineList";
	}


	/**
	 * 잡지 상세 조회
	 * @param archivesSeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{archivesSeq}")
	public String magazineDetail(@LoginUser MemberDetails memberDetail, @PathVariable Long archivesSeq, ParamMap paramMap, Model model) throws Exception {
		List<Map<String, Object>> codeList = commonService.selectSearchCodeList(CODE_ID);

		Map<String, Object> masterInfo = historyService.selectArchivesMasterInfo(archivesSeq, codeList);

		Long fileSeq = StringUtils.getLong(masterInfo.get("fileSeq"));


		model.addAttribute("masterInfo", masterInfo);
		model.addAttribute("contentList", historyService.selectArchivesContentList(archivesSeq));
		model.addAttribute("masterFileInfo", historyService.selectArchivesFileInfo(fileSeq, FILE_TYPE_CD));
		model.addAttribute("gallaryList", historyService.selectArchivesFileList(fileSeq, GALLARY_FILE_TYPE_CD));

		model.addAttribute("paramMap", paramMap.getMap());

		return  "/history/magazineDetail";
	}
}
