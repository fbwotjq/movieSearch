package egovframework.ag.homepage.sample.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SampleService {
	@Autowired
	private SampleDao sampleDao;
	
	public void getSample1() throws Exception {
		sampleDao.getSample1();
	}
}
