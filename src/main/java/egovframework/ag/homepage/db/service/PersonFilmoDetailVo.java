package egovframework.ag.homepage.db.service;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Alias("personFilmoDetailVo")
@EqualsAndHashCode(callSuper=false)
public class PersonFilmoDetailVo extends PersonFilmoVo {
	private Long filmCnt;
	private Long cineCnt;
	private Long diskCnt;
	private Long tapeCnt;
	private Long vodCnt;
	private Long snariCnt;



}
