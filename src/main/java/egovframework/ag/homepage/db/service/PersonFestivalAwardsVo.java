package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("personFestivalAwardsVo")
public class PersonFestivalAwardsVo {
	private String fedYear;
	private String nameKor;
	private String fedTime;
	private String feaAword;
	private String feaMovie;
	private String feaMoviecode;
	//private String movieid;
	//private String movieSeq;
	private String fPersName;
	private String fPersId;
	private Long feNo;
	private Long fedNo;


	public String getMovieId() {
		return StringUtils.substring(this.feaMoviecode, 0, 1);
	}

	public String getMovieSeq() {
		return StringUtils.substring(this.feaMoviecode, 1);
	}
}
