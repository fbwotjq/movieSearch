package egovframework.ag.common.vo;

import java.util.List;

public class PageListVo<T> {
	private int totalCount = 0;
	private List<T> resultList;

	public PageListVo(int totalCount, List<T> resultList) {
		this.totalCount = totalCount;
		this.resultList = resultList;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public List<T> getResultList() {
		return resultList;
	}

	public void setResultList(List<T> resultList) {
		this.resultList = resultList;
	}
}
