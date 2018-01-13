package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("theoryVO")
public class TheoryVO {
	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId
	private String movieId;
	private String movieSeq;
	private String personId;
	private String theoryNo ; //관리번호
	private String theoryNm ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String typeClss ; //형태
	private String degreeClss ; //학위구분
	private String nationalClss ; //국가구분
	private String nationClss ; //발행국
    private String thPage ; //페이지
    private String pubYear ; //발행년도
    private String pubPlace ; //발행처
    private String thMajor ; //학과/전공명
    private String writer ; //저자
    private String thTutor ; //지도교수
    private String themeDiv ; //주제구분
    private String langClss ; //언어
    private String posClss;
    private String contensClss;
    private String typeClssNm;
    private String degreeClssNm;
    private String nationalClssNm;
    private String nationClssNm;
    private String posClssNm;
    private String contensClssNm;
}
