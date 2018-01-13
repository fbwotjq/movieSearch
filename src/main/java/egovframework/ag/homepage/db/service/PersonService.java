package egovframework.ag.homepage.db.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.ag.common.util.StringUtils;

@Service
@Transactional
public class PersonService {
	@Autowired
	private PersonDao personDao;

	/**
	 * 영화인 정보 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public PersonVo selectPersonInfo(String personId) throws Exception {
		PersonVo personVo = personDao.selectPersonInfo(personId);

		if (personVo != null && StringUtils.isEmpty(personVo.getPersonId()) == false ) {
			personVo.setSpecFieldList(personDao.selectSpecFieldList(personVo));
			personVo.setActYearList(personDao.selectActYearList(personVo));
			personVo.setHeadImgVo(personDao.selectHeadImageInfo(personVo));
			personVo.setEtcTitleList(personDao.selectPersonEtcTitleList(personId));
		}

		return personVo;
	}

	/**
	 * 영화인 이미지 목록 조회
	 * @param personVo
	 * @return
	 * @throws Exception
	 */
	public List<PersonImgVo> selectImageList(String personId) throws Exception {
		return personDao.selectImageList(personId);
	}

	/**
	 * 영화인 동영상 목록 조회
	 * @param personVo
	 * @return
	 * @throws Exception
	 */
	public List<PersonMulVo> selectMulList(String personId, String mobileYn) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("personId", personId);
		paramMap.put("mobileYn", mobileYn);

		return personDao.selectMulList(paramMap);
	}

	/**
	 * 영화인 필모그라피 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<PersonFilmoVo> selectFilmoList(String personId) throws Exception {
		return personDao.selectFilmoList(personId);
	}

	/**
	 * 영화인 상세 필모그라피 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<PersonFilmoDetailVo> selectFilmoDetailList(String personId) throws Exception {
		return personDao.selectFilmoDetailList(personId);
	}

	/**
	 * 영화인 영화제 수상 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<PersonFestivalAwardsVo> selectFestivalAwardsList(String personId) throws Exception {
		return personDao.selectFestivalAwardsList(personId);
	}

	/**
	 * 영화인 기타 이름 목록 조회
	 * @param personId
	 * @return
	 * @throws Exception
	 */
	public List<String> selectPersonEtcTitleList(String personId) throws Exception {
		return personDao.selectPersonEtcTitleList(personId);
	}
}
