package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("dcinemaVO")
public class DcinemaVO {
	private String movieId;
	private String movieSeq;
	private String formClss; // 파일종류
	private String classClss; // 구분
	private String formatClss; // 파일형식
	private String screenSize; // 해상도
	private String pictureRatio; //화면비
	private String colorMode; // 컬러모드
	private String soundChannel; // 사운드채널수
	private String methodClss; // 입수방법
	private String formClssNm; // 파일종류
	private String classClssNm; //구분
	private String formatClssNm; // 파일형식
	private String screenSizeNm; //  해상도
	private String pictureRatioNm; //화면비
	private String colorModeNm; // 컬러모드
	private String methodClssNm; // 입수방법
	private String dDetailNo; // 관리번호


	public String getdDetailNo() {
		return dDetailNo;
	}
	public void setdDetailNo(String dDtailNo) {
		this.dDetailNo = dDtailNo;
	}
}
