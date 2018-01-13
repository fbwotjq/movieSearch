package egovframework.ag.homepage.nice.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import Kisinfo.Check.IPINClient;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.SessionUtil;

@Controller
@RequestMapping("/nice")
public class NiceController {

	@Value(value="${nice.callback.domain}")
	private String domain;//"http://localhost:8081";

	@Value(value="${nice.person.site.code}")
	private String personSiteCode;// = "G5181";

	@Value(value="${nice.person.pass.code}")
	private String personPassCode;// = "C4IB5FMAA1RA";

	@Value(value="${nice.ipin.site.code}")
	private String iPinSiteCode;// = "G5181";

	@Value(value="${nice.ipin.pass.code}")
	private String iPinPassCode;// = "C4IB5FMAA1RA";

	@Autowired
	private ObjectMapper objectMapper;

	/**
	 * 개인 안심 인증
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person")
	public String nicePersonCheck(Model model, HttpServletRequest request, @RequestParam(value="param_r1") String param1
																		, @RequestParam(value="param_r2") String param2
																		, @RequestParam(value="param_r3") String param3) throws Exception {
		String contextPath = request.getContextPath();

	    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sSiteCode = personSiteCode;					// NICE로부터 부여받은 사이트 코드
	    String sSitePassword = personPassCode;		// NICE로부터 부여받은 사이트 패스워드

	    String sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	    SessionUtil.setValue(request, Constant.NICE_CHECK_REQ_HEADER , sRequestNumber); // 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
	    SessionUtil.setValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER, param1);

	   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

	   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

	    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	    String sReturnUrl = this.domain + contextPath + "/nice/person/success";      // 성공시 이동될 URL
	    String sErrorUrl = this.domain + contextPath + "/nice/person/fail";          // 실패시 이동될 URL


	    // 입력될 plain 데이타를 만든다.
	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;

	    String sMessage = "";
	    String sEncData = "";

	    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	    if( iReturn == 0 )
	    {
	        sEncData = niceCheck.getCipherData();
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "암호화 시스템 에러입니다.";
	    }
	    else if( iReturn == -2)
	    {
	        sMessage = "암호화 처리오류입니다.";
	    }
	    else if( iReturn == -3)
	    {
	        sMessage = "암호화 데이터 오류입니다.";
	    }
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }

	    Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sRequestNumber", sRequestNumber);
		paramMap.put("sEncData", sEncData);
		paramMap.put("sMessage", sMessage);
		paramMap.put("param_r1", param1);
		paramMap.put("param_r2", param2);
		paramMap.put("param_r3", param3);

		model.addAttribute("paramMap", paramMap);

		return "/popLayoutType01/nice/person";
	}

	/**
	 * 개인 안심인증 성공
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/success", method=RequestMethod.POST)
	public String nicePersionSuccess(Model model, HttpServletRequest request, @RequestParam(value="EncodeData") String sEncodeData
													  						 , @RequestParam(value="param_r1") String param1
																			 , @RequestParam(value="param_r2") String param2
																			 , @RequestParam(value="param_r3") String param3) throws Exception {
	    String sSiteCode = personSiteCode;		// NICE로부터 부여받은 사이트 코드
	    String sSitePassword = personPassCode;	// NICE로부터 부여받은 사이트 패스워드

	    //String sCipherTime = "";				// 복호화한 시간
	    //String sRequestNumber = "";			 	// 요청 번호
	    //String sResponseNumber = "";		 	// 인증 고유번호
	    //String sAuthType = "";				   	// 인증 수단
	    String sDupInfo = "";					// 중복가입 확인값 (DI_64 byte)
	    String sName = "";						// 성명
	    String sBirthDate = "";					// 생일
	    String sGender = "";					// 성별
	    String sSex = "F";
	    //String sConnInfo = "";					// 연계정보 확인값 (CI_88 byte)

	    //String sNationalInfo = "";       		// 내/외국인정보 (개발가이드 참조)
	    //String sMessage = "";
	    //String sPlainData = "";


		int iReturn = 0;

		// CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
		String session_sRequestNumber = (String)SessionUtil.getValue(request, Constant.NICE_CHECK_REQ_HEADER);

		NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

		iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

		if (iReturn == 0) {
			String sPlainData = niceCheck.getPlainData();
			//sCipherTime = niceCheck.getCipherDateTime();

			// 데이타를 추출합니다.
			HashMap<?, ?> mapresult = niceCheck.fnParse(sPlainData);

			String sRequestNumber = (String) mapresult.get("REQ_SEQ");

			sDupInfo = (String) mapresult.get("DI");
			sName = (String) mapresult.get("NAME");
			sBirthDate = (String) mapresult.get("BIRTHDATE");
			sGender = (String) mapresult.get("GENDER");

			if (sGender != null && sGender.equals("1")) {
				sSex = "M";
			}


			//sResponseNumber = (String) mapresult.get("RES_SEQ");
			//sAuthType = (String) mapresult.get("AUTH_TYPE");
			//sNationalInfo = (String) mapresult.get("NATIONALINFO");
			//sConnInfo = (String) mapresult.get("CI");

			if (!sRequestNumber.equals(session_sRequestNumber)) {
				//sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
				//sResponseNumber = "";
				//sAuthType = "";
				return "redirect:/nice/person/fail";
			}
		}else {
			return "redirect:/nice/person/fail";
		}
		/*
		else if (iReturn == -1) {
			sMessage = "복호화 시스템 에러입니다.";
		} else if (iReturn == -4) {
			sMessage = "복호화 처리오류입니다.";
		} else if (iReturn == -5) {
			sMessage = "복호화 해쉬 오류입니다.";
		} else if (iReturn == -6) {
			sMessage = "복호화 데이터 오류입니다.";
		} else if (iReturn == -9) {
			sMessage = "입력 데이터 오류입니다.";
		} else if (iReturn == -12) {
			sMessage = "사이트 패스워드 오류입니다.";
		} else {
			sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		}
		*/


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dupInfo", sDupInfo);
		paramMap.put("userName", sName);
		paramMap.put("birthDate", sBirthDate);
		paramMap.put("sexCode", sSex);

		//paramMap.put("iReturn", iReturn);
		//paramMap.put("sMessage", sMessage);
		//paramMap.put("sCipherTime", sCipherTime);
		//paramMap.put("sRequestNumber", sRequestNumber);
		//paramMap.put("sResponseNumber", sResponseNumber);
		//paramMap.put("sAuthType", sAuthType);
		//paramMap.put("sConnInfo", sConnInfo);
		//paramMap.put("sNationalInfo", sNationalInfo);

		paramMap.put("param_r1", param1);
		paramMap.put("param_r2", param2);
		paramMap.put("param_r3", param3);


		String paramJson = new ObjectMapper().writeValueAsString(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("paramJson", paramJson);

		return "/popLayoutType01/nice/personResultSuccess";
	}

	/**
	 * 개인 안심인증 실패
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/fail", method=RequestMethod.POST)
	public String nicePersionFail() throws Exception {
		return "/popLayoutType01/nice/personResultFail";
	}



	/**
	 * iPin 인증
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/iPin")
	public String niceIpinCheck(Model model, HttpServletRequest request, @RequestParam(value="param_r1") String param1
																		, @RequestParam(value="param_r2") String param2
																		, @RequestParam(value="param_r3") String param3) throws Exception {

    	String contextPath = request.getContextPath();


		// 페이지 공통
		/********************************************************************************************************************************************
		 * NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS
		 * RESERVED
		 *
		 * 서비스명 : 가상주민번호서비스 (IPIN) 서비스 페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
		 *********************************************************************************************************************************************/

		/*
		 * ┌ sReturnURL 변수에 대한 설명
		 * ───────────────────────────────────────────────────── NICE평가정보 팝업에서
		 * 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다. 따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		 *
		 * URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다. 당사에서 배포해드린 샘플페이지 중,
		 * ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		 *
		 * 아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다. 예 -
		 * http://www.test.co.kr/ipin_process.jsp,
		 * https://www.test.co.kr/ipin_process.jsp,
		 * https://test.co.kr/ipin_process.jsp
		 * └────────────────────────────────────────────────────────────────────
		 */
		String sReturnURL = this.domain + contextPath + "/nice/ipin/result";

		/*
		 * ┌ sCPRequest 변수에 대한 설명
		 * ───────────────────────────────────────────────────── [CP 요청번호]로 귀사에서
		 * 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
		 *
		 * CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며 데이타 위변조 방지 및 특정 사용자가 요청한 것임을
		 * 확인하기 위한 목적으로 이용하실 수 있습니다.
		 *
		 * 따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
		 * └────────────────────────────────────────────────────────────────────
		 */

		// 객체 생성
		IPINClient pClient = new IPINClient();

		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
		String sCPRequest = pClient.getRequestNO(iPinSiteCode);

		// CP 요청번호를 세션에 저장합니다.
		// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
		// 필수사항은 아니며, 보안을 위한 권고사항입니다.
		SessionUtil.setValue(request, Constant.NICE_CHECK_REQ_HEADER, sCPRequest);
		SessionUtil.setValue(request, Constant.PASS_CHANGE_USER_ID_REQ_HEADER, param1);

		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		int iRtn = pClient.fnRequest(iPinSiteCode, iPinPassCode, sCPRequest, sReturnURL);

		String sRtnMsg = ""; // 처리결과 메세지
		String sEncData = ""; // 암호화 된 데이타

		// Method 결과값에 따른 처리사항
		if (iRtn == 0) {
			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
			sEncData = pClient.getCipherData(); // 암호화 된 데이타
			sRtnMsg = "정상 처리되었습니다.";
		} else if (iRtn == -1 || iRtn == -2) {
			sRtnMsg = "배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>"
					+ "귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		} else if (iRtn == -9) {
			sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		} else {
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("sRtnMsg", sRtnMsg);
		paramMap.put("sEncData", sEncData);
		paramMap.put("sCPRequest", sCPRequest);
		paramMap.put("param_r1", param1);
		paramMap.put("param_r2", param2);
		paramMap.put("param_r3", param3);

		model.addAttribute("paramMap", paramMap);

		return "/popLayoutType01/nice/ipin";
	}

	/**
	 * ipin 인증 결과
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/ipin/result")
	public String ipnResult(Model model, HttpServletRequest request, @RequestParam(value="enc_data") String sEncodeData
																	, @RequestParam(value="param_r1") String param1
																    , @RequestParam(value="param_r2") String param2
																    , @RequestParam(value="param_r3") String param3) throws Exception {
		String sCPRequest = (String)SessionUtil.getValue(request, Constant.NICE_CHECK_REQ_HEADER);

		// 객체 생성
		IPINClient pClient = new IPINClient();

		/*
		 * ┌ 복호화 함수 설명
		 * ────────────────────────────────────────────────────────── Method
		 * 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		 *
		 * fnResponse 함수는 결과 데이타를 복호화 하는 함수이며, 'sCPRequest'값을 추가로 보내시면 CP요청번호
		 * 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)
		 *
		 * 따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
		 * └────────────────────────────────────────────────────────────────────
		 */
		// iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
		int iRtn = pClient.fnResponse(iPinSiteCode, iPinPassCode, sEncodeData, sCPRequest);

	    String sDupInfo = "";					// 중복가입 확인값 (DI_64 byte)
	    String sName = "";						// 성명
	    String sBirthDate = "";					// 생일
	    String sGender = "";					// 성별
	    String sSex = "F";

		// Method 결과값에 따른 처리사항
		if (iRtn == 1) {
			sDupInfo = pClient.getDupInfo();//중복가입 확인값 (DI - 64 byte 고유값)
			sName = pClient.getName(); // 이름
			sBirthDate = pClient.getBirthDate();		// 생년월일 (YYYYMMDD)
			sGender = pClient.getGenderCode();		// 성별 코드 (개발 가이드 참조)

			if(sGender != null && sGender.equals("1")){
				sSex = "M";
			}
		}
		/*else if (iRtn == -1 || iRtn == -4) {
			sRtnMsg = "iRtn 값, 서버 환경정보를 정확히 확인하여 주시기 바랍니다.";
		} else if (iRtn == -6) {
			sRtnMsg = "당사는 한글 charset 정보를 euc-kr 로 처리하고 있으니, euc-kr 에 대해서 허용해 주시기 바랍니다.<BR>"
					+ "한글 charset 정보가 명확하다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		} else if (iRtn == -9) {
			sRtnMsg = "입력값 오류 : fnResponse 함수 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		} else if (iRtn == -12) {
			sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
		} else if (iRtn == -13) {
			sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
		} else {
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 전산 담당자에게 문의해 주세요.";
		}
		*/

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dupInfo", sDupInfo);
		paramMap.put("userName", sName);
		paramMap.put("birthDate", sBirthDate);
		paramMap.put("sexCode", sSex);

		paramMap.put("param_r1", param1);
		paramMap.put("param_r2", param2);
		paramMap.put("param_r3", param3);


		String paramJson = new ObjectMapper().writeValueAsString(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("paramJson", paramJson);

		return "/popLayoutType01/nice/iPinResultSuccess";
	}

	@RequestMapping("/pop/test")
	public String testPop(Model model) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dupInfo", "듑인포");
		paramMap.put("userName", "유저네임");
		paramMap.put("birthDate", "태어난날");
		paramMap.put("sexCode", "M");

		String paramJson = new ObjectMapper().writeValueAsString(paramMap);

		model.addAttribute("paramJson", paramJson);

		return "/popLayoutType01/nice/iPinResultSuccess";
	}
}
