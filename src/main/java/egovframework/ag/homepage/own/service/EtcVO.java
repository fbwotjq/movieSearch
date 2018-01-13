package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

@Data
@Alias("etcVO")
public class EtcVO {
	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId , 'F' : fedNo
	private String movieId;
	private String movieSeq;
	private String personId;
	private String fedNo;

	private String etcNo;
	private String title  ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String titleEqual;
	private String kindClss ; //형태
	private String divClss ; //구분
	private String nationClss ; //발행국
	private String kindClssNm;
	private String divClssNm;
	private String nationClssNm;
}
