package egovframework.ag.homepage.history.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface HistoryDao {

	/**
	 * 사료관 목록 카운트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectArchivesListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 목록 페이지 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<ArchivesMasterVo> selectArchivesPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 마스터 정보 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesMasterInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 콘텐츠 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<ArchivesContentVo> selectArchivesContentList(Long archivesSeq) throws Exception;

	/**
	 * 사료관 파일 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesFileList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 파일 정보 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesFileInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 파일 다운 카운트 증가
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int increaseArchivesFileDownCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 파일 뷰 카운트 증가
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int increaseArchivesFileViewCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 콘텐츠 파일 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesContentFileList(Long archivesSeq) throws Exception;

	/**
	 * 사료관 읽은수 증가
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public int increaseArchivesReadCount(Long archivesSeq) throws Exception;

	/**
	 * 구술채록문 구술인 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesTalkTargetCountList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 소개정보 조회
	 * @param archivesTypeCd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesIntroInfo(String archivesTypeCd) throws Exception;


	/**
	 * 사료관 연도 목록 조회 - group by code02
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesSubCodeYearList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 연도 목록 조회 - group by code02
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesSubCodeHeadYearList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 대표 콘텐츠 정보 조회
	 * @param archivesTypeCd
	 * @return
	 * @throws Exception
	 */
	public ArchivesMasterVo selectArchivesHeadInfo(String archivesTypeCd) throws Exception;


	/**
	 * 사료관 관련 영화 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesRelMovieList(Long archivesSeq) throws Exception;

	/**
	 * 사료관 관련 영화인 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesRelPersonList(Long archivesSeq) throws Exception;

	/**
	 * 사료관 관련글 목록 조회
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesRelLinkList(Long archivesSeq) throws Exception;

	/**
	 * 사료관 게시판 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectArchivesBoardListCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 게시판 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectArchivesBoardPageList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 게시판 정보
	 * @param boardSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectArchivesBoardInfo(Long boardSeq) throws Exception;

	/**
	 * 사료관 게시판 읽은수 증가
	 * @param archivesSeq
	 * @return
	 * @throws Exception
	 */
	public int increaseArchivesBoardReadCount(Long boardSeq) throws Exception;

	/**
	 * 사료관 결재정보
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPayInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 사료관 결재내역 저장
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertPayResult(Map<String, String> paramMap) throws Exception;

	/**
	 * 메인 사료관 콘텐츠 목록(2건)
	 * @return
	 * @throws Exception
	 */
	public List<MainArchivesContentVo> selectMainArchivesContentList() throws Exception;

	/**
	 * 메인 서울의 극장 목록
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTheaterList() throws Exception;

}
