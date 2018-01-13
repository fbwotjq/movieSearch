package egovframework.ag.homepage.db.service;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Alias("dbMainThemeVo")
@EqualsAndHashCode(callSuper=true)
public class DbMainThemeVo extends MainContentVo {
	private Long idx;
	private String keywordname;
	private String filenm;

	private List<DbMainThemeMovieVo> movieList;
}
