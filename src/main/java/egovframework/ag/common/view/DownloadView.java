package egovframework.ag.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {

	private final static Logger logger = LogManager.getLogger();

	public DownloadView() {
		setContentType("application/octet-stream");
	}

	@SuppressWarnings("rawtypes")
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		File file = (File) model.get("downloadFile");
		String fileName = null;
		String fileMask = null;

		if(file!= null){
			fileName = file.getName();
			fileMask = (String) model.get("keyFileMask");
			if(fileMask!=null && fileMask.length()>0)
				fileName = fileMask;

			//fileName = URLEncoder.encode(fileName, "UTF-8");
			//logger.debug("fileName1 === " + fileName);
			fileName = this.getDisposition(fileName, this.getBrowser(request));
			//logger.debug("fileName2 === " + fileName);

			response.setContentType(getContentType());
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "attachment; fileName=\""
					+ fileName + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
		}
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;

		try {
			if(file!= null){
				fis = new FileInputStream(file);
				FileCopyUtils.copy(fis, out);
			}
		} catch(IOException ioe) {
			if(!ioe.getClass().getName().equals("org.apache.catalina.connector.ClientAbortException")){
				logger.debug("Download Exception : " + ioe);
			}
		} finally {
			if (fis != null){
				try {
					fis.close();
				} catch (IOException ex) {
					logger.error("Download Exception : " + ex);
				}
			}
			if (out != null){
				try {
					out.close();
				} catch (IOException ex) {
					logger.error("Download Exception : " + ex);
				}
			}
		}

		out.flush();
		out.close();

		fis = null;
		out = null;
	}

	private String getBrowser(HttpServletRequest request){
		String header = request.getHeader("User-Agent");
		if(header.indexOf("MSIE") > -1){
			return "MSIE";
		} else if(header.indexOf("Trident") > -1){
			return "Trident";
		} else if(header.indexOf("Chrome") > -1){
			return "Chrome";
		} else if(header.indexOf("Opera") > -1){
			return "Opera";
		}

		return "Firefox";
	}

	private String getDisposition (String filename, String browser) throws Exception {
		String encodedFilename = null;

		try{
			if(browser!=null){
				if(browser.equals("MSIE")) {
					encodedFilename = URLEncoder.encode(filename, "UTF-8")
						.replaceAll("\\+", "%20");
				} else if(browser.equals("Trident")) {
					encodedFilename = URLEncoder.encode(filename, "UTF-8")
							.replaceAll("\\+", "%20");
				} else if(browser.equals("Firefox")) {
					encodedFilename = new String(filename.getBytes("UTF-8"), "8859_1");
				} else if(browser.equals("Opera")) {
					encodedFilename = new String(filename.getBytes("UTF-8"), "8859_1");
				} else if(browser.equals("Chrome")) {
					StringBuffer sb = new StringBuffer();
					for(int i = 0; i < filename.length(); i++){
						char c = filename.charAt(i);
						if(c > '~'){
							sb.append(URLEncoder.encode("" + c, "UTF-8"));
						}else{
							sb.append(c);
						}
					}
					encodedFilename = sb.toString();
				}
			}
		}catch(Exception e){
			logger.debug("Exception getDisposition === " + e);

		}

		return encodedFilename;
	}

}
