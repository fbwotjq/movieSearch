package egovframework.ag.homepage.db.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;

@Data
@Alias("personVo")
public class PersonVo {
	private String personId;
	private String kornm;// 한국어 이름
	private String chinm;// 한자 이름
	private String engnm;// 영문 이름
	private String birthDate; // 출생일
	//private String birthYear; // 출생년
	private String lifeYn; // 생존여부
	private String deathdate; // 사망일
	//private String deathYear; // 사망년
	private List<String> specFieldList;// 대표분야 목록
	private String debutyear; // 데뷔년도
	private String debutprod;// 데뷔 작품
	private List<String> actYearList; // 활동년도 목록
	private String career;
	private String entranceback;
	private String majorMovies;
	private String majorEtc;
	private String attaprodreso;
	private String speech;
	private String sights;
	private String stylecast;
	private String onesintrohobby;
	private String noticeStaff;
	private String supportStaff;
	private String likeStaff;
	private String advice;
	private String bestMovie;
	private String mean;
	private String obstruction;
	private String writings;
	private String awardMovies;
	private String awardEtc;
	private List<String> etcTitleList;


	private PersonImgVo headImgVo;//영화인 대표 이미지 정보


	public String getBirthYear() {
		String year = "";
		try {
			year = StringUtils.substring(this.birthDate, 0, 4);
		}catch(Exception e) {
			year = "";
		}

		if (year == null || year.equals("0000")) {
			year = "";
		}

		return year;
	}

	public String getDeathYear() {
		String year = "";
		try {
			year = StringUtils.substring(this.deathdate, 0, 4);
		}catch(Exception e) {
			year = "";
		}

		if (year == null || year.equals("0000")) {
			year = "";
		}

		return year;
	}

	public String getBirthInfo() {
		if (StringUtils.isEmpty(getBirthYear()) == true && StringUtils.isEmpty(getDeathYear())) {
			return "";
		}else {
			return getBirthYear() + " ~ " + getDeathYear();
		}
	}

	public String getDebutInfo() {
		String debutprod = getDebutprod();

		boolean isExistDebutProd = StringUtils.isEmpty(debutprod);
		return StringUtils.getString(getDebutprod())  + (isExistDebutProd ? "" : " ") + StringUtils.getString(getDebutyear());
	}

	public String getSpecFieldListString() {
		return StringUtils.join(this.specFieldList.toArray(new String[this.specFieldList.size()]), ", ");
	}

	public String getActYearListString() {
		return StringUtils.join(this.actYearList.toArray(new String[this.actYearList.size()]), ", ");
	}


	public List<PersonEtcVo> getPersonEtcList() {
		List<PersonEtcVo> personEtcList = new ArrayList<PersonEtcVo>();

		//기타이름
		List<String> etcTitleList = new ArrayList<String>();

		String strEtcTitle  = getEtcTitleString();
		if (StringUtils.isEmpty(strEtcTitle) == false) {
			etcTitleList.add(strEtcTitle);
			personEtcList.add(new PersonEtcVo("기타이름", etcTitleList));
		}

		if (StringUtils.isEmpty(this.entranceback) == false) {
			personEtcList.add(new PersonEtcVo("영화계 입문배경", getStringList(this.entranceback, "\r\n")));
		}
		if (StringUtils.isEmpty(this.majorMovies) == false) {
			personEtcList.add(new PersonEtcVo("주요 영화작품", getStringList(this.majorMovies, "\\/")));
		}
		if (StringUtils.isEmpty(this.majorEtc) == false) {
			personEtcList.add(new PersonEtcVo("주요기타작품", getStringList(this.majorEtc, "\\/")));
		}
		if (StringUtils.isEmpty(this.attaprodreso) == false) {
			personEtcList.add(new PersonEtcVo("애착작품 및 사유", getStringList(this.attaprodreso, "\\/")));
		}
		if (StringUtils.isEmpty(this.speech) == false) {
			personEtcList.add(new PersonEtcVo("하고싶은 말", getStringList(this.speech, "\\/")));
		}
		if (StringUtils.isEmpty(this.sights) == false) {
			personEtcList.add(new PersonEtcVo("영화속 명소", getStringList(this.sights, "\\/")));
		}
		if (StringUtils.isEmpty(this.stylecast) == false) {
			personEtcList.add(new PersonEtcVo("추구하는 스타일/배역", getStringList(this.stylecast, "\\/")));
		}
		if (StringUtils.isEmpty(this.onesintrohobby) == false) {
			personEtcList.add(new PersonEtcVo("자기소개 및 취미", getStringList(this.onesintrohobby, "\\/")));
		}
		if (StringUtils.isEmpty(this.noticeStaff) == false) {
			personEtcList.add(new PersonEtcVo("주목하는 영화인", getStringList(this.noticeStaff, "\\/")));
		}
		if (StringUtils.isEmpty(this.supportStaff) == false) {
			personEtcList.add(new PersonEtcVo("지지하는 영화인", getStringList(this.supportStaff, "\\/")));
		}
		if (StringUtils.isEmpty(this.likeStaff) == false) {
			personEtcList.add(new PersonEtcVo("좋아하는 영화인", getStringList(this.likeStaff, "\\/")));
		}
		if (StringUtils.isEmpty(this.advice) == false) {
			personEtcList.add(new PersonEtcVo("한국영화 발전방안", getStringList(this.advice, "\\/")));
		}
		if (StringUtils.isEmpty(this.bestMovie) == false) {
			personEtcList.add(new PersonEtcVo("베스트영화", getStringList(this.bestMovie, "\\/")));
		}
		if (StringUtils.isEmpty(this.mean) == false) {
			personEtcList.add(new PersonEtcVo("본인 작업의 의의", getStringList(this.mean, "\\/")));
		}
		if (StringUtils.isEmpty(this.obstruction) == false) {
			personEtcList.add(new PersonEtcVo("한국영화 발전의 장애물", getStringList(this.obstruction, "\\/")));
		}
		if (StringUtils.isEmpty(this.writings) == false) {
			personEtcList.add(new PersonEtcVo("저술내역", getStringList(this.writings, "\\/")));
		}
		if (StringUtils.isEmpty(this.awardMovies) == false) {
			personEtcList.add(new PersonEtcVo("수상내역(영화)", getStringList(this.awardMovies, "\r\n")));
		}
		if (StringUtils.isEmpty(this.awardEtc) == false) {
			personEtcList.add(new PersonEtcVo("수상내역(기타)", getStringList(this.awardEtc, "\r\n")));
		}


		return personEtcList;
	}

	public String getEtcTitleString() {
		if (this.etcTitleList != null && this.etcTitleList.size() > 0) {
			return StringUtils.join(this.etcTitleList.toArray(new String[this.etcTitleList.size()]), ", ");
		}else {
			return "";
		}
	}

	public List<String> getAwardMoviesList() {
		return getStringList(this.awardMovies, "\r\n");
	}

	public List<String> getAwardEtcList() {
		return getStringList(this.awardEtc, "\r\n");
	}

	public List<String> getCareerList() {
	    List<String> resultList = new ArrayList<String>();

		if (StringUtils.isEmpty(this.career) == false) {
			List<String> firstResultList =  Arrays.asList(this.career.split("\r\n"));

			for (String str : firstResultList) {
				if (StringUtils.isEmpty(str) == false) {
					if (str.indexOf("/") > 0) {
						resultList.addAll(Arrays.asList(str.split("\\/")));
					}else if (str.indexOf("\\") > 0) {
						resultList.addAll(Arrays.asList(str.split("\\\\")));
					}else {
						resultList.add(str);
					}
				}
			}
		}


		return resultList;
	}

	private List<String> getStringList(String str, String splitStr) {
		List<String> resultList = new ArrayList<String>();

		if (StringUtils.isEmpty(str) == false) {
			List<String> firstResultList =  Arrays.asList(str.split("\r\n"));

			if (splitStr.equals("\r\n")) {
				return firstResultList;
			}

			for (String firstResultStr : firstResultList) {
				//if (StringUtils.isEmpty(firstResultStr) == false) {
					resultList.addAll(Arrays.asList(firstResultStr.split(splitStr)));
				//}
			}
		}
		return resultList;
	}
}
