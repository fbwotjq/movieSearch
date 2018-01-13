package egovframework.ag.homepage.common.service;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import egovframework.ag.common.security.MemberDetails;

@Service
public class PayService {

	private final static Logger logger = LogManager.getLogger();

	@Value("${inipay.mid}")
	private String inipayMid;

	@Value("${inipay.signKey}")
	private String inipaySignKey;

	@Value("${inipay.card.policy}")
	private String inipayCard;

	@Value("${inipay.card.month}")
	private String inipayMonth;

	@Value("${inipay.siteDomain}")
	private String inipaySiteDomain;

	@Value("${inipay.siteDomain.return}")
	private String inipayReturnUrl;

	@Value("${inipay.siteDomain.close}")
	private String inipayCloseUrl;

	@Value("${inipay.siteDomain.popup}")
	private String inipayPopupUrl;

	@Value("${inipay.pay.method}")
	private String inipayPayMethod;


	public void setPayInfo(Model model, String servicePrice, String goodName) throws Exception {
		setPayInfo(model, servicePrice, goodName, inipayReturnUrl);
	}

	public void setPayInfo(Model model, String servicePrice, String goodName, String returnUrl) throws Exception {

		logger.debug("===PAY INFO SET===");

		if(!inipayReturnUrl.equals(returnUrl)){
			returnUrl = inipaySiteDomain + returnUrl;
		}

		model.addAttribute("sMovieTitleStringKorean", goodName);
		model.addAttribute("mTitle", goodName);
		model.addAttribute("selGoodsName", goodName);
		model.addAttribute("price", servicePrice);
		model.addAttribute("servicePrice", servicePrice);

		String timestamp			= SignatureUtil.getTimestamp();			// util에 의해서 자동생성
		String oid					= inipayMid+"_"+SignatureUtil.getTimestamp();	// 가맹점 주문번호(가맹점에서 직접 설정)

		//###############################################
		// 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
		//###############################################
		String mKey = SignatureUtil.hash(inipaySignKey, "SHA-256");

		//###############################################
		// 2.signature 생성
		//###############################################
		Map<String, String> signParam = new HashMap<String, String>();

		signParam.put("oid",		oid); 							// 필수
		signParam.put("price",   String.valueOf(servicePrice));							// 필수
		signParam.put("timestamp",	timestamp);		// 필수

		// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
		String signature = SignatureUtil.makeSignature(signParam);

		model.addAttribute("inipayMid", inipayMid); // 가맹점 ID(가맹점 수정후 고정)
		model.addAttribute("timestamp", timestamp);
		model.addAttribute("oid", oid);
		model.addAttribute("inipayCard", inipayCard);
		model.addAttribute("inipayMonth", inipayMonth);
		model.addAttribute("mKey", mKey);
		model.addAttribute("signature", signature);
		model.addAttribute("inipayReturnUrl", returnUrl);
		model.addAttribute("inipayCloseUrl", inipayCloseUrl);
		model.addAttribute("inipayPopupUrl", inipayPopupUrl);
		model.addAttribute("inipayPayMethod", inipayPayMethod);

	}

}
