package egovframework.ag.homepage.vod.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;


@KMDBMapper
public interface VodDao {

	/**
	 * VOD 메인 조회
	 * @param nation (movie_id)
	 * @param pDataID (movie_seq)
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVodMain(String contentTypeCd) throws Exception;

	/**
	 * VOD 메인 LIST 조회
	 * @param nation (movie_id)
	 * @param pDataID (movie_seq)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectVodMainList(String planSeq) throws Exception;

	/**
	 * VOD 메인 SEARCH LIST 조회
	 * @param nation (movie_id)
	 * @param pDataID (movie_seq)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectVodSearchTextList() throws Exception;

	/**
	 * 메인 VOD 정보 조회
	 * @param nation (movie_id)
	 * @param pDataID (movie_seq)
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodMainInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 기획전 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectPlanListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 기획전 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPlanPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 기획전 카운트 증가
	 * @return
	 * @throws Exception
	 */
	public void updatePlanInfoHit(long planSeq) throws Exception;

	/**
	 * 기획전 상세
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPlanInfo(long planSeq) throws Exception;

	/**
	 * 기획전 관련영화 목록 조회
	 * @param planSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPlanRelMovieList(long planSeq) throws Exception;

	/**
	 * 고전영화 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectOldMovieListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 고전영화 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectOldMoviePageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 고전영화 인물다큐 목록 카운트
	 * @return
	 * @throws Exception
	 */
	public int selectOldDocuListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 고전영화 인물다큐 목록 페이징
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectOldDocuPageList(Map<String, Object> paramMap) throws Exception;


	/**
	 * VOD 정보 조회
	 * @param nation (movie_id)
	 * @param pDataID (movie_seq)
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 플레이어 카운트 추가(모바일)
	 * @return
	 * @throws Exception
	 */
	public void updateMultiFile(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 플레이어 로그 추가
	 * @return
	 * @throws Exception
	 */
	public void insertVodViewLog(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 기업회원 체크
	 * @return
	 * @throws Exception
	 */
	public Integer selectVodCompanyPermmision(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 잔액조회
	 * @return
	 * @throws Exception
	 */
	public Integer selectVodBalance(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 잔액대비 남은날 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodBalanceDate(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 14일 정액권 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodFixChargeTwoWeek(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 30일 정액권 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodFixChargeMonth(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 선불제 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Long selectVodPrepaid(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 무료회원 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodFreeAll(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 연간무료회원 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodFreeYear(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 카트 조회
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectVodCart(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 플레이어 로그 추가
	 * @return
	 * @throws Exception
	 */
	public void insertVodCart(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 1일간 사용내역
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public VodPayResutVo selectVodViewDayPass(Map<String, Object> paramMap) throws Exception;

	/**
	 * 최대 볼 수 있는 영화 편수 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public VodPayResutVo selectVodMaxViewCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 결제 이후 관람한 영화의 편수 체크
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int selectVodViewCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * VOD 관람내역 추가
	 * @return
	 * @throws Exception
	 */
	public void insertVodViewResult(Map<String, Object> paramMap) throws Exception;

	/**
	 * 동영상 제목으로 조회
	 * @param multorNm
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectMovieInfo(Map<String, Object> paramMap) throws Exception;


}
