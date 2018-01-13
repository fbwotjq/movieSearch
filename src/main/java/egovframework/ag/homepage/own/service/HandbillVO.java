package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

@Data
@Alias("handbillVO")
public class HandbillVO {
	private String movieId;
	private String movieSeq;
	private String handbillNo ; //관리번호
	private String handblNm ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String kindClss ; //형태
	private String divClss ; //구분
	private String pubPlace ; //배급
	private String nationalClss ; //국가구분
	private String nationClss ; //발행국
	private String langClss ; //언어
	private String hPage ; //페이지
	private String posClss ; //보관위치
	private String hSize ; //크기
	private String vSize ; //크기
	private String kindClssNm;
	private String contensClssNm;
	private String divClssNm;
	private String nationalClssNm;
	private String nationClssNm;
	private String posClssNm;
	private String tnImageNm ; //썸네일
	private String imgid ; //썸네일

	public String getImgPath() {
		String imageNm = StringUtils.substringBefore(this.tnImageNm, ",");
		String subPath = StringUtils.substring(this.imgid, 0, 2)
				       + "/" + StringUtils.substring(this.imgid, 2, 4)
				       + "/" + StringUtils.substring(this.imgid, 4, 6)
				       + "/" + imageNm;
		return Constant.HANDBILL_IMG_PATH + subPath;
	}

	public String gethPage() {
		return hPage;
	}

	public void sethPage(String hPage) {
		this.hPage = hPage;
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

}
