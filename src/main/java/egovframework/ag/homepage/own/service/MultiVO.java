package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

@Data
@Alias("multiVO")
public class MultiVO {

	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId
	private String movieId;
	private String movieSeq;
	private String personId;
	private String mulId;

	private String mscreenClss ; //상영구분
	private Long runtime ; //상영시간
	private Long seconds ; //상영시간
	private String levelClss ; //관람기준
	private String colorClss ; //색채
	private String language ; //언어
	private String plot ; //내용
	private String mscreenClssNm;
	private String levelClssNm;
	private String colorClssNm;
	private String imgid;
	private String imageNm;
	private String mulTitle;
	private String titleSub;
	private String titleEtc;
	private String multorNm;

	public String getMulImgPath() {
		String subPath = StringUtils.substring(this.imgid, 0, 2)
				       + "/" + StringUtils.substring(this.imgid, 2, 4)
				       + "/" + StringUtils.substring(this.imgid, 4, 6)
				       + "/" + this.imageNm;
		return Constant.PERSON_MUL_IMG_PATH + subPath;
	}

	public String getPlayTime() {
		String time = "00";
		String min = "00";
		String sec = "00";


		if (this.runtime / 60 > 0) {
			time = String.format("%02d", this.runtime / 60);
			min = String.format("%02d", this.runtime % 60);
			sec = String.format("%02d", this.seconds);
		}else {
			min = String.format("%02d", this.runtime);
			sec = String.format("%02d", this.seconds);
		}

		return time + ":" + min + ":" + sec;
	}
}
