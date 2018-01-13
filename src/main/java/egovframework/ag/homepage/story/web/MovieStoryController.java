package egovframework.ag.homepage.story.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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
import egovframework.ag.common.web.MenuMap;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.story.service.MovieStoryService;
import egovframework.ag.homepage.story.service.MovieStoryVo;

/**
 * 영화글 Controller
 * @author tipgi
 *
 */
@Controller
@RequestMapping("/story")
public class MovieStoryController {
	private final Integer MANI_MOVIE_STORY_COUNT = 15;
	private final Integer DETAIL_NEW_MOVIE_STORY_COUNT = 3;

	@SuppressWarnings("unused")
	private final static Logger LOGGER = LogManager.getLogger();

	@Autowired
	private MovieStoryService movieStoryService;

	/**
	 * 영화글 메인화면
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/main")
	public String mainView(ParamMap paramMap, Model model) throws Exception {

		Map<String, Object> info = movieStoryService.selectMovieStroyHeadInfo();

		if(info != null && info.size() > 0){
			//편집기 태그 정리
			info.put("contentDesc", StringUtils.getStripTagByPattern(StringUtils.getString(info.get("contentDesc"))));
		}

		model.addAttribute("movieStroyHeadInfo", info); //대표영화글
		model.addAttribute("movieStoryList", movieStoryService.selectMainMovieStoryList(MANI_MOVIE_STORY_COUNT));//영화글 목록
		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/main";
	}

	/**
	 * 영화글 메인 메뉴 리스트
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/main/menu")
	@ResponseBody
	public Map<String, Object> mainMenuView(@RequestParam(value="menuId", required=true) String menuId, Model model) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", "true");
		try {

			ArrayList<Map<String,Object>> returnList = new ArrayList<Map<String,Object>>();

			List<Map<String,Object>> menuList = MenuMap.getMenuList();

			int cnt = 0;
			for(Map<String,Object> m : menuList){
				if(menuId.equals(m.get("cParentId"))){
					returnList.add(m);
					if(cnt == 0){
						resultMap.put("fistTitle", m.get("cPmenuTitle"));
						cnt++;
					}
				}
			}
			resultMap.put("list", returnList);

		} catch (Exception e) {
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 영화글 목록
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{storyDivSeq}")
	public String movieStoryList(@PathVariable Long storyDivSeq, ParamMap paramMap, Model model) throws Exception {
		Map<String, Object> storyDivSeqMap = movieStoryService.selectSearchTargetStoryDivSeqInfo(storyDivSeq);

		paramMap.putAll(storyDivSeqMap);

		PageListVo<MovieStoryVo> pageListVo = movieStoryService.selectMovieStoryList(paramMap.getMap());

		model.addAttribute("storyDivInfo", storyDivSeqMap);
		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/storyList";
	}

	/**
	 * 종료연재 영화글 목록
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/end")
	public String endMovieStoryList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		model.addAttribute("movieStoryDivList", movieStoryService.selectEndStoryDivList());//종료연재 영화글 구분 목록
		model.addAttribute("movieStoryList", movieStoryService.selectEndMovieStoryList(paramMap));//종료연재 영화글 목록

		return "/story/storyList";
	}

	/**
	 * 영화글 상세
	 * @param storySeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{storyDivSeq}/{storySeq}")
	public String movieStoryDetail(@PathVariable Long storyDivSeq, @PathVariable Long storySeq, ParamMap paramMap, Model model) throws Exception {
		MovieStoryVo movieStoryVo = movieStoryService.selectMovieStoryInfo(storySeq);//영화글 상세정보

		paramMap.put("storyDivSeq", movieStoryVo.getStoryDivSeq());

		model.addAttribute("detailInfo", movieStoryVo);
		model.addAttribute("preDetailInfo", movieStoryService.selectWriterPreMovieStoryInfo(movieStoryVo));//작가의 이전 영화글 상세정보
		model.addAttribute("newMovieStoryList", movieStoryService.selectMovieStoryList(paramMap.getMap(), DETAIL_NEW_MOVIE_STORY_COUNT));//최신글 3건
		model.addAttribute("choiceMovieList", movieStoryService.selectChoiceMovieStoryList());//추천영화글
		model.addAttribute("relMovieList", movieStoryService.selectMovieStoryRelMovieList(storySeq));//연관 영화
		model.addAttribute("relPersonList", movieStoryService.selectMovieStoryRelPersonList(storySeq));//연관 영화인

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/storyDetail";
	}

	/**
	 * 필자 목록
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/writer/list")
	public String writerList(ParamMap paramMap, Model model) throws Exception {
		model.addAttribute("writerList", movieStoryService.selectWriterMovieStoryCountList());
		return "/story/storyWriterList";
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

		PageListVo<MovieStoryVo> pageListVo = movieStoryService.selectMovieStoryList(paramMap.getMap());

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/writerStoryList";
	}

	/**
	 * 영화글 키워드 검색 목록
	 * @param keyword
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/keyword/list")
	public String movieWebzineKeywordList(@RequestParam(value="keyword", required=true) String keyword, ParamMap paramMap, Model model) throws Exception {


		PageListVo<MovieStoryVo> pageListVo = movieStoryService.selectMovieStoryList(paramMap.getMap());

		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/story/storyKeywordSearchList";
	}
}
