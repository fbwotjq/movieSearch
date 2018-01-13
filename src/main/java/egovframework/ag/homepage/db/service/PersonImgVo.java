package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;
import lombok.Data;

@Data
@Alias("personImgVo")
public class PersonImgVo {
	public static final String IMG_FILE_HEAD = "tn_";

	private Long stillId; //스틸 아이디
	private String stillNm; //스틸명
	private String prepersonId;
	private String imageNm; //이미지 명
	private String ord;

	public String getImgPath() {
		if (StringUtils.isEmpty(this.imageNm) == true) {
			return Constant.NO_IMG_PATH;
		} else {
			String subPath = StringUtils.substring(this.prepersonId, 0, 2)
					+ "/" + StringUtils.substring(this.prepersonId, 2, 4) + "/"
					+ StringUtils.substring(this.prepersonId, 4, 6) + "/"
					+ IMG_FILE_HEAD + this.imageNm;

			if (StringUtils.getString(ord).equals("1")) {
				return Constant.PERSON_IMG_PATH1 + subPath;
			} else {
				return Constant.PERSON_IMG_PATH2 + subPath;
			}
		}
	}
}
