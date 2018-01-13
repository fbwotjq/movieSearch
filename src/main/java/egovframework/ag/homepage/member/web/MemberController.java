package egovframework.ag.homepage.member.web;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.ag.common.Constant;
import egovframework.ag.common.annotation.LoginUser;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.SessionUtil;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.homepage.member.service.ChangePassVo;
import egovframework.ag.homepage.member.service.JoinMemberVo;
import egovframework.ag.homepage.member.service.MemberService;
import egovframework.ag.homepage.member.service.OutMemberVo;
import egovframework.ag.homepage.nice.service.NiceCertiVo;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;

	/**
	 * 아이디 찾기
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findId")
	public String findId(Model model) throws Exception {
		return "/member/findId";
	}

	/**
	 * 아이디찾기 - 안심본인인증
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findId/nice")
	public String findIdNice(Model model) throws Exception {
		return "/member/findIdNice";
	}

	/**
	 * 아이디찾기 - 이메일
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findId/email", method = RequestMethod.GET)
	public String findIdEmail() throws Exception {
		return "/member/findIdEmail";
	}

	/**
	 * 아이디찾기 - 결과
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findId/result")
	public String findIdResult(Model model, @ModelAttribute NiceCertiVo niceCerti) throws Exception {
		NiceCertiVo resultCertiVo = memberService.selectMemberInfoByCerti(niceCerti);

		if (resultCertiVo != null) {
			model.addAttribute("findId", resultCertiVo.getResultMaskUserId());
		}

		return "/member/findIdResult";
	}

	/**
	 * 비밀번호 찾기
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findPass")
	public String findPass(HttpServletRequest request) throws Exception {
		SessionUtil.clearValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER);

		return "/member/findPass";
	}

	/**
	 * 비밀번호 찾기
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findPass/nice")
	public String findPassNice(HttpServletRequest request) throws Exception {
		SessionUtil.clearValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER);

		return "/member/findPassNice";
	}

	/**
	 * 비밀번호찾기 - 결과
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findPass/result")
	public String findPAssResult(Model model, HttpServletRequest request, @ModelAttribute NiceCertiVo niceCerti) throws Exception {
		Object objUserId = SessionUtil.getValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER);

		if (objUserId != null) {
			niceCerti.setUserId(objUserId.toString());

			NiceCertiVo resultCertiVo = memberService.selectMemberInfoByCerti(niceCerti);

			if (resultCertiVo != null) {
				model.addAttribute("findId", niceCerti.getUserId());
			}
		}

		return "/member/findPassResult";
	}

	/**
	 * 비밀번호찾기 - 이메일
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findPass/email", method = RequestMethod.GET)
	public String findPassEmail(HttpServletRequest request) throws Exception {
		SessionUtil.clearValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER);

		return "/member/findPassEmail";
	}

	/**
	 * 비밀번호찾기 - 결과
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findPass/email/result")
	public String findPAssEmailResult(Model model, HttpServletRequest request, @ModelAttribute NiceCertiVo niceCerti) throws Exception {
		SessionUtil.setValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER, niceCerti.getUserId());

		NiceCertiVo resultCertiVo = memberService.selectMemberInfoByCerti(niceCerti);

		if (resultCertiVo != null) {
			model.addAttribute("findId", niceCerti.getUserId());
		}

		return "/member/findPassResult";
	}

	/**
	 * 비밀번호 변경
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/changePass")
	public String changePass(Model model, HttpServletRequest request, @ModelAttribute ChangePassVo changePassVo) throws Exception {
		Object objUserId = SessionUtil.getValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER);

		int updCnt = 0;

		if (objUserId != null) {
			String userId = StringUtils.getString(objUserId);

			changePassVo.setUserId(userId);

			updCnt = memberService.updatePasswordInfo(changePassVo);
		}

		model.addAttribute("updCnt", updCnt);

		return "/member/changePassResult";
	}

	/**
	 * 비밀번호 변경
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/repass")
	public String repass(Model model, HttpServletRequest request) throws Exception {

		return "/member/repass";
	}

	/**
	 * 로그인 - 비밀번호 변경하기 - 결과
	 *
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/repass/proc")
	@ResponseBody
	public Map<String, String> repassProc(@LoginUser MemberDetails memberDetail, @ModelAttribute ChangePassVo changePassVo, @RequestParam(value="nowpassword", required=false) String nowpassword,  HttpServletRequest request) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "false");

		if((memberDetail.getUserid())!=null && (memberDetail.getUserid()).length()>0){

			String encodedPassword = null;
			// 비밀번호 암호화
			encodedPassword = memberService.selectEncryptString(nowpassword);

			System.out.println("encodedPassword :" + encodedPassword);

			if(encodedPassword!=null && (memberDetail.getPasswd()).equals(encodedPassword)){
				changePassVo.setUserId(memberDetail.getUserid());
				memberService.updatePasswordInfo(changePassVo);
				resultMap.put("result", "true");
			}
		}

		return resultMap;
	}

	/**
	 * 로그인 - 비밀번호 변경 1달 연장
	 *
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/repass/delay")
	@ResponseBody
	public Map<String, String> repassDelayProc(@LoginUser MemberDetails memberDetail, HttpServletRequest request) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "false");

		if((memberDetail.getUserid())!=null && (memberDetail.getUserid()).length()>0){
			memberService.updatePasswordDelay(memberDetail.getUserid());
			resultMap.put("result", "true");
		}

		return resultMap;
	}

	/**
	 * 회원 갱신
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/renew")
	public String renew(Model model, @RequestParam(value="active", required=false) String active, HttpServletRequest request) throws Exception {

		model.addAttribute("active", active);

		return "/member/renew";
	}

	/**
	 * 회원 갱신
	 *
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/renew/proc")
	@ResponseBody
	public Map<String, String> renewProc(@LoginUser MemberDetails memberDetail, @RequestParam(value="keyRenew", required=false) String keyRenew, @RequestParam(value="active", required=false) String active, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "false");

		if((memberDetail.getUserid())!=null && (memberDetail.getUserid()).length()>0){

			//동의 함
			if("01".equals(keyRenew)){
				memberService.updateRenew(memberDetail.getUserid());
				resultMap.put("result", "true");
			}else{
				OutMemberVo outMemberVo = new OutMemberVo();
				outMemberVo.setUserId(memberDetail.getUserid());
				outMemberVo.setUserName(memberDetail.getName());

				//휴먼계정
				if("Y".equals(active)){
					outMemberVo.setWithdrawalCategory("휴면계정활성화 거부 탈퇴");
					outMemberVo.setWithdrawalReason("휴면계정활성화 동의 안함");
				}else{
					outMemberVo.setWithdrawalCategory("회원갱신 거부 탈퇴");
					outMemberVo.setWithdrawalReason("회원갱신 동의 안함");
				}
				memberService.updateMemberByOutProc(outMemberVo);
				//로그아웃처리
				this.signOutProcess(request, response);
				resultMap.put("result", "true");
			}
		}


		return resultMap;
	}

	/**
	 * 회원 자동 탈퇴
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/autoout")
	public String autoout(@LoginUser MemberDetails memberDetail, HttpServletRequest request, HttpServletResponse response) throws Exception {

		OutMemberVo outMemberVo = new OutMemberVo();
		outMemberVo.setUserId(memberDetail.getUserid());
		outMemberVo.setUserName(memberDetail.getName());
		outMemberVo.setWithdrawalCategory("5년 경과 자동 탈퇴");
		outMemberVo.setWithdrawalReason("가입 후 5년 경과");

		memberService.updateMemberByOutProc(outMemberVo);
		//로그아웃처리
		this.signOutProcess(request, response);

		return "redirect:/main";
	}


	/**
	 * 회원가입
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/join")
	public String join(Model model, HttpServletRequest request) throws Exception {
		try {
			SessionUtil.clearValue(request, Constant.JOIN_MEMBER_HEADER);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return "/member/join";
	}

	/**
	 * 회원가입 - step1
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/join/step1")
	public String joinStep1(Model model, @RequestParam(value="joinType", required=true) String joinType, HttpServletRequest request) throws Exception {
		JoinMemberVo joinMemberVo = new JoinMemberVo();
		joinMemberVo.setJoinType(joinType);

		SessionUtil.setValue(request, Constant.JOIN_MEMBER_HEADER, joinMemberVo);
		model.addAttribute("joinMemberVo", joinMemberVo);

		if (joinType.equals(Constant.JOIN_TYPE_FOREIGN) == true) {
			return "/member/joinForeignStep1";
		}else {
			return "/member/joinStep1";
		}
	}

	/**
	 * 회원가입 - step2
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/join/step2")
	public String joinStep2(Model model, HttpServletRequest request, @ModelAttribute JoinMemberVo joinMemberVo, @ModelAttribute NiceCertiVo niceCertiVo) throws Exception {
		JoinMemberVo sessionJoinMemberVo = null;

		try {
			sessionJoinMemberVo = (JoinMemberVo)SessionUtil.getValue(request, Constant.JOIN_MEMBER_HEADER);

			sessionJoinMemberVo.setDupInfo(joinMemberVo.getDupInfo());
			sessionJoinMemberVo.setUserName(joinMemberVo.getUserName());
			sessionJoinMemberVo.setBirthDate(joinMemberVo.getBirthDate());
			sessionJoinMemberVo.setSexCode(joinMemberVo.getSexCode());


			//SessionUtil.setValue(request, Constant.JOIN_MEMBER_HEADER, sessionJoinMemberVo);
		}catch(Exception e) {
			return "redirect:/member/join";
		}

		//중복가입 여부 확인
		niceCertiVo.setFindType(Constant.FIND_TYPE_PERSON);
		niceCertiVo = memberService.selectMemberInfoByCerti(niceCertiVo);

		if (niceCertiVo != null) {
			SessionUtil.clearValue(request, Constant.JOIN_MEMBER_HEADER);
			SessionUtil.setErrorMsg(request, "이미 가입되어 있습니다. 로그인 해주세요.");
			return "redirect:/login";
		}

		model.addAttribute("joinMemberVo", sessionJoinMemberVo);

		if (sessionJoinMemberVo.getJoinType().equals(Constant.JOIN_TYPE_FOREIGN) == true) {
			return "/member/joinForeignStep2";
		}else {
			return "/member/joinStep2";
		}
	}

	/**
	 * 회원가입 - step3
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/join/step3")
	public String joinStep3(Model model, HttpServletRequest request) throws Exception {
		JoinMemberVo sessionJoinMemberVo = null;
		try {
			sessionJoinMemberVo = (JoinMemberVo)SessionUtil.getValue(request, Constant.JOIN_MEMBER_HEADER);

			model.addAttribute("joinMemberVo", sessionJoinMemberVo);
		}catch(Exception e) {
			return "redirect:/member/join";
		}

		return "/member/joinStep3";
	}

	/**
	 * 아이디 중복 체크
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/check/id/dup")
	@ResponseBody
	public Map<String, String> checkIdDup(@RequestParam(value="userId", required=true) String userId) throws Exception {
		int dupCount = memberService.selectUserIdDupCount(userId);

		Map<String, String> resultMap = new HashMap<String, String>();

		if (dupCount > 0) {
			resultMap.put("result", "true");
		}else {
			resultMap.put("result", "false");
		}

		return resultMap;
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
