package egovframework.ag.homepage.db.service;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.apache.ibatis.type.Alias;

@Data
@Alias("dbMainMovieListVo")
@EqualsAndHashCode(callSuper=true)
public class DbMainMovieListVo extends MainContentVo {
	private Long movielistId;
	private String movielistNo;
	private String movielistName;
}
