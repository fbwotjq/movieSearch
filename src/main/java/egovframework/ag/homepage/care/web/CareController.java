package egovframework.ag.homepage.care.web;

import java.security.Principal;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.care.service.CareService;
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.common.service.PayService;
import egovframework.ag.homepage.vod.service.VodService;

@Controller
@RequestMapping("/care")
public class CareController {
	private final Logger logger = LogManager.getLogger();

	@Autowired
	private CareService careService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private VodService vodService;

	@Autowired
	private PayService payService;

	@Value(value="${active.type}")
	private String activeType;

	@RequestMapping("/kmdb")
	public String selectKmdb(Model model) throws Exception {

		return  "/care/kmdb";
	}

	@RequestMapping("/vod/guide")
	public String selectGuideList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		PageListVo<Map<String,Object>> pageListVo = careService.selectGuideList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return  "/care/vod/guide";
	}

	@RequestMapping("/vod/guide/{seq}")
	public String selectGuideInfo(@PathVariable long seq, ParamMap paramMap, Model model) throws Exception {

		Map<String, Object> detailInfo = careService.selectGuideInfo(seq);

		if(detailInfo != null && detailInfo.size() > 0){
			//편집기 태그 정리
			detailInfo.put("contents",StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contents"))));
		}

		model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("detailInfo", detailInfo);

		return  "/care/vod/guideView";
	}

	@RequestMapping("/vod/license")
	public String selectLicense(HttpServletRequest request, Model model) throws Exception {

		return  "/care/vod/license";
	}
	@RequestMapping("/vod/pay")
	public String selectPay(HttpServletRequest request, Model model) throws Exception {

		return  "/care/vod/pay";
	}

	@RequestMapping("/vod/pay/pop")
	public String selectPayPop(HttpServletRequest request, Model model, @RequestParam Map<String, Object> param) throws Exception {

		String payCheck = StringUtils.defaultString(param.get("payCheck"),"");
		String userId = "";
		String movieId = "";
		String movieSeq = "";
		Authentication auth = (Authentication) request.getUserPrincipal();
		MemberDetails userDetails = null;
		if(auth != null) {
			userDetails = (MemberDetails) auth.getPrincipal();
			userId = userDetails.getUserid();
			logger.debug("******************************************************");
			logger.debug(userDetails.toString());
			logger.debug("******************************************************");
		}

		String mTitle = "";
		String pay_type = "";
		int servicePrice = 0;

		if("".equals(payCheck) || "0".equals(payCheck)){
			Map<String, Object> resultMap = vodService.selectVodCart(param);
			if(resultMap == null){
				throw new Exception("결제가능한 컨텐츠가 없습니다.");
			}
			servicePrice = Integer.valueOf((String)resultMap.get("price"));
			mTitle = "24시간 이용권(1편 - "+String.valueOf(resultMap.get("movieTitle"))+")";
			pay_type = "0";
			movieId = (String)resultMap.get("movieId");
			movieSeq = (String)resultMap.get("movieSeq");
		}else{
			if("1".equals(payCheck)){
				mTitle="VOD이용 편수 무제한(14일)";
				servicePrice = 5000;
				pay_type="0";
			}else if("2".equals(payCheck)){
				mTitle="VOD이용 편수 무제한(30일)";
				servicePrice = 10000;
				pay_type="0";
			}else if("3".equals(payCheck)){
				mTitle="선불제 5000원권";
				servicePrice = 5000;
				pay_type="4";
			}else if("4".equals(payCheck)){
				mTitle="선불제 10000원권";
				servicePrice = 10000;
				pay_type="4";
			}
		}

		//servicePrice = 1100;

		HttpSession se = request.getSession(true);
        se.setAttribute("servicePrice", String.valueOf(servicePrice));
        se.setAttribute("mTitle", mTitle);
        se.setAttribute("pay_type", pay_type);

		model.addAttribute("movieID", "kmdbVOD");
		model.addAttribute("goodname", "kmdbVOD");
		model.addAttribute("pay_type", pay_type);

		//model.addAttribute("sMovieTitleStringKorean", mTitle);
		//model.addAttribute("price", servicePrice);
		//model.addAttribute("selGoodsName", mTitle);
		//model.addAttribute("mTitle", mTitle);

		payService.setPayInfo(model, String.valueOf(servicePrice), mTitle);

		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("type", "vod");
		hm.put("value", userId);
		if(!"".equals(movieId)){
			hm.put("movieId", movieId);
		}
		if(!"".equals(movieSeq)){
			hm.put("movieSeq", movieSeq);
		}
		ObjectMapper mapper = new ObjectMapper();
		String merchantData = mapper.writeValueAsString(hm);
        byte[] bytes = merchantData.getBytes();
        String base64Encoded = DatatypeConverter.printBase64Binary(bytes);
		model.addAttribute("merchantData", base64Encoded);

		model.addAttribute("activeType",activeType);

		return  "/pop/care/vod/inicisForm";
	}

	@RequestMapping("/vod/pay/return")
	public String selectPayReturn(HttpServletRequest request, Model model) throws Exception {

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
				String sPay_type = (String)se.getAttribute("pay_type");
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
						//merchantData 형식은 type=company|vod&value=seq|userId
						Map<String, Object> map = new HashMap<String, Object>();
						if(merchantData != null && !"".equals(merchantData)){
							byte[] base64Decoded = DatatypeConverter.parseBase64Binary(merchantData);
							merchantData = new String(base64Decoded);
							ObjectMapper mapper = new ObjectMapper();
							map = mapper.readValue(merchantData, new TypeReference<Map<String, Object>>(){});

							if("company".equals(StringUtils.defaultString(map.get("type"),""))){
								userId = "company";
								if("VBank".equals(resultMap.get("payMethod"))){
									sPay_type = "2";
								}else{
									sPay_type = "0";
								}
							}
						}

						//DB 결재정보 INSERT
						if("4".equals(sPay_type) && "10000".equals(price)){
							price = "10500";
						}
						resultMap.put("userId", userId);
						resultMap.put("sMovieTitleStringKorean", mTitle);
						resultMap.put("sPay_type", sPay_type);
						resultMap.put("resultPrice", price);
						resultMap.put("sPaySuccess", "1");
						resultMap.put("resultMsg", "성공("+resultMap.get("payMethod")+")");
						resultMap.put("NoHPP", "");
						resultMap.put("DirectBankCode", "");
						resultMap.put("RCash_rslt", "");
						resultMap.put("ResultCashNoApp1", "");
						resultMap.put("AuthCode", "");
						resultMap.put("CardIssuerCode", "");

						//기관결제일때
						if("company".equals(map.get("type"))){
							resultMap.put("companyYn", "Y");
							resultMap.put("seq", StringUtils.defaultString(map.get("value"),""));
						}

						//장바구니 체크
						map.put("userId", userId);
						Map<String, Object> resultMap2 = vodService.selectVodCart(map);
						if(resultMap2 == null){
							resultMap.put("mulId", "1");
							resultMap.put("fileId", "1");
							resultMap.put("movieId", "1");
							resultMap.put("movieSeq", "1");
							resultMap.put("movieTitle", "1");
						}else{
							resultMap.put("mulId", String.valueOf(resultMap2.get("mulId")));
							resultMap.put("fileId", String.valueOf(resultMap2.get("fileId")));
							resultMap.put("movieId", String.valueOf(resultMap2.get("movieId")));
							resultMap.put("movieSeq", String.valueOf(resultMap2.get("movieSeq")));
							resultMap.put("movieTitle", String.valueOf(resultMap2.get("movieTitle")));
							resultMap.put("cartYn", "Y");
						}
						careService.insertPayResult(resultMap);

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
					//returnViewMap.put("resultMsg", resultMap.get("resultMsg"));
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

		return "/pop/care/vod/inicisReturn";
	}

	@RequestMapping("/vod/pay/close")
	public String selectPayClose(HttpServletRequest request, Model model) throws Exception {
		return "/pop/care/vod/inicisClose";
	}

	@RequestMapping("/vod/company/pay")
	public String selectCompanyPay(@RequestParam("seq")long seq,  @RequestParam("authcode")String authcode, HttpServletRequest request, Model model) throws Exception {

		Map<String, Object> result = careService.selectVodCompany(seq);

		if("Y".equals(result.get("result"))){

			String servicePrice = String.valueOf(result.get("cprice"));

			HttpSession se = request.getSession(true);
	        se.setAttribute("servicePrice", servicePrice);
	        se.setAttribute("mTitle", result.get("strType"));
	        se.setAttribute("pay_type", "");
	        se.setAttribute("seq", ""+seq);

			payService.setPayInfo(model, servicePrice, (String)result.get("strType"));

			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("type", "company");
			hm.put("value", ""+seq);
			ObjectMapper mapper = new ObjectMapper();
			String merchantData = mapper.writeValueAsString(hm);
	        byte[] bytes = merchantData.getBytes();
	        String base64Encoded = DatatypeConverter.printBase64Binary(bytes);
			model.addAttribute("merchantData", base64Encoded);

		}
		model.addAttribute("result", result);
		model.addAttribute("activeType",activeType);

		return  "/pop/care/vod/companyForm";
	}

	@RequestMapping("/online/movieman")
	public String insertMoviemanForm(HttpServletRequest request, Model model) throws Exception {

		return  "/care/online/movieman";
	}

	@RequestMapping("/online/movieman/proc")
	@ResponseBody
	public Map<String, String> insertMovieman(@RequestParam Map<String, String> param, HttpServletRequest request, Model model) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null){
				MemberDetails userDetails = (MemberDetails) auth.getPrincipal();
				if(userDetails != null) {
					param.put("userId", userDetails.getUserid());
				}
			}

			careService.insertMovieman(param);
		} catch (Exception e) {
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	@RequestMapping("/online/ask")
	public String insertAskForm(@RequestParam(value="privateType", defaultValue = "") String privateType,  ParamMap paramMap,HttpServletRequest request, Model model, Principal principal) throws Exception {

		HashMap<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("codeGroupId", "C105");

		if (principal!=null) {

        	MemberDetails member = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    		String userName = member.getName();
    		paramMap.put("userName", userName);
        }else{
        	paramMap.put("userName", "");
        }

		model.addAttribute("privateTypeList", commonService.selectSearchCodeList(keyMap));
    	paramMap.put("privateType", privateType);
        model.addAttribute("paramMap", paramMap.getMap());
		return  "/care/online/ask";
	}

	@RequestMapping("/online/ask/proc")
	@ResponseBody
	public Map<String, String> insertAsk(@RequestParam Map<String, String> param, HttpServletRequest request, Model model, Principal principal) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", "true");
		try {

			param.put("createIp", request.getRemoteAddr());
			param.put("privatePassword", "");

            if (principal!=null) {

            	MemberDetails member = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        		String userId = member.getUserid();
        		String userMail= member.getMailaddr();
        		param.put("userName", userId);
        		param.put("userMail", userMail);
            }else{
            	param.put("userName", param.get("createName"));
        		param.put("userMail", "");
            }

			careService.insertAsk(param);
		} catch (Exception e) {
			resultMap.put("result", "false");
		}

		return resultMap;
	}

	@RequestMapping("/online/faq")
	public String selectFaq(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		PageListVo<Map<String,Object>> pageListVo = careService.selectFaqList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return  "/care/online/faq";
	}

}
