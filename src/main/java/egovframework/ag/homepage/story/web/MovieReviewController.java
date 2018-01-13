package egovframework.ag.homepage.story.web;

import java.security.Principal;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.ReferenceUtils;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.story.service.MovieReviewService;
import egovframework.ag.homepage.db.service.DbService;

/**
 * 사용자 리뷰 Controller
 * @author 박종호
 *
 */
@Controller
public class MovieReviewController {

	@Autowired
	private MovieReviewService movieReviewService;

	@Autowired
	private DbService dbService;

	/**
	 * 사용자리뷰 리스트
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/story/user")
	public String selectUserReviewList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		PageListVo pageListVo = movieReviewService.selectUserReviewList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return  "/story/userReview";
	}

	/**
	 * 사용자리뷰 상세
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/story/user/{seq}")
	public String selectUserReviewInfo(@PathVariable Long seq, ParamMap paramMap, Model model) throws Exception {

		Map<String, Object> detailInfo = movieReviewService.selectUserReviewInfo(seq);

		if(detailInfo != null && detailInfo.size() > 0){
			//편집기 태그 정리
			detailInfo.put("contentDesc",StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contentDesc"))));
		}

		model.addAttribute("detailInfo", detailInfo);
		model.addAttribute("paramMap", paramMap.getMap());

		return  "/story/userReviewView";
	}

	/**
	 * 사용자리뷰 등록 화면
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/story/user/form")
	public String userReviewForm(ParamMap paramMap, Model model) throws Exception {

			model.addAttribute("paramMap", paramMap.getMap());
            return "/story/userReviewForm";
	}

	/**
	 * 사용자리뷰 등록
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/story/user/form/proc")
	public String insertUserReviewInfo(ParamMap paramMap, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, Principal principal)  {
		try {
			paramMap.put("createIp", request.getRemoteAddr());
			paramMap.put("privatePassword", "");

            if (principal!=null) {
            	paramMap.put("userId", principal.getName());
            }else{
            	paramMap.put("userId", paramMap.get("createName"));
            }
            System.out.println(paramMap.getMap());
			movieReviewService.insertUserReviewInfo(paramMap.getMap());
			return sendRedirect(redirectAttributes, "/story/user", "성공적으로 저장 되었습니다.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "/exception";
		}
	}



	@RequestMapping("/story/user/listpage")
	public String selectKeywordListPage(ParamMap paramMap, Model model) throws Exception {

		PageListVo<Map<String, Object>>  pageListVo = dbService.selectMovieList(paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount(), paramMap.getString("searchType")));
        model.addAttribute("pageListVo", pageListVo);
		model.addAttribute("paramMap", paramMap.getMap());
		return  "/noLayout/story/listpage";
	}


	private String sendRedirect(RedirectAttributes redirectAttributes, String redirectPath, String resultMsg) {
    	redirectAttributes.addFlashAttribute(Constant.RESULT_MSG, resultMsg);

    	return "redirect:" + redirectPath;
    }

	private void setCommonParam(RedirectAttributes redirectAttributes, Map<String, Object> paramMap) {
			redirectAttributes.addAttribute(Constant.PAGE, paramMap.get(Constant.PAGE));
			redirectAttributes.addAttribute(Constant.PAGE_SIZE, paramMap.get(Constant.PAGE_SIZE));
			redirectAttributes.addAttribute(Constant.SORT_KEY, paramMap.get(Constant.SORT_KEY));
			redirectAttributes.addAttribute(Constant.SORT_WORD, paramMap.get(Constant.SORT_WORD));
			redirectAttributes.addAttribute(Constant.SEARCH_TYPE, paramMap.get(Constant.SEARCH_TYPE));
			redirectAttributes.addAttribute(Constant.SEARCH_TEXT, paramMap.get(Constant.SEARCH_TEXT));
			redirectAttributes.addFlashAttribute(Constant.RESULT_MSG, paramMap.get(Constant.RESULT_MSG));
	}
}
