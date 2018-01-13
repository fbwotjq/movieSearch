package egovframework.ag.homepage.story.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 영화연표 Service
 * @author tipgi
 *
 */
@Service
@Transactional
public class MovieYearService {
	@Autowired
	private MovieYearDao movieYearDao;
	/**
	 * 영화연표 정보 조회
	 * @param movieYear
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMovieYearInfo(String movieYear) throws Exception {
		return movieYearDao.selectMovieYearInfo(movieYear);
	}

	/**
	 * 영화연표 최대 연도값 조회
	 * @return
	 * @throws Exception
	 */
	public String selectMaxMovieYear() throws Exception {
		return movieYearDao.selectMaxMovieYear();
	}

	/**
	 * 영화연표 연도 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<String> selectMovieYearYearList() throws Exception {
		return movieYearDao.selectMovieYearYearList();
	}
}
