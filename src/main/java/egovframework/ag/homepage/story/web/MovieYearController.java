package egovframework.ag.homepage.story.web;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.homepage.story.service.MovieYearService;

/**
 * 영화 연표 Controller
 * @author tipgi
 *
 */
@Controller
@RequestMapping("/story/year")
public class MovieYearController {
	@Autowired
	private MovieYearService movieYearService;

	/**
	 * 영화연표 상세
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String movieYearDetail(Model model) throws Exception {
		String movieYear = movieYearService.selectMaxMovieYear();

		return this.movieYearDetail(movieYear, model);
	}

	/**
	 * 영화연표 상세
	 * @param movieYear
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{movieYear}")
	public String movieYearDetail(@PathVariable(value="movieYear") String movieYear, Model model) throws Exception {
		Map<String, Object> detailInfo = movieYearService.selectMovieYearInfo(movieYear);

		detailInfo.put("content",StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("content"))));;

		model.addAttribute("movieYearList", movieYearService.selectMovieYearYearList());
		model.addAttribute("detailInfo", detailInfo);

		return "/story/movieYearDetail";
	}
}
