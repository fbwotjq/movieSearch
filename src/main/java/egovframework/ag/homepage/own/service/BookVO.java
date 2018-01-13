package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("bookVO")
public class BookVO {
	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId
	private String movieId;
	private String movieSeq;
	private String personId;

	private String typeClss ; //형태
	private String contensClss ; //구분
	private String bookNo; //관리번호
	private String bookNm ; //제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String oriBnm ; //본서명
	private String cTtlNm ; //총서명
	private String nationalClss ; //국가구분
	private String nationClss ; //발행국
	private String writer ; //저자
	private String translator ; //역자
	private String editor ; //편저자
	private String director ; //총괄책임자
	private String pubPlace ; //발행처
	private String pubYear ; //발행년도
	private String hSize ; //크기
	private String vSize ; //크기
	private String bPage ; //페이지
	private String pageClss ; //페이지
	private String langClss ; //언어
	private String bCopy ; //판차
	private String supplement ; //부록
	private String themeDiv ; //주제구분
	private String posClss ; //보관위치
	private String mngno ; //배가번호
	private String keywords ; //키워드
	private String note ; //내용
	private String typeClssNm;
	private String contensClssNm;
	private String nationalClssNm;
	private String nationClssNm;
	public String getcTtlNm() {
		return cTtlNm;
	}
	public void setcTtlNm(String cTtlNm) {
		this.cTtlNm = cTtlNm;
	}
	public String gethSize() {
		return hSize;
	}
	public void sethSize(String hSize) {
		this.hSize = hSize;
	}
	public String getvSize() {
		return vSize;
	}
	public void setvSize(String vSize) {
		this.vSize = vSize;
	}
	public String getbPage() {
		return bPage;
	}
	public void setbPage(String bPage) {
		this.bPage = bPage;
	}
	public String getbCopy() {
		return bCopy;
	}
	public void setbCopy(String bCopy) {
		this.bCopy = bCopy;
	}


}
