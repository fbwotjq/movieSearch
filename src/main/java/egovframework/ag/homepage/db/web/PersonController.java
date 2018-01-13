package egovframework.ag.homepage.db.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.db.service.PersonService;
import egovframework.ag.homepage.story.service.MovieStoryService;
import egovframework.ag.homepage.story.service.MovieStoryVo;

@Controller
@RequestMapping("/db/per")
public class PersonController {
	@Autowired
	private PersonService personService;

	@Autowired
	private MovieStoryService movieStoryService;
	/**
	 * 영화인 상세 기본정보
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{personId}")
	public String personDetail(@PathVariable String personId, ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		Device device = DeviceUtils.getCurrentDevice(request);
		String mobileYn = "Y";

		if (device == null || device.isNormal() == true) {
			mobileYn = "N";
		}

		model.addAttribute("personInfo", personService.selectPersonInfo(personId));

		model.addAttribute("imageList", personService.selectImageList(personId));
		model.addAttribute("mulList", personService.selectMulList(personId, mobileYn));
		model.addAttribute("filmoList", personService.selectFilmoList(personId));
		model.addAttribute("festivalAwardsList", personService.selectFestivalAwardsList(personId));

		paramMap.put("personId", personId);
		model.addAttribute("pageListVo", movieStoryService.selectRelPersonMovieStoryList(paramMap.getMap()));

		model.addAttribute("paramMap", paramMap.getMap());

		return "/db/personDetail";
	}

	/**
	 * 영화인 필모그라피 상세정보
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{personId}/filmo")
	public String personDetailFilmo(@PathVariable String personId, ParamMap paramMap, Model model) throws Exception {
		model.addAttribute("personInfo", personService.selectPersonInfo(personId));

		model.addAttribute("filmoList", personService.selectFilmoDetailList(personId));
		model.addAttribute("paramMap", paramMap.getMap());

		return "/db/personFilmo";
	}

	/**
	 * 영화인 수상정보 상세정보
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{personId}/festival")
	public String personDetailFestival(@PathVariable String personId, ParamMap paramMap, Model model) throws Exception {
		model.addAttribute("personInfo", personService.selectPersonInfo(personId));

		model.addAttribute("festivalAwardsList", personService.selectFestivalAwardsList(personId));
		model.addAttribute("paramMap", paramMap.getMap());

		return "/db/personFestival";
	}

	/**
	 * 영화인 관련글 상세정보
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{personId}/story")
	public String personDetailStory(@PathVariable String personId, ParamMap paramMap, Model model) throws Exception {
		model.addAttribute("personInfo", personService.selectPersonInfo(personId));

		paramMap.put("personId", personId);

		PageListVo<MovieStoryVo> pageListVo = movieStoryService.selectRelPersonMovieStoryList(paramMap.getMap());


		model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
		model.addAttribute("pageListVo", pageListVo);

		model.addAttribute("paramMap", paramMap.getMap());

		return "/db/personStory";
	}
}
