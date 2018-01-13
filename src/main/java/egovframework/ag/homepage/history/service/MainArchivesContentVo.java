package egovframework.ag.homepage.history.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("mainArchivesContentVo")
public class MainArchivesContentVo {
	private Long mainContentId;
    private Long archivesSeq;
    private Long fileseq;
    private String subject;
    private String targetName;
    private String fileAlt;
    private String fileName;
    private String orgFileName;
    private String contents;
    private String gallaryFileAlt;
    private String gallaryFileName;
    private String gallaryOrgFileName;

    public String getContents() {
		if (this.contents != null && this.contents.length() > 0) {
			return StringUtils.getStripTagByPattern(this.contents);
		}else {
			return this.contents;
		}
    }

	public String getNonTagContents() {
		if (this.contents != null && this.contents.length() > 0) {
			return StringUtils.stripTags(this.contents);
		}else {
			return this.contents;
		}
	}
}
