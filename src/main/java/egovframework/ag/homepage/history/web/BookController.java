package egovframework.ag.homepage.history.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import egovframework.ag.common.Constant;
import egovframework.ag.common.annotation.LoginUser;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.common.service.PayService;
import egovframework.ag.homepage.history.service.ArchivesMasterVo;
import egovframework.ag.homepage.history.service.HistoryService;

@Controller
@RequestMapping("/history/book")
public class BookController {
	private final Logger logger = LogManager.getLogger();

	private final String CODE_ID = "C113";
	private final String SUB_CODE_ID = "C114";
	private final String FILE_TYPE_CD = "40";//도서

	@Autowired
	private CommonService commonService;

	@Autowired
	private HistoryService historyService;

	@Autowired
	private PayService payService;

	@Value(value="${active.type}")
	private String activeType;

	/**
	 * 도서 목록 조회
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("")
	public String bookList(@LoginUser MemberDetails memberDetail, ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		paramMap.put("codeGroupId", CODE_ID);

		List<Map<String, Object>> codeList = commonService.selectCodeTreeList(paramMap.getMap());

		//구술채록문 구분 code01 : 10 국문, 20 영문
		String code01 = paramMap.getString("code01");
		String code02 = paramMap.getString("code02");
		String year = paramMap.getString("year");

		if("".equals(code01)){
			paramMap.put("code01", "10");
			paramMap.put("code02", "");
		}

		if ("".equals(code02) == false) {
			List<Map<String, Object>> yearList = historyService.selectArchivesSubCodeYearList(Constant.ARCHIVE_BOOK_CODE, code01, code02);

			if (yearList != null && yearList.size() > 0 && StringUtils.isEmpty(year) == true ) {
				paramMap.put("year", StringUtils.getString(yearList.get(0).get("year")));
			}

			model.addAttribute("yearList", yearList);
		}


		paramMap.put("archivesTypeCd", Constant.ARCHIVE_BOOK_CODE);
		paramMap.put("fileTypeCd", FILE_TYPE_CD);


		String loginUserId = "";

		try {
			loginUserId = memberDetail.getUserid();
		}catch(Exception e) {
			loginUserId = "";
		}


		PageListVo<ArchivesMasterVo> pageListVo = historyService.selectArchivesList(paramMap.getMap(), codeList, loginUserId);


        model.addAttribute("paramMap", paramMap.getMap());

		model.addAttribute("code01List", commonService.selectSearchCodeList(CODE_ID));
		model.addAttribute("code02List", commonService.selectSearchCodeList(SUB_CODE_ID));
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return "/history/bookList";
	}


	/**
	 * 도서 상세 조회
	 * @param archivesSeq
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{archivesSeq}")
	public String bookDetail(@LoginUser MemberDetails memberDetail, @PathVariable Long archivesSeq, ParamMap paramMap, Model model) throws Exception {
		paramMap.put("codeGroupId", CODE_ID);

		List<Map<String, Object>> codeList = commonService.selectCodeTreeList(paramMap.getMap());

		String loginUserId = "";

		try {
			loginUserId = memberDetail.getUserid();
		}catch(Exception e) {
			loginUserId = "";
		}


		Map<String, Object> masterInfo = historyService.selectArchivesMasterInfo(archivesSeq, codeList);

		Long fileSeq = StringUtils.getLong(masterInfo.get("fileSeq"));

		model.addAttribute("masterInfo", masterInfo);
		model.addAttribute("contentList", historyService.selectArchivesContentList(archivesSeq));
		model.addAttribute("masterFileInfo", historyService.selectArchivesFileInfo(fileSeq, FILE_TYPE_CD, loginUserId));

		model.addAttribute("paramMap", paramMap.getMap());

		return  "/history/bookDetail";
	}

	/**
	 * 도서 결재
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pay/{archivesSeq}/{fileSeq}/{fileOrder}")
	public String bookPay(HttpServletRequest request, @PathVariable Long archivesSeq, @PathVariable Long fileSeq, @PathVariable Long fileOrder, ParamMap paramMap, Model model) throws Exception {

		paramMap.put("archivesSeq", archivesSeq);
		paramMap.put("fileSeq", fileSeq);
		paramMap.put("fileOrder", fileOrder);

		Map<String, Object> payInfo = historyService.selectPayInfo(paramMap.getMap());

		HttpSession se = request.getSession(true);
        se.setAttribute("servicePrice", String.valueOf(payInfo.get("amount")));
        se.setAttribute("mTitle",  String.valueOf(payInfo.get("subject")));

		payService.setPayInfo(model, String.valueOf(payInfo.get("amount")), String.valueOf(payInfo.get("subject")), "/history/book/pay/return");
		model.addAttribute("paramMap", paramMap.getMap());

		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("archivesSeq", String.valueOf(archivesSeq));
		hm.put("fileSeq", String.valueOf(fileSeq));
		hm.put("fileOrder", String.valueOf(fileOrder));
		ObjectMapper mapper = new ObjectMapper();
		String merchantData = mapper.writeValueAsString(hm);
        byte[] bytes = merchantData.getBytes();
        String base64Encoded = DatatypeConverter.printBase64Binary(bytes);
		model.addAttribute("merchantData", base64Encoded);

		model.addAttribute("activeType",activeType);
		return  "/pop/pay/inicisPayPop";
	}

	/**
	 * 도서 결재 결과
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pay/return")
	public String bookPayReturn(HttpServletRequest request, Model model) throws Exception {

		Authentication auth = (Authentication) request.getUserPrincipal();
		MemberDetails userDetails = null;
		if(auth != null) {
			userDetails = (MemberDetails) auth.getPrincipal();
			logger.debug("******************************************************");
			logger.debug(userDetails.toString());
			logger.debug("******************************************************");
		}
		HttpSession se = request.getSession(true);

		// 0:성공, 1:실패, 2:인증실패, 3:결제승인실패, 4:데이터 위변조 체크 실패, 5:결제실패
		String returnCode = "";

		HashMap<String, String> returnViewMap = new HashMap<String, String>();

		try{

			//#############################
			// 인증결과 파라미터 일괄 수신
			//#############################
			request.setCharacterEncoding("UTF-8");

			Map<String,String> paramMap = new Hashtable<String,String>();

			Enumeration<String> elems = request.getParameterNames();

			String temp = "";

			while(elems.hasMoreElements())
			{
				temp = (String) elems.nextElement();
				paramMap.put(temp, request.getParameter(temp));
			}

			logger.debug("paramMap : "+ paramMap.toString());

			//#####################
			// 인증이 성공일 경우만
			//#####################
			if("0000".equals(paramMap.get("resultCode"))){

				logger.debug("####인증성공/승인요청####");

				//############################################
				// 1.전문 필드 값 설정(***가맹점 개발수정***)
				//############################################

				String mid 		= paramMap.get("mid");					        	// 가맹점 ID 수신 받은 데이터로 설정

				//String signKey	= inipaySignKey;	// 가맹점에 제공된 키(이니라이트키) (가맹점 수정후 고정) !!!절대!! 전문 데이터로 설정금지

				String timestamp= SignatureUtil.getTimestamp();				// util에 의해서 자동생성

				String charset 	= "UTF-8";								            	// 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)

				String format 	= "JSON";								              	// 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)

				String authToken= paramMap.get("authToken");			    	// 취소 요청 tid에 따라서 유동적(가맹점 수정후 고정)

				String authUrl	= paramMap.get("authUrl");				    	// 승인요청 API url(수신 받은 값으로 설정, 임의 세팅 금지)

				String netCancel= paramMap.get("netCancelUrl");			  	// 망취소 API url(수신 받은 값으로 설정, 임의 세팅 금지)

				//String ackUrl = paramMap.get("checkAckUrl");			    	// 가맹점 내부 로직 처리후 최종 확인 API URL(수신 받은 값으로 설정, 임의 세팅 금지)

				//String cardnum = paramMap.get("cardnum");				      	//갤러리아 카드번호(카드끝자리 '*' 처리) 2016-01-12

				String merchantData = paramMap.get("merchantData");		//가맹점 관리 데이터
				//#####################
				// 2.signature 생성
				//#####################
				Map<String, String> signParam = new HashMap<String, String>();

				signParam.put("authToken",	authToken);		// 필수
				signParam.put("timestamp",	timestamp);		// 필수

				// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
				String signature = SignatureUtil.makeSignature(signParam);
				String price = (String)se.getAttribute("servicePrice");  // 가맹점에서 최종 결제 가격 표기 (필수입력아님)
				String mTitle = (String)se.getAttribute("mTitle");

				logger.debug("세션 가격 : " + price);
				//#####################
				// 3.API 요청 전문 생성
				//#####################
				Map<String, String> authMap = new Hashtable<String, String>();

				authMap.put("mid"			    ,mid);			 	 // 필수
				authMap.put("authToken"		,authToken);	// 필수
				authMap.put("signature"		,signature);		// 필수
				authMap.put("timestamp"		,timestamp);	// 필수
				authMap.put("charset"		  	,charset);		// default=UTF-8
				authMap.put("format"		  	,format);		// default=XML
				authMap.put("price" 				,price);		    // 가격위변조체크기능 (선택사용)

				se.removeAttribute("servicePrice");
				se.removeAttribute("pay_type");
				se.removeAttribute("mTitle");

				logger.debug("##승인요청 API 요청##");

				HttpUtil httpUtil = new HttpUtil();

				try{
					//#####################
					// 4.API 통신 시작
					//#####################

					String authResultString = "";

					authResultString = httpUtil.processHTTP(authMap, authUrl);

					//############################################################
					//5.API 통신결과 처리(***가맹점 개발수정***)
					//############################################################

					logger.debug("## 승인 API 결과 ##");

					String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");
					Map<String, String> resultMap = new HashMap<String, String>();
					resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱

					logger.debug("resultMap == " + resultMap);

					/*************************  결제보안 강화 2016-05-18 START ****************************/
					Map<String , String> secureMap = new HashMap<String, String>();
					secureMap.put("mid"				, mid);								//mid
					secureMap.put("tstamp"		, timestamp);						//timestemp
					secureMap.put("MOID"			, resultMap.get("MOID"));			//MOID
					secureMap.put("TotPrice"		, resultMap.get("TotPrice"));		//TotPrice

					// signature 데이터 생성
					String secureSignature = SignatureUtil.makeSignatureAuth(secureMap);
					/*************************  결제보안 강화 2016-05-18 END ****************************/

					if("0000".equals(resultMap.get("resultCode")) && secureSignature.equals(resultMap.get("authSignature")) ){	//결제보안 강화 2016-05-18
					   /*****************************************************************************
				       * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.

						 [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함
								  처리중 에러 발생시 망취소를 한다.
				       ******************************************************************************/


						String userId = "";
						if(userDetails != null && userDetails.getUserid() != null && !"".equals(userDetails.getUserid())){
							userId = userDetails.getUserid();
						}

						//merchantData 형식은 archivesSeq=number&fileSeq=number&fileOrder=number
						Map<String, String> map = new HashMap<String, String>();
						if(merchantData != null && !"".equals(merchantData)){
							byte[] base64Decoded = DatatypeConverter.parseBase64Binary(merchantData);
							merchantData = new String(base64Decoded);
							ObjectMapper mapper = new ObjectMapper();
							map = mapper.readValue(merchantData, new TypeReference<Map<String, String>>(){});

							resultMap.put("archivesSeq", map.get("archivesSeq"));
							resultMap.put("fileSeq", map.get("fileSeq"));
							resultMap.put("fileOrder", map.get("fileOrder"));
						}


						resultMap.put("userId", userId);
						resultMap.put("sMovieTitleStringKorean", mTitle);
						resultMap.put("resultPrice", price);
						resultMap.put("sPaySuccess", "1");
						resultMap.put("resultMsg", "성공("+resultMap.get("payMethod")+")");
						resultMap.put("NoHPP", "");
						resultMap.put("DirectBankCode", "");
						resultMap.put("RCash_rslt", "");
						resultMap.put("ResultCashNoApp1", "");
						resultMap.put("AuthCode", "");
						resultMap.put("CardIssuerCode", "");

						//결재정보 DB 입력
						historyService.insertPayResult(resultMap);

					} else {
						//결제 승인 실패
						returnCode = "3";

						//결제보안키가 다른 경우
						if (!secureSignature.equals(resultMap.get("authSignature"))) {
							returnCode = "4"; //데이터 위변조 체크 실패
						}

						throw new Exception("데이터 위변조 체크 실패");
					}
					returnCode = "0";

					returnViewMap.put("resultMsg", "성공 ("+resultMap.get("payMethod")+")");
					returnViewMap.put("tid", resultMap.get("tid"));
					returnViewMap.put("payMethod", resultMap.get("payMethod"));
					returnViewMap.put("resultCode", resultMap.get("resultCode"));
					returnViewMap.put("totPrice", resultMap.get("TotPrice"));
					returnViewMap.put("moid", resultMap.get("MOID"));
					returnViewMap.put("applDate", resultMap.get("applDate"));
					returnViewMap.put("applTime", resultMap.get("applTime"));


				} catch (Exception ex) {

					if("".equals(returnCode)){
						returnCode = "5";
					}
					returnViewMap.put("resultMsg", "실패");

					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################

					//---- db 저장 실패시 등 예외처리----//
					logger.debug(ex);

					//#####################
					// 망취소 API
					//#####################
					String netcancelResultString = httpUtil.processHTTP(authMap, netCancel);	// 망취소 요청 API url(고정, 임의 세팅 금지)

					logger.debug("## 망취소 API 결과 ##");
					logger.debug("<p>"+netcancelResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</p>");
				}

			}else{
				returnCode = "2";
				returnViewMap.put("resultMsg", "실패");
				//#############
				// 인증 실패시
				//#############
				logger.debug("####인증실패####");
				logger.debug("<p>"+paramMap.toString()+"</p>");
			}

		}catch(Exception e){
			logger.debug(e);
			returnCode = "1";
			returnViewMap.put("resultMsg", "실패");
		}
		model.addAttribute("returnCode", returnCode);
		model.addAttribute("returnMap", returnViewMap);
		model.addAttribute("refreshYn", "Y");

		return  "/pop/pay/inicisReturnPop";
	}

}
