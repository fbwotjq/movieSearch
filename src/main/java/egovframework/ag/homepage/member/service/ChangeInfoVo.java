package egovframework.ag.homepage.member.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ChangeInfoVo")
public class ChangeInfoVo {
	private String userId;
	private String zipCd;
	private String address;
	private String detailAddress;
	private String cellNo1;
	private String cellNo2;
	private String cellNo3;
	private String emailId;
	private String emailDomain;
	private String receiveCd;

	public String getCellNo() {
		return cellNo1 + "-" + cellNo2 + "-" + cellNo3;
	}

	public String getMailAddr() {
		return emailId + "@" + emailDomain;
	}
}