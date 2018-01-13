package egovframework.ag.homepage.member.web;

import java.net.URLDecoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.ag.common.annotation.LoginUser;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.member.service.ChangeInfoVo;
import egovframework.ag.homepage.member.service.ChangePassVo;
import egovframework.ag.homepage.member.service.JoinMemberVo;
import egovframework.ag.homepage.member.service.MemberService;
import egovframework.ag.homepage.member.service.MyPageService;
import egovframework.ag.homepage.member.service.OutMemberVo;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private MyPageService myPageService;

	/**
	 * 1:1 문의내역
	 *
	 * @param searchOrderType
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ask")
	public String selectAskList(@RequestParam(value="searchOrderType", required=false) String searchOrderType, ParamMap paramMap, Model model, Principal principal) throws Exception {

        if (principal!=null) {
        	paramMap.put("userId", principal.getName());
        }
        paramMap.put("searchOrderType", searchOrderType);

		PageListVo pageListVo = myPageService.selectAskList(paramMap.getMap());

		model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return "/mypage/ask";
	}

	/**
	 * 1:1 문의내역 상세
	 *
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ask/{seq}")
	public String selectAskInfo(@PathVariable long seq, ParamMap paramMap, Model model) throws Exception {

		Map<String, Object> detailInfo = myPageService.selectAskInfo(seq);

		if(detailInfo != null && detailInfo.size() > 0){
			//편집기 태그 정리
			detailInfo.put("contentDesc", StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contentDesc"))));
			detailInfo.put("replyContentDesc", StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("replyContentDesc"))));
		}

		model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("detailInfo", detailInfo);

		return  "/mypage/askView";
	}

	/**
	 * 나의 영화
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie")
	public String selectMovieList(@RequestParam(value="gubun", defaultValue="0") String gubun
			                              , @RequestParam(value="yearGubun", defaultValue="0") String yearGubun
			                              , @RequestParam(value="monthGubun", defaultValue="0") String monthGubun
										  , ParamMap paramMap,Model model, Principal principal) throws Exception {

		if (principal!=null) {
        	paramMap.put("userId", principal.getName());
        }

		//구분자가 없이 들어오는경우 전체로 검색
		paramMap.put("gubun", gubun);
		paramMap.put("yearGubun", yearGubun);
		paramMap.put("monthGubun", monthGubun);

		Map<String, Object> resultMap =  myPageService.selectMovieCountList(paramMap.getMap());
		//년도선택이 없는경우는 가장 최근 년도 자동선택
		if("0".equals(yearGubun)){
			List<Map<String, Object>> yearResultList = (List<Map<String, Object>>) resultMap.get("year");
			if(yearResultList != null && yearResultList.size() > 0){
				paramMap.put("yearGubun", yearResultList.get(0).get("yearText"));
			}
		}

        model.addAttribute("result", resultMap);
        PageListVo pageListVo = myPageService.selectMovieList(paramMap.getMap());
		model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);


		return "/mypage/movie";
	}

	/**
	 * 나의 영화 삭제
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie/remove")
	@ResponseBody
	public Map<String, String> removeMovieList(@RequestParam(value="checkArray[]") List<String> arrayParams, ParamMap paramMap,Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
				}
			}
			paramMap.put("clipSeqnoList", arrayParams);
			myPageService.removeMovieList(paramMap.getMap());
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 나의 영화 카테고리 중복체크
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie/category/check")
	@ResponseBody
	public Map<String, String> selectCategoryCheck(@RequestParam(value="categoryName", required=false) String categoryName, Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");

		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("sName", URLDecoder.decode(categoryName,"UTF-8"));

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
				}
			}
			int resultCnt = myPageService.selectCategoryCheck(paramMap);
			if(resultCnt == 0){
				resultMap.put("result", "true");
			}else{
				resultMap.put("result", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 나의 영화 카테고리 수정
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie/category/edit")
	@ResponseBody
	public Map<String, String> updateCategory(@RequestParam(value="sno") String sno, @RequestParam(value="editText") String editText, Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");

		try {

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("sno", sno);
			paramMap.put("sName", URLDecoder.decode(editText,"UTF-8"));

			myPageService.updateCategory(paramMap);
			resultMap.put("result", "true");

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 나의 영화 카테고리 삭제
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie/category/remove")
	@ResponseBody
	public Map<String, String> removeCategory(@RequestParam(value="sno") String sno, @RequestParam(value="editText") String editText, Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");

		try {

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("sno", sno);
			paramMap.put("sName", URLDecoder.decode(editText,"UTF-8"));

			myPageService.removeCategory(paramMap);
			resultMap.put("result", "true");

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 나의 영화 카테고리 등록
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie/category/proc")
	@ResponseBody
	public Map<String, String> insertCategoryList(@RequestParam(value="categoryNameList[]") List<String> categoryNameList, Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");

		try {

			Map<String, Object> paramMap = new HashMap<String, Object>();

			ArrayList<String> paramList = new ArrayList<String>();
			for(String tmp : categoryNameList){
				paramList.add(URLDecoder.decode(tmp,"UTF-8"));
			}
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
				}
			}
			myPageService.insertCategoryList(paramMap, paramList);
			resultMap.put("result", "true");

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 나의 영화 관람일 등록
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/movie/see/regist")
	@ResponseBody
	public Map<String, String> insertSeeDate(@RequestParam(value="seeDate") String seeDate,@RequestParam(value="clipSeqno") String clipSeqno,@RequestParam(value="sno") String sno, Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");

		try {

			Map<String, Object> paramMap = new HashMap<String, Object>();

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					paramMap.put("userId", userDetails.getUserid());
				}
			}

			paramMap.put("seeDate", seeDate);
			paramMap.put("clipSeqno", clipSeqno);
			paramMap.put("sno", sno);

			myPageService.updateSeeDate(paramMap);

			resultMap.put("result", "true");

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	/**
	 * 나의 구매 vod
	 *
	 * @param searchOrderType
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/vod")
	public String selectVodList(@RequestParam(value="searchOrderType", required=false) String searchOrderType, @RequestParam(value="gubun", defaultValue = "v") String gubun, HttpServletRequest request, ParamMap paramMap, Model model, Principal principal) throws Exception {

		String returnView = "";
		if (principal!=null) {
        	paramMap.put("userId", principal.getName());
        }

		if (searchOrderType!=null) {
			paramMap.put("searchOrderType", searchOrderType);
		} else {
			paramMap.put("searchOrderType", "DESC");
		}

		paramMap.put("gubun", gubun);
		PageListVo<Map<String,Object>> pageListVo = null;

		if("b".equals(gubun)){
			pageListVo = myPageService.selectBookList(paramMap.getMap());
			returnView = "/mypage/book";
		}else if("c".equals(gubun)){
			pageListVo = myPageService.selectCouponList(paramMap.getMap());
			returnView = "/mypage/coupon";
		}else{
			pageListVo = myPageService.selectVodList(paramMap.getMap());
			returnView = "/mypage/vod";
		}

		model.addAttribute("gubun", gubun);
		model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return returnView;
	}

	/**
	 * 나의 영화글
	 *
	 * @param searchOrderType
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/text")
	public String selectTextList(@RequestParam(value="searchOrderType", required=false) String searchOrderType, ParamMap paramMap,Model model, Principal principal) throws Exception {

		if (principal!=null) {
        	paramMap.put("userId", principal.getName());
        }
        paramMap.put("searchOrderType", searchOrderType);

		PageListVo pageListVo = myPageService.selectTextList(paramMap.getMap());

		model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return "/mypage/text";
	}

	/**
	 * 나의 영화글 상세
	 *
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/text/{seq}")
	public String selectTextInfo(@PathVariable long seq, ParamMap paramMap,Model model) throws Exception {

		Map<String, Object> detailInfo = myPageService.selectTextInfo(seq);

		if(detailInfo != null && detailInfo.size() > 0){
			//편집기 태그 정리
			detailInfo.put("contentDesc", StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contentDesc"))));
		}

		model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("detailInfo", detailInfo);

		return "/mypage/textView";
	}

	/**
	 * 내정보 관리 - 비밀번호 확인
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/check")
	public String check(ParamMap paramMap, Model model, Principal principal) throws Exception {

		return "/mypage/check";
	}

	/**
	 * 내정보 조회
	 *
	 * @param password
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/info")
	public String selectInfo(@LoginUser MemberDetails memberDetail, @RequestParam(value="password", required=false) String password, ParamMap paramMap, Model model, Principal principal) throws Exception {
		if(password!=null && password.length()>0){
			String encodedPassword = null;

			// 비밀번호 암호화
			encodedPassword = memberService.selectEncryptString(password);

			System.out.println("encodedPassword :" + encodedPassword);

			if(encodedPassword!=null && (memberDetail.getPasswd()).equals(encodedPassword)){
				JoinMemberVo joinMemberVo = new JoinMemberVo();

				joinMemberVo = memberService.selectMypageInfo(memberDetail.getUserid());

				joinMemberVo.setUserName(memberDetail.getName());
				joinMemberVo.setBirthDate(memberDetail.getUserAge());
				joinMemberVo.setCellNo1((joinMemberVo.getCellNo()).split("-")[0]);
				joinMemberVo.setCellNo2((joinMemberVo.getCellNo()).split("-")[1]);
				joinMemberVo.setCellNo3((joinMemberVo.getCellNo()).split("-")[2]);
				joinMemberVo.setEmailId((joinMemberVo.getMailAddr()).split("@")[0]);
				joinMemberVo.setEmailDomain((joinMemberVo.getMailAddr()).split("@")[1]);

				model.addAttribute("joinMemberVo", joinMemberVo);

				return "/mypage/info";
			}
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");

			return "redirect:/mypage/check";
		}

		else {

			return "redirect:/mypage/check";
		}
	}

	/**
	 * 내정보 관리 - 비밀번호 변경하기
	 *
	 * @param memberDetail
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/info/password")
	public String password(@LoginUser MemberDetails memberDetail, ParamMap paramMap, Model model, Principal principal) throws Exception {
		model.addAttribute("userId", memberDetail.getUserid());

		return "/mypage/password";
	}

	/**
	 * 내정보 관리 - 비밀번호 변경하기 - 결과
	 *
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/info/password/result")
	public String passwordResult(@LoginUser MemberDetails memberDetail, @ModelAttribute ChangePassVo changePassVo, ParamMap paramMap, Model model, Principal principal) throws Exception {
		int updCnt = 0;

		if((memberDetail.getUserid())!=null && (memberDetail.getUserid()).length()>0){
			changePassVo.setUserId(memberDetail.getUserid());

			updCnt = memberService.updatePasswordInfo(changePassVo);
		}

		model.addAttribute("updCnt", updCnt);

		return "/mypage/passwordResult";
	}

	/**
	 * 내정보 변경
	 *
	 * @param changeInfoVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/info/result")
	public String changeInfo(@LoginUser MemberDetails memberDetail, @ModelAttribute ChangeInfoVo changeInfoVo, ParamMap paramMap, Model model, Principal principal) throws Exception {
		int updCnt = 0;

		if((memberDetail.getUserid())!=null && (memberDetail.getUserid()).length()>0){
			changeInfoVo.setUserId(memberDetail.getUserid());

			updCnt = memberService.updateMypageInfo(changeInfoVo);
		}

		model.addAttribute("updCnt", updCnt);

		return "/mypage/infoResult";
	}

	/**
	 * 회원 탈퇴 - 비밀번호 확인
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/out")
	public String getOut(ParamMap paramMap, Model model, Principal principal) throws Exception {

		return "/mypage/out";
	}

	/**
	 * 회원 탈퇴
	 *
	 * @param password
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/out/result")
	public String outResult(@LoginUser MemberDetails memberDetail, @RequestParam(value="password", required=false) String password, ParamMap paramMap, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(password!=null && password.length()>0){
			String encodedPassword = null;

			// 비밀번호 암호화
			encodedPassword = memberService.selectEncryptString(password);

			System.out.println("encodedPassword :" + encodedPassword);

			if(encodedPassword!=null && (memberDetail.getPasswd()).equals(encodedPassword)){
				OutMemberVo outMemberVo = new OutMemberVo();

				outMemberVo.setUserId(memberDetail.getUserid());
				outMemberVo.setUserName(memberDetail.getName());
				outMemberVo.setWithdrawalCategory("회원 직접 탈퇴");
				outMemberVo.setWithdrawalReason("");

				//memberService.insertOutMember(outMemberVo);
				memberService.updateMemberByOutProc(outMemberVo);

				//로그아웃처리
				this.signOutProcess(request, response);
				return "/mypage/outResult";

			}
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");

			return "redirect:/mypage/out";
		}else {
			return "redirect:/mypage/out";
		}
	}

	private void signOutProcess(HttpServletRequest request, HttpServletResponse response){
		// 로그아웃 처리
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		request.getSession().invalidate();

		//쿠키 삭제
		Cookie cookie = new Cookie("kffrtCookie", "");
		cookie.setDomain(".koreafilm.or.kr");
		cookie.setPath("/");
		cookie.setMaxAge(0);
		cookie.setVersion(0);
		cookie.setSecure(false);
		response.addCookie(cookie);
	}
}
