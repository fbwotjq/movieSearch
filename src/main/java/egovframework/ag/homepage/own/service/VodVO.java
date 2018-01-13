package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("vodVO")
public class VodVO {
	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId
	private String movieId;
	private String movieSeq;
	private String personId;

	private String mulTitle ; //본제목
    private String titleSub ; //부제목
    private String titleEtc ; //기타제목
    private String titleEqual;
	private Long runtime ; //상영시간
	private String colorClss ; //색채
	private String mscreenClss ; //상영구분
	private String levelClss ; //관람기준
	private String language ; //언어
	private String plot ; //내용
	private String hSize ; //프레임크기
	private String vSize ; //프레임크기
	private String price ; //가격
	private String youtubeUrl;
	private String naverUrl;
	private String levelClssNm;
	private String colorClssNm;
	private String languageNm;
	private String mscreenClssNm;
	private String useClss;
	private String multorNm;

	public String getPlayTime() {
		String time = "00";
		String min = "00";


		if (this.runtime / 60 > 0) {
			time = String.format("%02d", this.runtime / 60);
			min = String.format("%02d", this.runtime % 60);
		}else {
			min = String.format("%02d", this.runtime);
		}

		return time + ":" + min ;
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
