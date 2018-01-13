package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;

@Data
@Alias("posterVO")
public class PosterVO {
	private String movieId;
	private String movieSeq;
	private String fedNo;
	private String posterId;
	private String posterNo;
	private String imgid;
	private String prohibit19;
	private String mainTitle ; //본제목
    private String titleSub ; //부제목
    private String titleEtc ; //기타제목
    private String titleEqual;
	private String nationClss ; //발행국
	private String nationalClss ; //국가구분
	private String producer ; //배급
	private String posterPic ; //사진
	private String adDesign ; //디자인
	private String printInfo ; //인쇄
	private String postYear ; //개봉일
	private String rowNo ; //종번호
	private String langClss ; //언어
	private String colorClss ; //색채
	private String personNm ; //인물
	private String personInfo ; //인물
	private String copyText ; //홍보카피
	private String keywords ; //내용
	private String relDataNo ; //연계자료
	private String typeClss ; //'1' 인쇄물, '2' 파일
	private String imageNm ; //이미지파일명
	private String imgHsize ; //크기
	private String imgVsize ; //크기
	private String fileSize ; //용량
	private String dpValue ; //해상도
	private String colDepth ; //색심도
	private String posClss ; //보관위치
	private String nationClssNm;
	private String nationalClssNm;
	private String colorClssNm;
	private String typeClssNm;
	private String posClssNm;

	public String getImgPath() {
		String returnImgPath = "/resources/images/common/noimage.gif";

		if(imgid == null || "".equals(imgid) || imgid.length() < 6){
			return "";
		}

		String temp01 = imgid.substring(0, 2);
		String temp02 = imgid.substring(2, 4);
		String temp03 = imgid.substring(4, 6);

		returnImgPath = Constant.MOVIE_POSTER_PATH + temp01 + "/" + temp02 + "/" + temp03 + "/tn_" + this.imageNm;

		return returnImgPath;
	}

}
