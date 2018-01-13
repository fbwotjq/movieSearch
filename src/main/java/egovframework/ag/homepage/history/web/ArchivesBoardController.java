package egovframework.ag.homepage.history.web;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.history.service.HistoryService;

@Controller
@RequestMapping("/history/board")
public class ArchivesBoardController {

	@Autowired
	private HistoryService historyService;

	/**
	 * 게시판 목록 조회
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String boardList(ParamMap paramMap, Model model) throws Exception {
		PageListVo<Map<String, Object>> pageListVo = historyService.selectArchivesBoardList(paramMap.getMap());

        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);
        model.addAttribute("paramMap", paramMap.getMap());

		return "/history/boardList";
	}

	/**
	 * 게시판 상세
	 * @param boardSeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{boardSeq}")
	public String boardDetail(@PathVariable Long boardSeq, ParamMap paramMap, Model model) throws Exception {
		Map<String, Object> detailInfo = historyService.selectArchivesBoardInfo(boardSeq);

		detailInfo.put("contentDesc",StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contentDesc"))));

		model.addAttribute("detailInfo", detailInfo);
		model.addAttribute("paramMap", paramMap.getMap());

		return "/history/boardDetail";
	}
}
