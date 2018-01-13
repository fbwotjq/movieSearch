package egovframework.ag.homepage.common.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface CommonDao {


	public List<Map<String, Object>>  selectMainList() throws Exception;

	public List<Map<String, Object>>  selectMovieMenuList() throws Exception;

	public Map<String, Object> selectMainInfo(String contentTypeCd) throws Exception;

	public List<Map<String, Object>> selectMainSubList(long upMainContentId) throws Exception;

	public int selectNoticeListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectNoticePageList(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectNoticeInfo(long seq) throws Exception;

	public void updateNoticeReadCount(long seq) throws Exception;

}
