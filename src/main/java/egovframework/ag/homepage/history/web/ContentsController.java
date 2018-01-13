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
@RequestMapping("/history/contents")
public class ContentsController {
	private final String CODE_ID = "C118";
	private final String DATA_FILE_TYPE_CD = "90";
	private final String GALLARY_FILE_TYPE_CD = "100";


	@Autowired
	private CommonService commonService;

	@Autowired
	private HistoryService historyService;

	/**
	 * 사료콘텐츠 목록 조회
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String contentsList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		List<Map<String, Object>> codeList = commonService.selectSearchCodeList(CODE_ID);

		String code01 = paramMap.getString("code01");
		if("".equals(code01)){
			paramMap.put("code01", "10");
		}

		paramMap.put("archivesTypeCd", Constant.ARCHIVE_CONTENT_CODE);

		PageListVo<ArchivesMasterVo> pageListVo = historyService.selectArchivesList(paramMap.getMap(), codeList);

        model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("code01List", commonService.selectSearchCodeList(CODE_ID));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
        model.addAttribute("headInfo", historyService.selectArchivesHeadInfo(Constant.ARCHIVE_CONTENT_CODE));

		return "/history/contentsList";
	}


	/**
	 * 사료콘텐츠 상세 조회
	 * @param archivesSeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{archivesSeq}")
	public String contentsDetail(@LoginUser MemberDetails memberDetail, @PathVariable Long archivesSeq, ParamMap paramMap, Model model) throws Exception {
		List<Map<String, Object>> codeList = commonService.selectSearchCodeList(CODE_ID);

		Map<String, Object> masterInfo = historyService.selectArchivesMasterInfo(archivesSeq, codeList);

		Long fileSeq = StringUtils.getLong(masterInfo.get("fileSeq"));


		model.addAttribute("masterInfo", masterInfo);
		model.addAttribute("contentList", historyService.selectArchivesContentList(archivesSeq));

		model.addAttribute("relMovieList", historyService.selectArchivesRelMovieList(archivesSeq));
		model.addAttribute("relPersonList", historyService.selectArchivesRelPersonList(archivesSeq));

		model.addAttribute("relDataList", historyService.selectArchivesFileList(fileSeq, DATA_FILE_TYPE_CD));
		model.addAttribute("relLinkList", historyService.selectArchivesRelLinkList(archivesSeq));
		model.addAttribute("gallaryList", historyService.selectArchivesFileList(fileSeq, GALLARY_FILE_TYPE_CD));

		model.addAttribute("paramMap", paramMap.getMap());

		return  "/history/contentsDetail";
	}
}
