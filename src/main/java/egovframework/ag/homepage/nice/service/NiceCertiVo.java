package egovframework.ag.homepage.nice.service;

import java.io.Serializable;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("niceCertiVo")
public class NiceCertiVo implements Serializable {

	private static final long serialVersionUID = 7408527967427912295L;

	private String findType;

	private String userId;
	private String userName;
	private String dupInfo;

	private String mailId;
	private String mailDomain;
	private String mailAddr;

	private String resultUserId;
	private String resultMaskUserId;


	public String getMailAddr() {
		return mailId + "@" + mailDomain;
	}


	public String getResultMaskUserId() {
		if (this.resultUserId != null) {
			return this.resultUserId.substring(0,  this.resultUserId.length() -2) + "**";
		}else {
			return "**";
		}
	}

}
