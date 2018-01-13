package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("dbMainThemeMovieVo")
public class DbMainThemeMovieVo {
	public static final String IMG_FILE_HEAD = "tn_";

	private String movieId;
	private String movieSeq;
	private String title;
	private String prodYear;
	private String director;
	private String tno;
	private String filename;


	public String getPosterPath() {
		if (StringUtils.isEmpty(this.filename) == true) {
			return Constant.NO_IMG_PATH;
		} else {
			String subPath = StringUtils.substring(this.tno, 0, 2)
					+ "/" + StringUtils.substring(this.tno, 2, 4) + "/"
					+ StringUtils.substring(this.tno, 4, 6) + "/"
					+ IMG_FILE_HEAD + this.filename;

			return Constant.MOVIE_POSTER_PATH + subPath;
		}
	}
}
