package egovframework.ag.homepage.vod.service;

import java.util.Date;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("vodPayResutVo")
public class VodPayResutVo {
	private int payseq           ;
	private String mulId           ;
	private String fileId          ;
	private String movieId         ;
	private String movieSeq        ;
	private String movieTitle      ;
	private String paymethod      ;
	private Date createdon        ;
	private Date comsysdate        ;
	private Date sysdate        ;
	private int maxmoviecnt      ;
	private int resultprice      ;
	private int advencePrice      ;

}
