package egovframework.ag.homepage.story.service;

import java.util.List;

import lombok.Data;

import org.apache.ibatis.type.Alias;

/**
 * 영화글 관련 영화 VO
 * @author tipgi
 *
 */
@Data
@Alias("movieStoryRelMovieVo")
public class MovieStoryRelMovieVo {
	private Long storySeq;
	private Long seq;
	private String movieId;
	private String movieSeq;
	private String title;
	private String orgTitle;
	private String enTitle;
	private String director;
	private String prodYear;
	private List<MovieStoryVo> movieStoryList;
}
