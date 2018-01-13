package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;

@Data
@Alias("stillVO")
public class StillVO {
	private String movieId;
	private String movieSeq;
	private String fedNo;
    private String stillNo;
    private String stillDetailNo;
    private String posterStillNo;
	private String imgid;
	private String prohibit19;
    private String mainTitle;
	private String typeClss ; //구분
	private String contensDclss ; //내용상세
	private String langClss ; //언어
	private String colorClss ; //색채
	private String personInfo ; //인물
	private String keywords ; //내용
	private String kindClss;
	private String stillNoFile ; //연계자료
	private String imageNm ; //이미지파일명
	private String stYear;
	private String hsize ; //크기
	private String vsize ; //크기
	private Long fileSize ; //용량
	private String dpValue ; //해상도
	private String colDepth ; //색심도
	private String posClss ; //보관위치
	private String typeClssNm;
	private String contensDclssNm;
	private String kindClssNm;
	private String posClssNm;

	private String titleSub = null;
	private String titleEtc = null;

	public String getFileSizeNm() {
		String size = "00";
		if (this.fileSize != null  &&  this.fileSize / 1024 > 0) {
			size = String.format("%02d", fileSize / 60);
		}
		return size + "KB";
	}

	public String getImgPath() {

		String returnImgPath = "/resources/images/common/noimage.gif";

		if(imgid == null || "".equals(imgid) || imgid.length() < 6 ){
			return returnImgPath;
		}

		String temp01 = imgid.substring(0, 2);
		String temp02 = imgid.substring(2, 4);
		String temp03 = imgid.substring(4, 6);
		String temp04 = posterStillNo.substring(0, 10);

		String startImgName = this.imageNm.substring(0, 1);
		if("N".equals(startImgName) || "L".equals(startImgName)){
			returnImgPath = Constant.MOVIE_STILL_PATH2 + temp01 + "/" + temp02 + "/" + temp03 + "/tn_" + temp04 + ".jpg";
		}else{
			returnImgPath = Constant.MOVIE_STILL_PATH1 + temp01 + "/" + temp02 + "/" + temp03 + "/tn_" + temp04 + ".jpg";
		}
		return returnImgPath;

	}
}
