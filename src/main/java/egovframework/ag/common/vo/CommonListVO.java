package egovframework.ag.common.vo;



import java.util.List;

public class CommonListVO {

	private int page;
	private int commonCount;
	private int pageSize;
	private List<CommonListVO> messages;
	private int totalPageCount;

	public CommonListVO(int page, int pageSize, int commonCount, List<CommonListVO> messages) {
		this.page = page;
		this.commonCount = commonCount;
		this.pageSize = pageSize;
		this.messages = messages;
		this.totalPageCount = calculateTotalPageCount();
	}

	public CommonListVO(String commonId, List<CommonListVO> messages) {
		this.messages = messages;
	}

	private int calculateTotalPageCount() {
		int pageCount = commonCount / pageSize;
		if (commonCount > 0 && commonCount % pageSize == 0){
			pageCount++;
		}
		return pageCount;
	}

	public int getPage() {
		return page;
	}

	public int getTotalCount() {
		return commonCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public List<CommonListVO> getMessages() {
		return messages;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

}
