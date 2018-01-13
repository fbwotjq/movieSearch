package egovframework.ag.homepage.story.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;

/**
 * 영화천국 Service
 * @author tipgi
 *
 */
@Service
@Transactional
public class MovieWebzineService {
	@Autowired
	private MovieWebzineDao movieWebzineDao;

	private final String[] FIRST_SOUND = { "가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하", "힙" };

	/**
	 * 웹진 목록 조회
	 * @return
	 * @throws Exception
	 */
	public PageListVo<WebzineCoverVo> selectMovieWebzineList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<WebzineCoverVo>(movieWebzineDao.selectMovieWebzineListCount(paramMap), movieWebzineDao.selectMovieWebzinePageList(paramMap));
	}


	/**
	 * 웹진 커버 정보 조회
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public WebzineCoverVo selectMovieWebzineCoverInfo(Long seq) throws Exception {
		return movieWebzineDao.selectMovieWebzineCoverInfo(seq);
	}

	/**
	 * 웹진 컨텐츠 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieWebzineContentList(Long upcate) throws Exception {
		return movieWebzineDao.selectMovieWebzineContentList(upcate);
	}

	/**
	 * 웹진 컨텐츠 상세 조회
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public WebzineContentVo selectMovieWebzineContentInfo(Long seq) throws Exception {
		return movieWebzineDao.selectMovieWebzineContentInfo(seq);
	}

	/**
	 * 웹진 키워드 검색 목록 조회
	 * @param keyword
	 * @return
	 * @throws Exception
	 */
	public PageListVo<WebzineContentVo> selectMovieWebzineKeywordSearchList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<WebzineContentVo>(movieWebzineDao.selectMovieWebzineKeywordSearchListCount(paramMap), movieWebzineDao.selectMovieWebzineKeywordSearchPageList(paramMap));
	}

	/**
	 * 필자별 웹진글 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectWriterWebzineCountList() throws Exception {
		List<Map<String, Object>> writerList = new ArrayList<Map<String,Object>>();

		for (int i = 0; i < this.FIRST_SOUND.length - 1; i++) {
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("fir", FIRST_SOUND[i]);
			paramMap.put("sec", FIRST_SOUND[i + 1]);

			String firstSound = StringUtils.getFirstElement(FIRST_SOUND[i]);
			paramMap.put("firstSound", firstSound);
			paramMap.put("writerDivList", movieWebzineDao.selectWriterWebzineCountList(paramMap));

			writerList.add(paramMap);
		}

		return writerList;
	}

	/**
	 * 웹진글 필자별 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<WebzineContentVo> selectWriterWebzineList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<WebzineContentVo>(movieWebzineDao.selectWriterWebzineListCount(paramMap), movieWebzineDao.selectWriterWebzinePageList(paramMap));
	}
}
