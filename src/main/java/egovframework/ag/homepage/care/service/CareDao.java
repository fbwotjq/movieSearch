package egovframework.ag.homepage.care.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface CareDao {

	public int selectGuideListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectGuidePageList(Map<String, Object> paramMap) throws Exception;

	public Map<String, Object> selectGuideInfo(long seq) throws Exception;

	public int updateGuideCount(long seq) throws Exception;

	public int insertPayResult(Map<String, String> paramMap) throws Exception;

	public int insertMovieman(Map<String, String> paramMap) throws Exception;

	public int insertAsk(Map<String, String> paramMap) throws Exception;

	public Map<String, Object> selectVodCompany(long seq) throws Exception;

	public int updateCompanyPay(Map<String, String> paramMap) throws Exception;

	public int selectFaqListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectFaqPageList(Map<String, Object> paramMap) throws Exception;

	public int deleteVodCart(Map<String, String> paramMap) throws Exception;

}
