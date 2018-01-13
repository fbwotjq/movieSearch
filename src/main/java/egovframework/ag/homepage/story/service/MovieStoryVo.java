package egovframework.ag.homepage.story.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("movieStoryVo")
public class MovieStoryVo {
	private Long storySeq;
	private Long storyDivSeq;
	private String storyDivTitle;
	private String subDiv;
	private String subDiv2;
	private String title;
	private String subTitle;
	private Long writerSeq;
	private String writerName;
	private String regitDate;
	private String fileAlt;
	private String orgFileName;
	private String fileName;
	private String contentDesc;
	private String creditsDesc;
	private String searchKeyword;
	private String publicMark;
	private String copyProtectionYn;

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

	public String getCreditsDesc() {
		if (this.creditsDesc != null && this.creditsDesc.length() > 0) {
			return StringUtils.getStripTagByPattern(this.creditsDesc);
		}else {
			return this.creditsDesc;
		}
	}

	public List<String> getSearchKeywordList() {
		List<String> searchKeywordList = new ArrayList<String>();

		if (StringUtils.isEmpty(this.searchKeyword) == false) {
			String[] arrSearchKeyword = this.searchKeyword.split("\\,");

			searchKeywordList = Arrays.asList(arrSearchKeyword);
		}

		return searchKeywordList;
	}

	public String getInfo() {
		return this.toString();
	}
}
