package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

@Data
@Alias("tapeDiskVO")
public class TapeDiskVO {
	private String movieId;
	private String movieSeq;

	private String  devClss; //규격
	private String  compy; //제조사
	private String  vCompany; //제조회사
	private String  vSale; //판매원
	private String  nationalClss; //제작국가
	private String  prodYear; //제조년도
	private String  vCnt ; //수량
	private String  langClss; //언어
	private String  capClss; //자막
	private String  vTapebun; //매체분량
	private String  barcode; //바코드
	private String  levelClss; //관람기준
	private String  cnsNo; //심의번호
	private String  cnsDate; //심의일자
	private String  screenClss; //화면종류
	private String  colorClss; //색채
	private String  runtime; //상영시간
	private String  vRmethod; //녹화방식
	private String  ntscClss; //ntsc
	private String  posClss; //보관위치
	private String  addtionalImg; //부가영상
	private String  supplement; //부록
	private String  contents;		//내용
	private String  devClssNm; //규격
	private String  nationalClssNm; //제작국가
	private String  levelClssNm; //관람기준
	private String  colorClssNm; //색채
	private String  videoNo; //관리번호
	private String  vFile; //파일이름
	private String  titles; //제목
	private String  titleSub; //부제목
	private String  titleEtc; //기타제목
	private String  tNo; //이미지 경로
	private String  screenClssNm; //화면종류
	private String  vRmethodNm; //녹화종류
	private String  posClssNm; //보관위치종류
	private String  ntscClssNm; //NTSC종류

	public String getImgPath() {

		if (StringUtils.isEmpty(this.vFile) == true) {
			return Constant.NO_IMG_PATH;
		}else {
			if(this.tNo == null || "".equals(this.tNo) || tNo.length() < 6){
				return Constant.NO_IMG_PATH;
			}
			String temp01 = StringUtils.substring(this.tNo, 0, 2);
			String temp02 = StringUtils.substring(this.tNo, 2, 4);
			String temp03 = StringUtils.substring(this.tNo, 4, 6);

			return  Constant.VIDEO_POSTER_PATH + temp01 + "/" + temp02 + "/" + temp03 + "/" + this.vFile;

		}
	}

	public String getvCompany() {
		return vCompany;
	}

	public void setvCompany(String vCompany) {
		this.vCompany = vCompany;
	}

	public String getvSale() {
		return vSale;
	}

	public void setvSale(String vSale) {
		this.vSale = vSale;
	}

	public String getvCnt() {
		return vCnt;
	}

	public void setvCnt(String vCnt) {
		this.vCnt = vCnt;
	}

	public String getvTapebun() {
		return vTapebun;
	}

	public void setvTapebun(String vTapebun) {
		this.vTapebun = vTapebun;
	}

	public String getvRmethod() {
		return vRmethod;
	}

	public void setvRmethod(String vRmethod) {
		this.vRmethod = vRmethod;
	}

	public String getvFile() {
		return vFile;
	}

	public void setvFile(String vFile) {
		this.vFile = vFile;
	}

	public String gettNo() {
		return tNo;
	}

	public void settNo(String tNo) {
		this.tNo = tNo;
	}

	public String getvRmethodNm() {
		return vRmethodNm;
	}

	public void setvRmethodNm(String vRmethodNm) {
		this.vRmethodNm = vRmethodNm;
	}


}
