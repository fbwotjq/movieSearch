package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("dbMainFestivalAwordVo")
public class DbMainFestivalAwordVo {
	private String feaAword;
	private String feaMovie;
}
