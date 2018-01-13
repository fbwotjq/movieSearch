package egovframework.ag.homepage.vod.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.homepage.common.service.CommonKfDao;

@Service
public class VodService {

	@Autowired
	private VodDao vodDao;

	@Autowired
	private CommonKfDao commonKfDao;

	/**
	 * 메인 컨텐츠 조회
	 * @param contentTypeCd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVodMain(String contentTypeCd) throws Exception {
		return vodDao.selectVodMain(contentTypeCd);
	}

	/**
	 * 메인 컨텐츠 목록 조회
	 * @param planSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectVodMainList(String planSeq) throws Exception {
		return vodDao.selectVodMainList(planSeq);
	}

	/**
	 * 메인 검색어 목록 조회
	 * @param codeGroupId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectVodSearchTextList() throws Exception {
		return vodDao.selectVodSearchTextList();
	}


	/**
	 * 메인 VOD 정보 조회
	 * @param category
	 * @param movieId
	 * @param movieSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodMainInfo(Map<String, Object> paramMap) throws Exception {
		return vodDao.selectVodMainInfo(paramMap);
	}

	/**
	 * 기획전 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo selectPlanList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo(vodDao.selectPlanListCount(paramMap), vodDao.selectPlanPageList(paramMap));

	}

	/**
	 * 기획전 상세
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPlanInfo(long planSeq) throws Exception {
		vodDao.updatePlanInfoHit(planSeq);
		return vodDao.selectPlanInfo(planSeq);
	}

	/**
	 * 기획전 관련 영화 목록 조회
	 * @param planSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPlanRelMovieList(long planSeq) throws Exception {
		return vodDao.selectPlanRelMovieList(planSeq);
	}

	/**
	 * 고전영화 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo selectOldMovieList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo(vodDao.selectOldMovieListCount(paramMap), vodDao.selectOldMoviePageList(paramMap));

	}

	/**
	 * 고전영화 인물다큐 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo selectOldDocuList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo(vodDao.selectOldDocuListCount(paramMap), vodDao.selectOldDocuPageList(paramMap));

	}

	/**
	 * VOD 정보 조회
	 * @param nation (movie_id)
	 * @param pDataID (movie_seq)
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodInfo(Map<String, Object> paramMap) throws Exception {
		Map<String,Object> result = vodDao.selectVodInfo(paramMap);

		Map<String,Object> returnMap = new HashMap<String,Object>();

		if(result == null || result.isEmpty()){
			returnMap.put("resultYn", "N");
			returnMap.put("resultMsg", "지정된 동영상이 없습니다.");
			returnMap.put("fno", "");
		}else{

			String multorNm = (String)result.get("multorNm");
			if(multorNm == null || "".equals(multorNm)){
				returnMap.put("resultYn", "N");
				returnMap.put("resultMsg", "지정된 동영상이 없습니다.");
				returnMap.put("fno", "");
			}else{
				String multorNmSplit[] = multorNm.split("_");
				multorNm = multorNmSplit[0] + "_" + multorNmSplit[1];
				returnMap.put("resultYn", "Y");
				returnMap.put("resultMsg", "");
				returnMap.put("fno", multorNm);
				returnMap.put("info", result);
			}

		}
		return returnMap;
	}

	/**
	 * VOD 카운트
	 * @param movieId
	 * @param movieSeq
	 * @return
	 * @throws Exception
	 */
	public void updatePlayerCount(Map<String, Object> paramMap) throws Exception {
		Map<String,Object> result = vodDao.selectVodInfo(paramMap);

		if(result != null){
			result.put("userId", paramMap.get("userId"));
			vodDao.updateMultiFile(result);
			vodDao.insertVodViewLog(result);
		}

	}

	/**
	 * VOD 가능여부 조회
	 * @param movieId
	 * @param movieSeq
	 * @param mulId
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodViewCheck(Map<String,Object> paramMap) throws Exception {

		paramMap.put("result", "true");
		String vodPer = "F";
		String vodAdv = "F";
		String userId = "";
		int userLevel = 0;
		paramMap.put("vodPer", vodPer);
		paramMap.put("vodAdv", vodAdv);

		Map<String,Object> result = vodDao.selectVodInfo(paramMap);
		Long price = StringUtils.getLong(result.get("price"));
		paramMap.put("price", price);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null){
			MemberDetails member = (MemberDetails) auth.getPrincipal();
			if(member != null) {
				userId = member.getUserid();
				userLevel = Integer.parseInt(member.getUserLevel());
			}
		}
		//로그인 여부 체크
		if(userId == null || "".equals(userId)){
			paramMap.put("result", "false");
			paramMap.put("errorType", "01");
			return paramMap;
		}
		result.put("userId", userId);

		//기업회원 여부 조회 - 기업회원은 VOD 감상가능 (기업아이피인경우 + 기업 아이디)
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		result.put("userIp", sra.getRequest().getRemoteAddr());
		Integer companySeq = vodDao.selectVodCompanyPermmision(result);
		if(companySeq != null && companySeq > 0){
			paramMap.put("vodPer", "CT");
			return paramMap;
		}

		//사용자별 등급 체크
		String mLevel = StringUtils.defaultString(result.get("levelClss"),"");
		if(userLevel <= 13 && ("3".equals(mLevel) || "6".equals(mLevel) || "8".equals(mLevel))){
			paramMap.put("result", "false");
			paramMap.put("errorType", "02");
			return paramMap;
		}else if(userLevel <= 16 && ("2".equals(mLevel) || "7".equals(mLevel) || "C".equals(mLevel))){
			paramMap.put("result", "false");
			paramMap.put("errorType", "03");
			return paramMap;
		}else if(userLevel <= 18 && ("1".equals(mLevel) || "8".equals(mLevel) || "D".equals(mLevel))){
			paramMap.put("result", "false");
			paramMap.put("errorType", "04");
			return paramMap;
		}

		//잔액조회
		Integer vodBalance = vodDao.selectVodBalance(result);
		int strDate = 1;
		if(vodBalance == null || vodBalance == 500){
			strDate = 1;
		}else if(vodBalance == 1000){
			strDate = 2;
		}else if(vodBalance == 1500){
			strDate = 3;
		}else if(vodBalance == 2000){
			strDate = 4;
		}else if(vodBalance == 2500){
			strDate = 5;
		}

		//잔액대비 가용날짜 조회
		result.put("strDate", strDate);

		//잔액대비 가용날짜 조회
		if("F".equals(vodPer)){
			Map<String, Object> returnMap = vodDao.selectVodBalanceDate(result);
			if(returnMap != null){
				vodPer = "T";
			}
		}

		//관람기간 14일권여부 조회
		if("F".equals(vodPer)){
			Map<String, Object> returnMap = vodDao.selectVodFixChargeTwoWeek(result);
			if(returnMap != null){
				vodPer = "T";
			}
		}

		//관람기간 30일권여부 조회
		if("F".equals(vodPer)){
			Map<String, Object> returnMap = vodDao.selectVodFixChargeMonth(result);
			if(returnMap != null){
				vodPer = "T";
			}
		}

		//정액권 조회
		if("F".equals(vodPer)){
			Long resultLong= vodDao.selectVodPrepaid(result);
			if(resultLong != null){
				if(resultLong >= price && resultLong > 0L){
					vodPer = "T";
					paramMap.put("vodAdv", "T");
				}
			}
		}

		//무료회원 조회1
		if("F".equals(vodPer)){
			Map<String, Object> returnMap = vodDao.selectVodFreeAll(result);
			if(returnMap != null){
				vodPer = "T";
			}
		}

		//무료회원 조회2
		if("F".equals(vodPer)){
			Map<String, Object> returnMap = vodDao.selectVodFreeYear(result);
			if(returnMap != null){
				vodPer = "T";
			}
		}

		paramMap.put("vodPer", vodPer);
		paramMap.put("movieId", result.get("movieId"));
		paramMap.put("movieSeq", result.get("movieSeq"));
		paramMap.put("mulId", result.get("mulId"));
		paramMap.put("fileId", result.get("fileId"));
		paramMap.put("mulTitle", result.get("mulTitle"));

		return paramMap;

	}

	/**
	 * VOD 카트 조회
	 * @param movieId
	 * @param movieSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVodCart(Map<String, Object> paramMap) throws Exception {
		return vodDao.selectVodCart(paramMap);
	}

	/**
	 * VOD 카트 담기
	 * @param movieId
	 * @param movieSeq
	 * @return
	 * @throws Exception
	 */
	public void insertVodCart(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> result = vodDao.selectVodCart(paramMap);

		if(result == null){
			ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
			paramMap.put("sessionId", sra.getRequest().getAttribute("JSESSIONID"));

			vodDao.insertVodCart(paramMap);
		}

	}

	/**
	 * VOD 과금조회
	 * @param movieId
	 * @param movieSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVodChargeCheck(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object> ();
		VodPayResutVo resultVo = vodDao.selectVodViewDayPass(paramMap);

		if(resultVo != null){
			returnMap.put("result", "true");
			returnMap.put("msg", "24시간 이내에 보신 영화이므로 과금되지 않습니다.");
			return returnMap;
		}

		int sPaySeq = 0;       	// '결제 Seq
		int maxMovieCnt = 0;    //'최대 볼 수 있는 영화 편수
		int movieViewCnt = 0;   //'결제 이후 관람하는 영화의 갯수

		resultVo = null;
		//최대 볼 수 있는 영화 편수 조회
		resultVo = vodDao.selectVodMaxViewCount(paramMap);

		if(resultVo == null || resultVo.getMaxmoviecnt() == 0){
			returnMap.put("result", "false");
			returnMap.put("msg", "결제 정보가 없습니다.");
			return returnMap;
		}
		maxMovieCnt = resultVo.getMaxmoviecnt();
		sPaySeq = resultVo.getPayseq();
		paramMap.put("paySeq", sPaySeq);
		//결제 이후 관람한 영화의 편수 체크
		movieViewCnt = vodDao.selectVodViewCount(paramMap);

		if(maxMovieCnt > movieViewCnt ){
			insertVodViewResult(paramMap);
			returnMap.put("result", "true");
			returnMap.put("msg", "본 영화는 관람 가능한 총"+maxMovieCnt+"편 중 "+(movieViewCnt+1)+"번째 영화입니다.");
		}else{
			returnMap.put("result", "false");
			returnMap.put("msg", "잔여 관람 횟수가 없습니다.");
		}

		return returnMap;
	}

	/**
	 * VOD 카트 담기
	 * @param movieId
	 * @param movieSeq
	 * @return
	 * @throws Exception
	 */
	public void insertVodViewResult(Map<String, Object> paramMap) throws Exception {
		vodDao.insertVodViewResult(paramMap);
	}

	/**
	 * 동영상 제목으로 조회
	 * @param multorNm
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectMovieInfo(Map<String, Object> paramMap) throws Exception{
		return vodDao.selectMovieInfo(paramMap);
	}


}
