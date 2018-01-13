package egovframework.ag.common.vo;

public class FileInfoVo {
	private boolean result;
	private String filePath;
	private String orgFileName;
	private String uploadFileName;
	private Long fileSize;
	private String fileContentType;

	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	@Override
	public String toString() {
		return "FileInfoVo [result=" + result + ", filePath=" + filePath
				+ ", orgFileName=" + orgFileName + ", uploadFileName="
				+ uploadFileName + ", fileSize=" + fileSize
				+ ", fileContentType=" + fileContentType + "]";
	}


}
