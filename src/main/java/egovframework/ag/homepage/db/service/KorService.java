package egovframework.ag.homepage.db.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.homepage.own.service.DcinemaVO;
import egovframework.ag.homepage.own.service.FilmVO;
import egovframework.ag.homepage.own.service.PosterVO;
import egovframework.ag.homepage.own.service.StillVO;
import egovframework.ag.homepage.own.service.TapeDiskVO;
import egovframework.ag.homepage.own.service.VodVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class KorService {

	@Autowired
	private KorDao korDao;

	/**
	 * 영화 정보 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMovieDetailInfo(Map<String, Object> paramMap) throws Exception {
	/*	KorVo korVo = korDao.selectMovieDetailInfo(paramMap);

		korVo.setDirectorList(korDao.selectDirectorList(korVo));
		korVo.setActerList(korDao.selectActerList(korVo));
		korVo.setHeadImgVo(korDao.selectMovieHeadImg(paramMap));
*/
		Map<String, Object> result = new HashMap<String, Object>();

		result.put("info", korDao.selectMovieDetailInfo(paramMap));
		result.put("img", korDao.selectMovieHeadImg(paramMap));
		return result;
	}


	/**
	 * VOD 정보 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVodInfo(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectVodInfo(paramMap);
	}

	/**
	 * 이미지 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectImageList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectImageList(paramMap);
	}
	/**
	 * 감독 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectDirectorList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectDirectorList(paramMap);
	}
	/**
	 * 출연진 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectActorList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectActorList(paramMap);
	}

	/**
	 * 스태프 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectStaffList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectStaffList(paramMap);
	}

	/**
	 * 영화제 수상 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStaffDivList(Map<String, Object> paramMap) throws Exception {
		return korDao.selectStaffDivList(paramMap);
	}

	/**
	 * 영화제 수상 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieAwardList(Map<String, Object> paramMap) throws Exception {
		return korDao.selectMovieAwardList(paramMap);
	}

	/**
	 * 기타 영화제 수상 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMovieAwardEtcList(Map<String, Object> paramMap) throws Exception {
		return korDao.selectMovieAwardEtcList(paramMap);
	}


	/**
	 * subDetail 정보 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSubDetailInfo(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectSubDetailInfo(paramMap);
	}

	/**
	 * 다른제목 정보 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAnotherTitleInfo(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectAnotherTitleInfo(paramMap);
	}

	/**
	 * 로케이션 리스트 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectLocationList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectLocationList(paramMap);
	}

	/**
	 * 영화 관련 리스트 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectDivList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectDivList(paramMap);
	}

	/**
	 * 영화 관련 사용자리뷰 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectUserReviewList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectUserReviewList(paramMap);
	}


	/**
	 * 영화 관련 영화 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>>  selectRelMovieList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectRelMovieList(paramMap);
	}

	/**
	 * 내가본 영화 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public int insertUserViewProc(Map<String, String> paramMap) throws Exception {
		Integer checkSnoCnt =  korDao.selectSnoCount(paramMap);
		if (checkSnoCnt == null){
			paramMap.put("snoName", "내가 본 영화");
			paramMap.put("gubun", "1");
			korDao.insertSnoInfo(paramMap);

			paramMap.put("snaName", "보고싶은 영화");
			paramMap.put("gubun", "2");
			korDao.insertSnoInfo(paramMap);
		}

		checkSnoCnt =  korDao.selectSnoCount(paramMap);
		paramMap.put("sno", String.valueOf(checkSnoCnt));

		int userViewCnt = korDao.selectUserViewCount(paramMap);
		if(userViewCnt > 0){
			return 0;
		}else{
			korDao.insertUserViewProc(paramMap);
			return 1;
		}
	}
	/**
	 * 영화 관련 Film 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<FilmVO> selectFilmList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectFilmList(paramMap);
	}
	/**
	 * 영화 관련 DcinemaVO 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<DcinemaVO> selectDcinemaList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectDcinemaList(paramMap);
	}
	/**
	 * 영화 관련 Tape 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<TapeDiskVO> selectTapeList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectTapeList(paramMap);
	}
	/**
	 * 영화 관련 DISK 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<TapeDiskVO> selectDiskList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectDiskList(paramMap);
	}


	/**
	 * 영화 관련 vod 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<VodVO> selectVodList(Map<String, Object> paramMap) throws Exception {

		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		Device device = DeviceUtils.getCurrentDevice(sra.getRequest());
		//모바일이나 태블릿 체크
        if (device != null && (device.isMobile() || device.isTablet())) {
        	paramMap.put("mobileYN", "Y");
        }

		return  korDao.selectVodList(paramMap);
	}

	/**
	 * 영화 관련 포스터 인쇄물 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<PosterVO> selectPosterList(Map<String, Object> paramMap) throws Exception {
		return  korDao.selectPosterList(paramMap);
	}


	/**
	 * 영화 관련 Still 인쇄물 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<StillVO> selectStillList(Map<String, Object> paramMap) throws Exception {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		Device device = DeviceUtils.getCurrentDevice(sra.getRequest());
		//모바일이나 태블릿 체크
        if (device != null && (device.isMobile() || device.isTablet())) {
        	paramMap.put("mobileYN", "Y");
        }

		return  korDao.selectStillList(paramMap);
	}



	/**
	 * 영화제 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
/*	public PageListVo<Map<String, Object>> selectFestivalList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectFestivalListCount(paramMap), dbDao.selectFestivalPageList(paramMap));

	}*/

	/**
	 * 영화제 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
/*	public PageListVo<Map<String, Object>> selectFestivalList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectFestivalListCount(paramMap), dbDao.selectFestivalPageList(paramMap));

	}*/

	/**
	 * 영화제 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
/*	public PageListVo<Map<String, Object>> selectFestivalList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectFestivalListCount(paramMap), dbDao.selectFestivalPageList(paramMap));

	}*/

	/**
	 * 영화제 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
/*	public PageListVo<Map<String, Object>> selectFestivalList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(dbDao.selectFestivalListCount(paramMap), dbDao.selectFestivalPageList(paramMap));

	}*/

}
