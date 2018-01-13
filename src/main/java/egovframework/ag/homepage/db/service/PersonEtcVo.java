package egovframework.ag.homepage.db.service;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class PersonEtcVo {
	private String title;
	private List<String> contentList;

	public PersonEtcVo(String title, List<String> contentList) {
		this.title = title;
		this.contentList = contentList;
	}

	public PersonEtcVo(String title, String content) {
		this.title = title;

		List<String> list = new ArrayList<String>();
		list.add(content);

		this.contentList = list;
	}
}
