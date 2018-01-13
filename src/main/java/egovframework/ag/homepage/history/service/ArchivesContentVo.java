package egovframework.ag.homepage.history.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("archivesContentVo")
public class ArchivesContentVo {
	private Long archivesSeq;
    private Long detailSeq;
    private String subject;
    private String contents;
    private int sortNo;
    private Long fileSeq;
    private String fileTypeCd;
    private String fileAttrCd;
    private String fileAlt;
    private String orgFileName;
    private String fileName;
    private Long fileSize;
    private String url;
    private String downYn;
    private String viewYn;
    private String freeYn;


    public String getContents() {
		if (this.contents != null && this.contents.length() > 0) {
			return StringUtils.getStripTagByPattern(this.contents);
		}else {
			return this.contents;
		}
    }
}
