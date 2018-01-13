package egovframework.ag.homepage.care.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.homepage.common.service.CommonKfDao;
import egovframework.ag.homepage.common.service.MailService;

@Service
public class CareService {

	@Autowired
	private CareDao careDao;

	@Autowired
	private CommonKfDao commonKfDao;

	@Autowired
	private MailService mailService;
	/**
	 * 이용안내 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<Map<String,Object>> selectGuideList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String,Object>>(careDao.selectGuideListCount(paramMap), careDao.selectGuidePageList(paramMap));

	}

	/**
	 * 이용안내 상세
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectGuideInfo(long seq) throws Exception {
		careDao.updateGuideCount(seq);
		return careDao.selectGuideInfo(seq);
	}

	public void insertPayResult(Map<String, String> param) throws Exception{

		careDao.insertPayResult(param);
		if("Y".equals(param.get("companyYn"))){
			careDao.updateCompanyPay(param);
		}

		//카트에 정보가 있으면 삭제한다. -결재완료가 되었으므로 삭제
		if("Y".equals(param.get("cartYn"))){
			careDao.deleteVodCart(param);
		}

	}

	public int insertMovieman(Map<String, String> param) throws Exception {
		String arcomtent= "한자 : <b>"+ StringUtils.defaultString(param.get("arnameC"), "") +"</b><br />";
				arcomtent = arcomtent +"영문 : <b>"+ StringUtils.defaultString(param.get("arnameE"), "") +"</b><br />";
				arcomtent = arcomtent +"본명 : <b>"+ StringUtils.defaultString(param.get("arnameR"), "") +"</b><br />";
				arcomtent = arcomtent +"본명한자 : <b>"+ StringUtils.defaultString(param.get("arnameRC"), "") +"</b><br />";
				arcomtent = arcomtent +"본명영문 : <b>"+ StringUtils.defaultString(param.get("arnameRE"), "") +"</b><br />";
				arcomtent = arcomtent +"생년월일 : <b>"+ StringUtils.defaultString(param.get("birthday"), "") +" ("+ StringUtils.defaultString(param.get("birthGubun"), "") +")</b><br />";
				arcomtent = arcomtent +"성별 : <b>"+ StringUtils.defaultString(param.get("sex"), "") +"</b><br />";
				arcomtent = arcomtent +"전화번호 : <b>"+ StringUtils.defaultString(param.get("telno1"), "") +"-"+ StringUtils.defaultString(param.get("telno2"), "") +"-"+ StringUtils.defaultString(param.get("telno3"), "") +"</b><br />";
				arcomtent = arcomtent +"핸드폰번호 : <b>"+ StringUtils.defaultString(param.get("htelno1"), "") +"-"+ StringUtils.defaultString(param.get("htelno2"), "") +"-"+ StringUtils.defaultString(param.get("htelno3"), "") +"</b><br />";
				arcomtent = arcomtent +"이메일 : <b>"+ StringUtils.defaultString(param.get("email"), "") +"</b><br />";
				arcomtent = arcomtent +"활동분야 : <b>"+ StringUtils.defaultString(param.get("activeArea"), "") +"</b><br />";
				arcomtent = arcomtent +"학력 : <b>"+ StringUtils.defaultString(param.get("school"), "") +"</b><br />";
				arcomtent = arcomtent +"주요경력 : <b>"+ StringUtils.defaultString(param.get("imHistory"), "") +"</b><br />";
				arcomtent = arcomtent +"저술내역 : <b>"+ StringUtils.defaultString(param.get("writeHistory"), "") +"</b><br />";
				arcomtent = arcomtent +"수상내역 : <b>"+ StringUtils.defaultString(param.get("prizeHistory"), "") +"</b><br />";
				arcomtent = arcomtent +"영화계 입문배경 : <b>"+ StringUtils.defaultString(param.get("movieIn"), "") +"</b><br />";
				arcomtent = arcomtent +"애착작품 및 사유 : <b>"+ StringUtils.defaultString(param.get("likeMovie"), "") +"</b><br />";
				arcomtent = arcomtent +"하고 싶은 말 : <b>"+ StringUtils.defaultString(param.get("wantTalk"), "") +"</b><br />";

				param.put("arcomtent", arcomtent);
				param.put("recordcheck", "처리중");

		return careDao.insertMovieman(param);
	}

	public void insertAsk(Map<String, String> param) throws Exception{
		careDao.insertAsk(param);
		//이메일 발송 로직 추가 해야함.

		Map<String, Object> formModel = new HashMap<String, Object>();
		String fromEmail = "master@koreafilm.or.kr";
		String fromName = "한국영상자료원";
		//작성자에게 메일 발송
		if(param.get("userMail") != null && !"".equals(param.get("userMail"))){
			mailService.sendEmail(fromEmail, fromName, param.get("userMail"), param.get("createName"), "고객님의 문의가 접수되었습니다.", "", formModel);
		}
		//관리자에게 메일 발송
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("codeGroupId", "C105");
		paramMap.put("codeSubId", param.get("privateTypeCd"));
		paramMap = commonKfDao.selectCodeInfo(paramMap);
		if(paramMap != null && paramMap.get("cOptionValue2") != null && !"".equals(paramMap.get("cOptionValue2"))){
			mailService.sendEmail(fromEmail, fromName,  (String)paramMap.get("cOptionValue2"), (String)paramMap.get("cOptionValue1"),  param.get("createName")+"("+param.get("userName")+") 님의 1:1 문의가 접수되었습니다.", "", formModel);
		}

	}

	/**
	 * 기관결제 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVodCompany(long seq) throws Exception {
		Map<String, Object> result = careDao.selectVodCompany(seq);
		if(result == null){
			result = new HashMap<String, Object>();
			result.put("result", "N");
			result.put("msg", "결제 조회 결과가 없습니다.");
		}else{
			if("Y".equals(result.get("isenable"))){
				result.put("result", "N");
				result.put("msg", "이미 결제된 기관입니다.");
			}else if(result.get("isauthcode") == null || "".equals(result.get("isauthcode"))){
				result.put("result", "N");
				result.put("msg", "코드가 없습니다.");
			}else{

				if("1".equals(result.get("ctype"))){
					result.put("strType", "24시간 이용권");
				}else if("2".equals(result.get("ctype"))){
					result.put("strType", "14일 편수 무제한 이용권");
				}else if("3".equals(result.get("ctype"))){
					result.put("strType", "30일 편수 무제한 이용권");
				}else if("4".equals(result.get("ctype"))){
					result.put("strType", "사용자 설정 기간("+result.get("sdate")+" ~ "+result.get("edate")+")");
				}

				result.put("result", "Y");
			}
		}

		return result;
	}

	/**
	 * FAQ 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<Map<String,Object>> selectFaqList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String,Object>>(careDao.selectFaqListCount(paramMap), careDao.selectFaqPageList(paramMap));

	}

}
