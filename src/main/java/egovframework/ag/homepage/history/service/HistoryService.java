package egovframework.ag.homepage.history.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.homepage.common.service.CommonService;

@Service
public class HistoryService {
	private final String[] FIRST_SOUND = { "가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하", "힙" };

	@Autowired
	private HistoryDao historyDao;

	@Autowired
	private CommonService commonService;

	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> getArchivesCodeList(List<Map<String, Object>> codeList) throws Exception {
		List<Map<String, Object>> archivesCodeList = new ArrayList<Map<String,Object>>();

		for (Map<String, Object> codeMap : codeList) {
			archivesCodeList.add(codeMap);

			List<Map<String, Object>> subList = (List<Map<String, Object>>)codeMap.get("subList");

			if (subList != null && subList.size() > 0) {
				archivesCodeList.addAll((List<Map<String, Object>>)codeMap.get("subList"));
			}
		}

		return archivesCodeList;

	}

	/**
	 * 온라인 사료관 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<ArchivesMasterVo> selectArchivesList(Map<String, Object> paramMap, List<Map<String, Object>> codeList, String loginUserId) throws Exception {
		paramMap.put("partCodeList", commonService.selectSearchCodeList("C111"));
		paramMap.put("archivesCodeList", getArchivesCodeList(codeList));
		paramMap.put("loginUserId", loginUserId);

		return new PageListVo<ArchivesMasterVo>(historyDao.selectArchivesListCount(paramMap), historyDao.selectArchivesPageList(paramMap));
	}

	/**
	 * 온라인 사료관 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public List<ArchivesMasterVo> selectArchivesPageList(Map<String, Object> paramMap) throws Exception {
		return historyDao.selectArchivesPageList(paramMap);
	}



	/**
	 * 온라인 사료관 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<ArchivesMasterVo> selectArchivesList(Map<String, Object> paramMap, List<Map<String, Object>> codeList) throws Exception {
		return selectArchivesList(paramMap, codeList, "");
	}

	/**
	 * 사료관 마스터 정보 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesMasterInfo(Long archivesSeq, List<Map<String, Object>> codeList) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("partCodeList", commonService.selectSearchCodeList("C111"));
		paramMap.put("archivesCodeList", getArchivesCodeList(codeList));
		paramMap.put("archivesSeq", archivesSeq);

		try {
			historyDao.increaseArchivesReadCount(archivesSeq);
		}catch(Exception e) {
			e.printStackTrace();
		}


		return historyDao.selectArchivesMasterInfo(paramMap);
	}

	/**
	 * 사료관 컨텐츠 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<ArchivesContentVo> selectArchivesContentList(Long archivesSeq) throws Exception {
		return historyDao.selectArchivesContentList(archivesSeq);
	}


	/**
	 * 사료관 파일 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesFileList(Long fileSeq, String fileTypeCd) throws Exception {
		return selectArchivesFileList(fileSeq, fileTypeCd, "");
	}

	/**
	 * 사료관 파일 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesFileList(Long fileSeq, String fileTypeCd, String loginUserId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("fileSeq", fileSeq);
		paramMap.put("fileTypeCd", fileTypeCd);
		paramMap.put("loginUserId", loginUserId);

		return historyDao.selectArchivesFileList(paramMap);
	}

	/**
	 * 사료관 파일 정보 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesFileInfo(Long fileSeq, String fileTypeCd) throws Exception {
		return selectArchivesFileInfo(fileSeq, fileTypeCd, "");
	}

	/**
	 * 사료관 파일 정보 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesFileInfo(Long fileSeq, String fileTypeCd, String loginUserId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("fileSeq", fileSeq);
		paramMap.put("fileTypeCd", fileTypeCd);
		paramMap.put("loginUserId", loginUserId);

		return historyDao.selectArchivesFileInfo(paramMap);
	}


	/**
	 * 사료관 파일 다운 카운트 증가
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int increaseArchivesFileDownCount(Long fileSeq, Long fileOrder) {
		int updCnt = 0;

		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("fileSeq", fileSeq);
			paramMap.put("fileOrder", fileOrder);

			historyDao.increaseArchivesFileDownCount(paramMap);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return updCnt;
	}

	/**
	 * 사료관 파일 뷰 카운트 증가
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int increaseArchivesFileViewCount(Long fileSeq, Long fileOrder) {
		int updCnt = 0;

		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("fileSeq", fileSeq);
			paramMap.put("fileOrder", fileOrder);

			historyDao.increaseArchivesFileViewCount(paramMap);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return updCnt;
	}

	/**
	 * 사료관 콘텐츠 파일 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesContentFileList(Long archivesSeq) throws Exception {
		return historyDao.selectArchivesContentFileList(archivesSeq);
	}

	/**
	 * 구술인 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesTalkTargetCountList() throws Exception {
		List<Map<String, Object>> writerList = new ArrayList<Map<String,Object>>();

		for (int i = 0; i < this.FIRST_SOUND.length - 1; i++) {
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("fir", FIRST_SOUND[i]);
			paramMap.put("sec", FIRST_SOUND[i + 1]);

			String firstSound = StringUtils.getFirstElement(FIRST_SOUND[i]);
			paramMap.put("firstSound", firstSound);
			paramMap.put("targetList", historyDao.selectArchivesTalkTargetCountList(paramMap));

			writerList.add(paramMap);
		}

		return writerList;
	}

	/**
	 * 사료관 소개정보 조회
	 * @param archivesTypeCd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesIntroInfo(String archivesTypeCd) throws Exception {
		return historyDao.selectArchivesIntroInfo(archivesTypeCd);
	}

	/**
	 * 사료관 파일정보 조회
	 * @param fileSeq
	 * @param fileTypeCd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesFileInfo(Long fileSeq, Long fileOrder) throws Exception {
		return selectArchivesFileInfo(fileSeq, fileOrder, "");
	}

	/**
	 * 사료관 파일정보 조회
	 * @param fileSeq
	 * @param fileTypeCd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesFileInfo(Long fileSeq, Long fileOrder, String loginUserId) throws Exception {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("fileSeq", fileSeq);
		searchMap.put("fileOrder", fileOrder);
		searchMap.put("loginUserId", loginUserId);

		return historyDao.selectArchivesFileInfo(searchMap);
	}

	/**
	 * 사료관 연도 목록 조회 - group by code02
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesSubCodeYearList(String archivesTypeCd, String code01, String code02) throws Exception {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("archivesTypeCd", archivesTypeCd);
		searchMap.put("code01", code01);
		searchMap.put("code02", code02);

		return historyDao.selectArchivesSubCodeYearList(searchMap);
	}

	/**
	 * 사료관 연도 목록 조회 - group by code02
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesSubCodeYearList(String archivesTypeCd, String code01, String code02, String headYear) throws Exception {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("archivesTypeCd", archivesTypeCd);
		searchMap.put("code01", code01);
		searchMap.put("code02", code02);
		searchMap.put("headYear", headYear);

		return historyDao.selectArchivesSubCodeYearList(searchMap);
	}

	/**
	 * 사료관 연도 목록 조회 - group by code02
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesSubCodeHeadYearList(String archivesTypeCd, String code01, String code02) throws Exception {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("archivesTypeCd", archivesTypeCd);
		searchMap.put("code01", code01);
		searchMap.put("code02", code02);

		return historyDao.selectArchivesSubCodeHeadYearList(searchMap);
	}

	/**
	 * 사료관 대표 콘텐츠 정보 조회
	 * @param archivesTypeCd
	 * @return
	 * @throws Exception
	 */
	public ArchivesMasterVo selectArchivesHeadInfo(String archivesTypeCd) throws Exception {
		return historyDao.selectArchivesHeadInfo(archivesTypeCd);
	}

	/**
	 * 사료관 관련 영화 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesRelMovieList(Long archivesSeq) throws Exception {
		return historyDao.selectArchivesRelMovieList(archivesSeq);
	}

	/**
	 * 사료관 관련 영화인 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesRelPersonList(Long archivesSeq) throws Exception {
		return historyDao.selectArchivesRelPersonList(archivesSeq);
	}

	/**
	 * 사료관 관련글 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesRelLinkList(Long archivesSeq) throws Exception {
		return historyDao.selectArchivesRelLinkList(archivesSeq);
	}

	/**
	 * 사료관 게시판 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String, Object>> selectArchivesBoardList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<Map<String,Object>>(historyDao.selectArchivesBoardListCount(paramMap), historyDao.selectArchivesBoardPageList(paramMap));
	}

	/**
	 * 사료관 게시판 정보
	 * @param boardSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesBoardInfo(Long boardSeq) throws Exception {
		try {
			historyDao.increaseArchivesBoardReadCount(boardSeq);
		}catch(Exception e) {
			e.printStackTrace();
		}


		return historyDao.selectArchivesBoardInfo(boardSeq);
	}

	/**
	 * 결재 정보
	 * @param boardSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPayInfo(Map<String, Object> paramMap) throws Exception {

		return historyDao.selectPayInfo(paramMap);
	}

	/**
	 * 결재내역 저장
	 * @param boardSeq
	 * @return
	 * @throws Exception
	 */
	public void insertPayResult(Map<String, String> param) throws Exception{
		historyDao.insertPayResult(param);
	}

	/**
	 * 메인 사료관 콘텐츠 목록(2건)
	 * @return
	 * @throws Exception
	 */
	public List<MainArchivesContentVo> selectMainArchivesContentList() throws Exception {
		return historyDao.selectMainArchivesContentList();
	}

	/**
	 * 메인 서울의 극장 목록
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTheaterList() throws Exception {
		return historyDao.selectTheaterList();
	}
}
