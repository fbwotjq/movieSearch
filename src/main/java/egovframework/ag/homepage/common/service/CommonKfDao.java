package egovframework.ag.homepage.common.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KFMapper;

@KFMapper
public interface CommonKfDao {
	/**
	 * 메뉴 정보 조회
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMenuList() throws Exception;

	/**
	 * 코드 정보 조회
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCodeList(Map<String, Object> paramMap) throws Exception;

	/**
	 * 코드 정보 조회
	 * @param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCodeInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 코드 정보 조회(서브리스트 포함)
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCodeTreeList(Map<String, Object> paramMap) throws Exception;



}
