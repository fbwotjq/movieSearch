package egovframework.ag.homepage.common.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * KMDB 공통 Service
 * @author tipgi
 *
 */
@Service
@Transactional
public class KmdbService {

	@Autowired
	private KmdbDao kmdbDao;

	/**
	 * 간단 영화 정보 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSimpleMovieInfo(Map<String, Object> paramMap) throws Exception {
		return kmdbDao.selectSimpleMovieInfo(paramMap);
	}


	/**
	 * 간단 영화 정보 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSimpleMovieList(List<Map<String, Object>> movieList) throws Exception {
		List<Map<String, Object>> resultMovieList = new ArrayList<Map<String, Object>>();

		for (Map<String, Object> movieInfoMap : movieList) {
			Map<String, Object> resultMovieInfoMap = this.selectSimpleMovieInfo(movieInfoMap);

			resultMovieList.add(resultMovieInfoMap);
		}

		return resultMovieList;
	}


	/**
	 * 간단 영화인 정보 조회
	 * @param personList
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSimplePersonList(List<String> personList) throws Exception {
		if (personList != null && personList.size() > 0) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("list", personList);
			return kmdbDao.selectSimplePersonList(paramMap);
		}else {
			return new ArrayList<Map<String, Object>>();
		}
	}
}
