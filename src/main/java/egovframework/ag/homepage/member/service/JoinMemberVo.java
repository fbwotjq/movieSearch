package egovframework.ag.homepage.member.service;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias(value="joinMemberVo")
public class JoinMemberVo implements Serializable {
	private static final long serialVersionUID = -4463206603074142895L;

	private String joinType;
	private String dupInfo;
	private String userName;
	private String birthDate = "YYYYMMDD";
	private String sexCode = "M";

	private String userId;
	private String password;
	private String zipCd;
	private String address;
	private String detailAddress;
	private String cellNo1;
	private String cellNo2;
	private String cellNo3;
	private String cellNo;
	private String emailId;
	private String emailDomain;
	private String mailAddr;
	private String jobCode;
	private String[] frequentlyService;
	private String[] preferenceMovie;
	private String receiveCd;

	public String getBirthYear() {
		return this.birthDate.substring(0,4);
	}
	public String getBirthMonth() {
		return this.birthDate.substring(4,6);
	}
	public String getBirthDay() {
		return this.birthDate.substring(6,8);
	}

	public String getSex() {
		if (sexCode.equals("M")) {
			return "남자";
		}else {
			return "여자";
		}
	}

	public String getCellNo1FromCellNo() {
		return cellNo.split("-")[0];
	}

	public String getCellNo2FromCellNo() {
		return cellNo.split("-")[1];
	}

	public String getCellNo3FromCellNo() {
		return cellNo.split("-")[2];
	}

	public String getEmailIdFromMailAddr() {
		return mailAddr.split("@")[0];
	}

	public String getEmailDomainFromMailAddr() {
		return mailAddr.split("@")[1];
	}

	public String getFrequentlyServiceStrList() {
		if (frequentlyService != null) {
			return StringUtils.join(frequentlyService, ",");
		}else {
			return null;
		}
	}

	public String getPreferenceMovieStrList() {
		if (preferenceMovie != null) {
			return StringUtils.join(preferenceMovie, ",");
		}else {
			return null;
		}
	}
}
