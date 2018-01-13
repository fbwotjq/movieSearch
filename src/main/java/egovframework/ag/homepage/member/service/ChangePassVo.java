package egovframework.ag.homepage.member.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("changePassVo")
public class ChangePassVo {
	private String activeType;
	private String userId;
	private String password;
	private String checkPassword;
	private String encodePassword;
}
