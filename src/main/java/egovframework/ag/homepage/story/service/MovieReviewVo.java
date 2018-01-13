package egovframework.ag.homepage.story.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("movieReviewVo")
public class MovieReviewVo {
	private Long reviewSeq;
	private Long movieSeq;
	private Long readCount;
	private String subject;
	private String createName;
	private String contentDesc;
	private String movieId;
	private String createId;
	private String createDate;
	private String movieTitle;
	private String director;
	private String prodYear;

	public String getShortNonTagContentDesc() {
		return StringUtils.subStrLen(getNonTagContentDese(), 250);
	}

	public String getNonTagContentDese() {
		if (this.contentDesc != null && this.contentDesc.length() > 0) {
			return StringUtils.stripTags(this.contentDesc);
		}else {
			return this.contentDesc;
		}
	}

	public String getContentDesc() {
		if (this.contentDesc != null && this.contentDesc.length() > 0) {
			return StringUtils.getStripTagByPattern(this.contentDesc);
		}else {
			return this.contentDesc;
		}
	}

	public String getInfo() {
		return this.toString();
	}
}
