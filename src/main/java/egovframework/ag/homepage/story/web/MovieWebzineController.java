package egovframework.ag.homepage.story.web;

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
import egovframework.ag.homepage.common.service.KmdbService;
import egovframework.ag.homepage.story.service.MovieWebzineService;
import egovframework.ag.homepage.story.service.WebzineContentVo;
import egovframework.ag.homepage.story.service.WebzineCoverVo;

/**
 * 영화천국 Controller
 * @author tipgi
 *
 */
@Controller
@RequestMapping("/story/webzine")
public class MovieWebzineController {
	private final Integer LIST_SIZE = 15;

	@Autowired
	private MovieWebzineService movieWebzineService;

	@Autowired
	private KmdbService kmdbService;

	/**
	 * 웹진 목록
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String movieWebzineList(ParamMap paramMap, Model model) throws Exception {
		paramMap.put(Constant.PAGE_SIZE, this.LIST_SIZE);

		PageListVo<WebzineCoverVo> pageListVo = movieWebzineService.selectMovieWebzineList(paramMap.getMap());

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/webzineList";
	}

	/**
	 * 웹진 상세
	 * @param seq
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{seq}")
	public String movieWebzineDetail(@PathVariable(value="seq") Long seq, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("webzineSeq", seq);


		WebzineCoverVo webzineCoverVo = movieWebzineService.selectMovieWebzineCoverInfo(seq);

		model.addAttribute("detailInfo", webzineCoverVo);
		model.addAttribute("webzineContentList", movieWebzineService.selectMovieWebzineContentList(webzineCoverVo.getUpcate()));

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/webzineDetail";
	}

	/**
	 * 웹진 기사 상세
	 * @param seq
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/content/{seq}")
	public String movieWebzineContentDetail(@PathVariable(value="seq") Long seq, ParamMap paramMap, Model model) throws Exception {
		WebzineContentVo webzineContentVo = movieWebzineService.selectMovieWebzineContentInfo(seq);

		kmdbService.selectSimpleMovieList(webzineContentVo.getMoveiList());
		kmdbService.selectSimplePersonList(webzineContentVo.getPersonList());

		model.addAttribute("detailInfo", webzineContentVo);
		model.addAttribute("relMovieList", kmdbService.selectSimpleMovieList(webzineContentVo.getMoveiList()));
		model.addAttribute("relPersonList", kmdbService.selectSimplePersonList(webzineContentVo.getPersonList()));

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/webzineContentDetail";
	}

	/**
	 * 웹진 키워드 검색 목록
	 * @param keyword
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/keyword/list")
	public String movieWebzineKeywordList(@RequestParam(value="keyword", required=true) String keyword, ParamMap paramMap, Model model) throws Exception {
		if (StringUtils.getString(paramMap.get("init")).equals("T")) {
			paramMap.put(Constant.PAGE, "1");
			paramMap.put(Constant.PAGE_SIZE, "10");
		}

		PageListVo<WebzineContentVo> pageListVo = movieWebzineService.selectMovieWebzineKeywordSearchList(paramMap.getMap());

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/webzineKeywordSearchList";
	}


	/**
	 * 웹진 필자별 목록
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/writer/list")
	public String writerList(ParamMap paramMap, Model model) throws Exception {
		model.addAttribute("writerList", movieWebzineService.selectWriterWebzineCountList());

		return "/story/webzineWriterList";
	}

	/**
	 * 필자별 영화글 목록
	 * @param writerSeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/writer/content/list")
	public String writerMovieStoryList(@RequestParam(value="writer", required=true) String writerName, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("writerName", writerName);

		PageListVo<WebzineContentVo> pageListVo = movieWebzineService.selectWriterWebzineList(paramMap.getMap());

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/writerWebzineList";
	}
}
