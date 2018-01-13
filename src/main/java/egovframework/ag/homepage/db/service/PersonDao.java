package egovframework.ag.homepage.db.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface PersonDao {

	/**
	 * 영화인 정보 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public PersonVo selectPersonInfo(String personId) throws Exception;

	/**
	 * 영화인 대표분야 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<String> selectSpecFieldList(PersonVo personVo) throws Exception;

	/**
	 * 영화인 활동년도 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<String> selectActYearList(PersonVo personVo) throws Exception;

	/**
	 * 영화인 대표 이미지 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public PersonImgVo selectHeadImageInfo(PersonVo personVo) throws Exception;

	/**
	 * 영화인 이미지 목록 조회
	 * @param personVo
	 * @return
	 * @throws Exception
	 */
	public List<PersonImgVo> selectImageList(String personId) throws Exception;

	/**
	 * 영화인 동영상 목록 조회
	 * @param personVo
	 * @return
	 * @throws Exception
	 */
	public List<PersonMulVo> selectMulList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 영화인 필모그라피 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<PersonFilmoVo> selectFilmoList(String personId) throws Exception;

	/**
	 * 영화인 상세 필모그라피 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<PersonFilmoDetailVo> selectFilmoDetailList(String personId) throws Exception;

	/**
	 * 영화인 영화제 수상 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<PersonFestivalAwardsVo> selectFestivalAwardsList(String personId) throws Exception;

	/**
	 * 영화인 기타 이름 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<String> selectPersonEtcTitleList(String personId) throws Exception;

}
