package egovframework.ag.homepage.story.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("webzineContentVo")
public class WebzineContentVo {
	private Long seq;
	private String subject;
	private String subTitle;
	private Long writerSeq;
	private String writerName;
	private Long upCate;
	private String upSectionSubject;
	private Long downCate;
	private String downSectionSubject;
	private String contentImgPath;
	private String content;
	private String searchKeyword;
	private String publicMark;
	private String personId;
	private String movieId;
	private String webzineSeq;
	private Date regdt;


	public String getShortNonTagContent() {
		return StringUtils.subStrLen(getNonTagContent(), 250);
	}

	public String getNonTagContent() {
		if (this.content != null && this.content.length() > 0) {
			return StringUtils.stripTags(this.content);
		}else {
			return this.content;
		}
	}

	public String getContent() {
		if (this.content != null && this.content.length() > 0) {
			return StringUtils.getStripTagByPattern(this.content);
		}else {
			return this.content;
		}
	}

	public String getInfo() {
		return this.toString();
	}

	public List<String> getPersonList() {
		List<String> personList = new ArrayList<String>();

		if (StringUtils.isEmpty(this.personId) == false) {
			String[] arrPersonId = personId.split("\\|");

			personList = Arrays.asList(arrPersonId);
		}

		return personList;
	}

	public List<Map<String, Object>> getMoveiList() {
		List<Map<String, Object>> movieList = new ArrayList<Map<String, Object>>();

		if (StringUtils.isEmpty(this.movieId) == false) {
			String[] arrMovieInfo = movieId.split("\\|");

			for (String movieInfo : arrMovieInfo) {
				String[] arrMovieId = movieInfo.split("\\,");

				Map<String, Object> movieMap = new HashMap<String, Object>();
				movieMap.put("movieId", arrMovieId[0]);
				movieMap.put("movieSeq", arrMovieId[1]);

				movieList.add(movieMap);
			}
		}

		return movieList;
	}

	public List<String> getSearchKeywordList() {
		List<String> searchKeywordList = new ArrayList<String>();

		if (StringUtils.isEmpty(this.searchKeyword) == false) {
			String[] arrSearchKeyword = this.searchKeyword.split("\\,");

			searchKeywordList = Arrays.asList(arrSearchKeyword);
		}

		return searchKeywordList;
	}

}
