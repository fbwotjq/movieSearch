package egovframework.ag.homepage.story.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

/**
 * 영화연표 Dao
 * @author tipgi
 *
 */
@KMDBMapper
public interface MovieYearDao {
	/**
	 * 영화연표 정보 조회
	 * @param movieYear
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMovieYearInfo(String movieYear) throws Exception;

	/**
	 * 영화연표 최대 연도값 조회
	 * @return
	 * @throws Exception
	 */
	public String selectMaxMovieYear() throws Exception;

	/**
	 * 영화연표 연도 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<String> selectMovieYearYearList() throws Exception;
}
