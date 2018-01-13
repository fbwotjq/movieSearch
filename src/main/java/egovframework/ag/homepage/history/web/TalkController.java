package egovframework.ag.homepage.history.web;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.history.service.ArchivesMasterVo;
import egovframework.ag.homepage.history.service.HistoryService;

@Controller
@RequestMapping("/history/talk")
public class TalkController {
	private final String SUB_CODE_ID = "C110";
	private final String FILE_TYPE_CD_20 = "20";//해제문
	private final String FILE_TYPE_CD_30 = "30";//경력사항

	@Autowired
	private CommonService commonService;

	@Autowired
	private HistoryService historyService;

	/**
	 * 구술채록문 목록 조회
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String talkList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		paramMap.put("codeGroupId", SUB_CODE_ID);

		List<Map<String, Object>> codeList = commonService.selectCodeTreeList(paramMap.getMap());

		model.addAttribute("code01List", codeList);

		//구술채록문 구분 code01 : 10 생애사, 20 주제사
		String code01 = paramMap.getString("code01");
		if("".equals(code01)){
			paramMap.put("code01", "10");
			paramMap.put("code02", "");
		}

		paramMap.put("archivesTypeCd", Constant.ARCHIVE_SPEECH_CODE);

		PageListVo<ArchivesMasterVo> pageListVo = historyService.selectArchivesList(paramMap.getMap(), codeList);

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
        model.addAttribute("partCodeList", commonService.selectSearchCodeList("C111"));
		return "/history/talkList";
	}


	/**
	 * 구술채록문 상세 조회
	 * @param archivesSeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{archivesSeq}")
	public String talkDetail(@PathVariable Long archivesSeq, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("codeGroupId", SUB_CODE_ID);

		List<Map<String, Object>> codeList = commonService.selectCodeTreeList(paramMap.getMap());


		Map<String, Object> masterInfo = historyService.selectArchivesMasterInfo(archivesSeq, codeList);

		Long fileSeq = StringUtils.getLong(masterInfo.get("fileSeq"));

		model.addAttribute("masterInfo", masterInfo);
		model.addAttribute("contentList", historyService.selectArchivesContentList(archivesSeq));
		model.addAttribute("pdf20FileInfo", historyService.selectArchivesFileInfo(fileSeq, FILE_TYPE_CD_20));
		model.addAttribute("pdf30FileInfo", historyService.selectArchivesFileInfo(fileSeq, FILE_TYPE_CD_30));
		model.addAttribute("contentFileList", historyService.selectArchivesContentFileList(archivesSeq));

		model.addAttribute("paramMap", paramMap.getMap());

		return  "/history/talkDetail";
	}

	/**
	 * 구술인 목록 조회
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/target/list")
	public String talkTargetList(ParamMap paramMap, Model model) throws Exception {

		model.addAttribute("targetList", historyService.selectArchivesTalkTargetCountList());


		return "/history/targetList";
	}

	/**
	 * 구술채록문 사업소개
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/intro")
	public String intro(ParamMap paramMap, Model model) throws Exception {
		Map<String, Object> introMap = historyService.selectArchivesIntroInfo(Constant.ARCHIVE_SPEECH_CODE);

		introMap.put("contents",StringUtils.getStripTagByPattern(StringUtils.getString(introMap.get("contents"))));

		model.addAttribute("introInfo", introMap);

		return "/history/introTalk";
	}

	/**
	 * 구술채록문 키워드
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/keyword/list")
	public String kewordList(@RequestParam(value="keyword", required=true) String keyword, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("codeGroupId", SUB_CODE_ID);

		List<Map<String, Object>> codeList = commonService.selectCodeTreeList(paramMap.getMap());

		paramMap.put("keyword", URLDecoder.decode(keyword,"UTF-8"));
		paramMap.put("archivesTypeCd", Constant.ARCHIVE_SPEECH_CODE);

		PageListVo<ArchivesMasterVo> pageListVo = historyService.selectArchivesList(paramMap.getMap(), codeList);

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return "/history/talkKeywordList";
	}



}
