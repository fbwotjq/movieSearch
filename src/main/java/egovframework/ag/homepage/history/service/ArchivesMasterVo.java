package egovframework.ag.homepage.history.service;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("archivesMasterVo")
public class ArchivesMasterVo {
    private Long archivesSeq;
    private Long archivesTypeCd;
    private String code01;
    private String code02;
    private String code01Name;
    private String code02Name;
    private String txtCodeName;
    private String partCode;
    private String partCodeName;
    private String txtPartCodeName;
    private String subject;
    private String targetName;
    private String birthDate;
    private String birthYear;
    private String chercheur;
    private String startDate;
    private String endDate;
    private String talkTerm;
    private String fileAlt;
    private String orgFileName;
    private String fileName;
    private String summaryDesc;
    private Long readCount;
    private String headYn;
    private String activeYn;
    private Date createDate;
    private String fileSeq;
    private String fileOrder;
    private String downYn;
    private String viewYn;
    private String freeYn;
    private String payYn;
    private Long amount;
    private String contents;

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
