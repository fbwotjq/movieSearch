package egovframework.ag.homepage.story.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.homepage.common.service.CommonKfDao;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 영화리뷰 Service
 * @author 박종호
 *
 */
@Service
@Transactional
public class MovieReviewService {
	@Autowired
	private MovieReviewDao movieReviewDao;

	/**
	 * 사용자리뷰 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<Map<String,Object>> selectUserReviewList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String,Object>>(movieReviewDao.selectUserReviewListCount(paramMap), movieReviewDao.selectUserReviewList(paramMap));

	}

	/**
	 * 사용자리뷰 상세
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserReviewInfo(Long seq) throws Exception {
		movieReviewDao.updateUserReviewReadCount(seq);
		return movieReviewDao.selectUserReviewInfo(seq);
	}

	/**
	 * 사용자리뷰 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertUserReviewInfo(Map<String, Object> paramMap) throws Exception {
		return movieReviewDao.insertUserReviewInfo(paramMap);
	}

	/**
	 * 영화 관련 사용자리뷰 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PageListVo<MovieReviewVo> selectRelMovieReviewList(Map<String, Object> paramMap) throws Exception {
		return new PageListVo<MovieReviewVo>(movieReviewDao.selectRelMovieReviewListCount(paramMap), movieReviewDao.selectRelMovieReviewPageList(paramMap));
	}

}
