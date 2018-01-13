package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

@Data
@Alias("ostVO")
public class OstVO {
	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId
	private String movieId;
	private String movieSeq;
	private String personId;

	private String recordId;
	private String recordNo;
	private String title ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String recordClss ; //종류
	private String image ; //이미지
	private String devClss ; //규격
	private String nationClss ; //제작국가
	private String prodNo ; //제작국가
	private String prodCompy ; //제작사
	private String lable ; //레이블
	private String prodYear ; //제작년도
	private String outer ; //배급사
	private String totalTime ; //총영주시간
	private String barcode;
	private String rectypeClss1 ; //오디오채널
	private String rectypeClss2 ; //녹음방식
	private String recordClssNm;
	private String devClssNm;
	private String rectypeClss1Nm;
	private String rectypeClss2Nm;

	public String getImgPath() {
		if (StringUtils.isEmpty(this.image) == true) {
			return Constant.NO_IMG_PATH;
		} else {
		String subPath =	this.recordClss
				       + "/" + StringUtils.substring(this.recordNo, 2, 4)
				       + "/" + StringUtils.substring(this.recordNo, 4, 6)
				       + "/" + this.image;
		return Constant.RECORD_IMG_PATH + subPath;
		}
	}

}
