package egovframework.ag.common.handler;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import egovframework.ag.common.util.DownloadTokenUtils;

public class DownloadTokenTagHandler extends SimpleTagSupport {
	private final static Logger logger = LogManager.getLogger();

	@Override
	public void doTag() throws JspException, IOException {
    	String strReturn = null;

		try {

			strReturn = DownloadTokenUtils.setToken();

	        getJspContext().getOut().write(strReturn);
		} catch (Exception e) {

			logger.debug("DownloadTokenTagHandler Exception : " + e);

		}
    }
}
