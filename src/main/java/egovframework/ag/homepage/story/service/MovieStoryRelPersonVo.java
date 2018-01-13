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
@Alias("movieStoryRelPersonVo")
public class MovieStoryRelPersonVo {
	private Long storySeq;
	private Long seq;
	private String personId;
	private String name;
	private String personfield;
	private String birthDate;
	private String birthYear;
	private String deathDate;
	private String deathYear;
	private List<MovieStoryVo> movieStoryList;
}
