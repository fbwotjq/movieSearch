package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("newsVO")
public class NewsVO {
	private String movieId;
	private String movieSeq;
	private String newsNo;
	private String newsNm ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String kindClss ; //형태
	private String nationClss ; //발행국
	private String nationalClss ; //국가구분
	private String nPage ; //페이지
	private String pubPlace ; //배급
	private String kindClssNm;
	private String nationalClssNm;
	private String nationClssNm;
	public String getnPage() {
		return nPage;
	}
	public void setnPage(String nPage) {
		this.nPage = nPage;
	}

}
