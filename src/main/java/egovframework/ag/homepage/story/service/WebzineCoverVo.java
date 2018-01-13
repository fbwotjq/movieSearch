package egovframework.ag.homepage.story.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;


@Data
@Alias("webzineCoverVo")
public class WebzineCoverVo {
	private Long seq;
	private Long upcate;
	private String reldate;
	private String subject;
	private String content;
	private String coverImgPath;
	private String pdfPath;
	private String pdfFileName;
	private Long preSeq;
	private Long nextSeq;


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

}
