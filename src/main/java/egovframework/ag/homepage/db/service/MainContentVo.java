package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("mainContentVo")
public class MainContentVo {
	private Long mainContentId;
	private String contentTypeCd;
	private Long upMainContentId;
	private String title;
	private String subTitle;
	private String contentDesc;
	private String url;
	private int sortNo;
	private String key1;
	private String key2;
	private String key3;
	private String fileAlt;
	private String orgFileName;
	private String fileName;
}
