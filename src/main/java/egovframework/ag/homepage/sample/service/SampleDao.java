package egovframework.ag.homepage.sample.service;

import java.util.List;
import java.util.Map;

import egovframework.ag.common.annotation.KMDBMapper;

@KMDBMapper
public interface SampleDao {
	public List<Map<String, Object>> getSample1() throws Exception;
}
