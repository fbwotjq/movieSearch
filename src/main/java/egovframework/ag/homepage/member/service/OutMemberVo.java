package egovframework.ag.homepage.member.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("OutMemberVo")
public class OutMemberVo {
	private String userId;
	private String userName;
	private String withdrawalCategory;
	private String withdrawalReason;
	private String withdrawalDate;
}
