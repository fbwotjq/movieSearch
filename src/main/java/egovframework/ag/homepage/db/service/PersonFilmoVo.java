package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("personFilmoVo")
public class PersonFilmoVo {
	private Long creditGroupCnt;
	private String creditId;
	private String creditNm;
	private String movieId;
	private String movieSeq;
	private String title;
	private String director;
	private String prodYear;
	private String typeClss;
	private String staff;



}
