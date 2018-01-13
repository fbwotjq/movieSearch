package egovframework.ag.homepage.common.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

/**
 * KMDB 공통 Dao
 * @author tipgi
 *
 */
@KMDBMapper
public interface KmdbDao {

	/**
	 * 간단 영화 정보 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSimpleMovieInfo(Map<String, Object> paramMap) throws Exception;

	/**
	 * 간단 영화인 정보 조회
	 * @param personList
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSimplePersonList(Map<String, Object> paramMap) throws Exception;
}
