package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("personMulVo")
public class PersonMulVo {
	private Long mulId;
	private Long fileId;
	private String imgid;
	private String imageNm;
	private String multorNm;
	private String mulTitle;
	private String classname;
	private String titleEtc;
	private String mulYear;
	private Long runtime;
	private int useClss;
	private Long seconds;

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

	public String getMulImgPath() {
		String subPath = StringUtils.substring(this.imgid, 0, 2)
				       + "/" + StringUtils.substring(this.imgid, 2, 4)
				       + "/" + StringUtils.substring(this.imgid, 4, 6)
				       + "/" + this.imageNm;
		return Constant.PERSON_MUL_IMG_PATH + subPath;
	}
}
