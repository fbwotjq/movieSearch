package egovframework.ag.homepage.db.service;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Alias("dbMainKeywordVo")
@EqualsAndHashCode(callSuper=true)
public class DbMainKeywordVo extends MainContentVo {
	private List<MainContentVo> tagList;
}
