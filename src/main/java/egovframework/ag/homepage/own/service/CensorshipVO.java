package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("censorshipVO")
public class CensorshipVO {
	private String movieId;
	private String movieSeq;
	private String censorAllNo ; //관리번호
	private String censorNo ; //관리번호
	private String title ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String kindClss ; //형태
	private String writeDate ; //작성일
	private String writer ; //작성자
	private String ePage ; //페이지
	private String plot ; //첨부
	private String area ; //보관위치
	private String kindClssNm;
	public String getePage() {
		return ePage;
	}
	public void setePage(String ePage) {
		this.ePage = ePage;
	}


}
