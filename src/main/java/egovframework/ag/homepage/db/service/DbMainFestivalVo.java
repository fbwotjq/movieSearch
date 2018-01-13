package egovframework.ag.homepage.db.service;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Alias("dbMainFestivalVo")
@EqualsAndHashCode(callSuper=true)
public class DbMainFestivalVo extends MainContentVo {
	private Long feNo;
	private String fedNo;
	private String fedYear;
	private String festivalName;
	private List<DbMainFestivalAwordVo> awordList;

}
