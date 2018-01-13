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
 * 영화글 Service
 * @author tipgi
 *
 */
@Service
@Transactional
public class MovieStoryService {
	@Autowired
	private MovieStoryDao movieStoryDao;

	private final String[] FIRST_SOUND = { "가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하", "힙" };

	/**
	 * 영화글 메인 대표글 정보 조회
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object>  selectMovieStroyHeadInfo() throws Exception {
		return movieStoryDao.selectMovieStroyHeadInfo();
	}

	/**
	 * 영화글 메인 영화글 목록 조회
	 * @param movieStoryCount
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMainMovieStoryList(Integer mainMovieStoryCount) throws Exception {
		return movieStoryDao.selectMainMovieStoryList(mainMovieStoryCount);
	}

	/**
	 * 영화글 조회 대상 구분정보 조회
	 * @param storyDivSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSearchTargetStoryDivSeqInfo(Long storyDivSeq) throws Exception {
		return movieStoryDao.selectSearchTargetStoryDivSeqInfo(storyDivSeq);
	}

	/**
	 * 영화글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<MovieStoryVo> selectMovieStoryList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<MovieStoryVo>(movieStoryDao.selectMovieStoryListCount(paramMap), movieStoryDao.selectMovieStoryPageList(paramMap));
	}

	/**
	 * 영화글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectMovieStoryList(Map<String, Object> paramMap, Integer movieStoryCount) throws Exception {
		paramMap.put("movieStoryCount", movieStoryCount);
		return movieStoryDao.selectTopCountMovieStoryList(paramMap);
	}

	/**
	 * 종료연재 영화글 구분 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectEndStoryDivList() throws Exception {
	    return movieStoryDao.selectEndStoryDivList();
	}

	/**
	 * 종료연재 영화글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectEndMovieStoryList(Map<String, Object> paramMap) throws Exception {
		paramMap.put("endYn", "Y");

		//return movieStoryDao.selectMovieStoryList(paramMap);
		return null;
	}

	/**
	 * 영화글 상세정보 조회
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public MovieStoryVo selectMovieStoryInfo(Long storySeq) throws Exception {
		movieStoryDao.updateMovieStoryReadCount(storySeq);
		return movieStoryDao.selectMovieStoryInfo(storySeq);
	}

	/**
	 * 영화글 필자의 이전 영화글 조회
	 * @param storySeq
	 * @return
	 * @throws Exception
	 */
	public MovieStoryVo selectWriterPreMovieStoryInfo(MovieStoryVo movieStoryVo) throws Exception {
		Long preStorySeq = movieStoryDao.selectWriterPreMovieStorySeq(movieStoryVo);

		if (preStorySeq != null) {
			return this.selectMovieStoryInfo(preStorySeq);
		}else {
			return null;
		}
	}

	/**
	 * 영화글 추천 영화글 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryVo> selectChoiceMovieStoryList() throws Exception {
		return movieStoryDao.selectChoiceMovieStoryList();
	}

	/**
	 * 영화글 연관영화 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryRelMovieVo> selectMovieStoryRelMovieList(Long storySeq) throws Exception {
		List<MovieStoryRelMovieVo> relMovieList = movieStoryDao.selectMovieStoryRelMovieList(storySeq);

		for (MovieStoryRelMovieVo relMovieInfo : relMovieList) {
			List<MovieStoryVo> movieStoryList =  movieStoryDao.selectMovieRelMovieStoryList(relMovieInfo);

			relMovieInfo.setMovieStoryList(movieStoryList);
		}

		return relMovieList;
	}

	/**
	 * 영화글 연관영화인 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<MovieStoryRelPersonVo> selectMovieStoryRelPersonList(Long storySeq) throws Exception {
		List<MovieStoryRelPersonVo> relPersonList = movieStoryDao.selectMovieStoryRelPersonList(storySeq);

		for (MovieStoryRelPersonVo relPersonInfo : relPersonList) {
			List<MovieStoryVo> movieStoryList =  movieStoryDao.selectPersonRelMovieStoryList(relPersonInfo);

			relPersonInfo.setMovieStoryList(movieStoryList);
		}

		return relPersonList;
	}

	/**
	 * 필자별 영화글 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectWriterMovieStoryCountList() throws Exception {
		List<Map<String, Object>> writerList = new ArrayList<Map<String,Object>>();

		for (int i = 0; i < this.FIRST_SOUND.length - 1; i++) {
			Map<String, Object> paramMap = new HashMap<String, Object>();

			paramMap.put("fir", FIRST_SOUND[i]);
			paramMap.put("sec", FIRST_SOUND[i + 1]);

			String firstSound = StringUtils.getFirstElement(FIRST_SOUND[i]);
			paramMap.put("firstSound", firstSound);
			paramMap.put("writerDivList", movieStoryDao.selectWriterMovieStoryCountList(paramMap));

			writerList.add(paramMap);
		}

		return writerList;
	}

	/**
	 * 필자 정보 조회
	 * @param writerSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectWriterInfo(Long writerSeq) throws Exception {
		return movieStoryDao.selectWriterInfo(writerSeq);
	}

	/**
	 * 관련 영호인 영화글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<MovieStoryVo> selectRelPersonMovieStoryList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<MovieStoryVo>(movieStoryDao.selectRelPersonMovieStoryListCount(paramMap), movieStoryDao.selectRelPersonMovieStoryPageList(paramMap));
	}

	/**
	 * 영화 관련 영화글 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<MovieStoryVo> selectRelMovieStoryList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<MovieStoryVo>(movieStoryDao.selectRelMovieStoryListCount(paramMap), movieStoryDao.selectRelMovieStoryPageList(paramMap));
	}

}
