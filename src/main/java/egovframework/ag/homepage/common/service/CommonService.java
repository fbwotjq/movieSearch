package egovframework.ag.homepage.common.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import egovframework.ag.common.vo.PageListVo;

@Service
public class CommonService {

	private final Logger logger = LogManager.getLogger();

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private CommonKfDao commonKfDao;

	@Cacheable("menuListCache")
	public List<Map<String, Object>> selectMenuList() throws Exception {

		return commonKfDao.selectMenuList();

	}
	/**
	 * 메뉴 리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectMenuList2() throws Exception {

		return commonKfDao.selectMenuList();

	}

	/**
	 * 영화글 메뉴 리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectMovieMenuList() throws Exception {

		return commonDao.selectMovieMenuList();

	}

	/**
	 * 메인 정보 리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public List<Map<String,Object>> selectMainList() throws Exception {

		return commonDao.selectMainList();

	}

	/**
	 * 메인 정보
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMainInfo(String contentTypeCd) throws Exception {

		return commonDao.selectMainInfo(contentTypeCd);

	}

	/**
	 * 메인 서브리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMainSubList(long upMainContentId) throws Exception{
		return commonDao.selectMainSubList(upMainContentId);
	}


	/**
	 * 공통 코드 조회
	 * @param codeGroupId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSearchCodeList(Map<String, Object> keyMap) throws Exception {

		try{
			Boolean existSort = false;
			Set<?> keySet = keyMap.keySet();
			Iterator<?> keyList = keySet.iterator();
			while(keyList.hasNext()) {
				String keyField = (String)keyList.next();
				if(keyField!=null && keyField.equals("sortField") && keyMap.get(keyField)!=null)	existSort = true;
			}
			if(!existSort){
				keyMap.put("sortField", "C_CODE_SUB_ID");
				keyMap.put("sortWord", "ASC");
			}
		}catch(Exception e){
			logger.debug("Exception e ==== " + e);

		}

		return commonKfDao.selectCodeList(keyMap);
	}

	/**
	 * 공통 코드 조회
	 * @param codeGroupId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCodeInfo(String codeGroupId, String codeSubId) throws Exception {
		Map<String, Object> codeMap = new HashMap<String, Object>();
		codeMap.put("codeGroupId", codeGroupId);
		codeMap.put("codeSubId", codeSubId);

		return commonKfDao.selectCodeInfo(codeMap);

	}

	/**
	 * 공통 코드 조회
	 * @param codeGroupId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSearchCodeList(String codeGroupId) throws Exception {
		Map<String, Object> searchCodeMap = new HashMap<String, Object>();
		searchCodeMap.put("codeGroupId", codeGroupId);

		return selectSearchCodeList(searchCodeMap);
	}

	/**
	 * 공통 코드 조회 하위코드 포함
	 * @param codeGroupId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCodeTreeList(Map<String, Object> keyMap) throws Exception {

		try{
			Boolean existSort = false;
			Set<?> keySet = keyMap.keySet();
			Iterator<?> keyList = keySet.iterator();
			while(keyList.hasNext()) {
				String keyField = (String)keyList.next();
				if(keyField!=null && keyField.equals("sortField") && keyMap.get(keyField)!=null)	existSort = true;
			}
			if(!existSort){
				keyMap.put("sortField", "C_CODE_SUB_ID");
				keyMap.put("sortWord", "ASC");
			}
		}catch(Exception e){
			logger.debug("Exception e ==== " + e);

		}

		return commonKfDao.selectCodeTreeList(keyMap);
	}



	/**
	 * 공지사항 목록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public PageListVo<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap) throws Exception {

		return new PageListVo<Map<String, Object>>(commonDao.selectNoticeListCount(paramMap), commonDao.selectNoticePageList(paramMap));

	}

	/**
	 * 공지사항 상세
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectNoticeInfo(long seq) throws Exception {

		commonDao.updateNoticeReadCount(seq);

		return commonDao.selectNoticeInfo(seq);
	}




}
