package egovframework.ag.homepage.own.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.Data;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

@Data
@Alias("equipVO")
public class EquipVO {
	private String gubun; //조건구분 'M' : movieId, movieSeq , 'P' : personId , 'F' : fedNo
	private String movieId;
	private String movieSeq;
	private String personId;
	private String fedNo;

	private String equipId;
	private String equipNo;
	private String equipDetailId;
	private String equipDetailNo;
	private String title ; //본제목
	private String titleSub ; //부제목
	private String titleEtc ; //기타제목
	private String div1Clss ; //구분
	private String div2Clss ; //분류
	private String weight ; //무게
	private String country ; //제작국가
	private String cubicClss ; //규격
	private String component ; //구성품
	private String materialClss ; //재질
	private String remarks ; //비고
	private String imageNm; // 이미지
	private String equipContent ; //내용
	private String div1ClssNm;
	private String div2ClssNm;
	private String cubicClssNm;
	private String fileNm ; //제명

	public String getImgPath() {
		if (StringUtils.isEmpty(this.imageNm) == true) {
			return Constant.NO_IMG_PATH;
		} else {
		String subPath =
				 "00/" + StringUtils.substring(this.equipNo, 2, 4)
				+ "/" + StringUtils.substring(this.equipNo, 4, 6)
				       + "/" + this.imageNm;
		return Constant.EQUIP_IMG_PATH + subPath;
		}
	}

	public String getFileSubPath() {

		String subPath =
				"00/" + StringUtils.substring(this.equipNo, 2, 4)
				+ "/" + StringUtils.substring(this.equipNo, 4, 6)
				       + "/" ;
		return  subPath;

	}
}
