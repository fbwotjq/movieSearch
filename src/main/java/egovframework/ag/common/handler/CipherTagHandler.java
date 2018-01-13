package egovframework.ag.common.handler;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import egovframework.ag.common.cipher.Cipher;

public class CipherTagHandler extends SimpleTagSupport {
	private final static Logger logger = LogManager.getLogger();
    private String encrypt;
    private String decrypt;
   
    public void setEncrypt(String encrypt) {
        this.encrypt = encrypt;
    }
	public void setDecrypt(String decrypt) {
		this.decrypt = decrypt;
	}

	@Override
	public void doTag() throws JspException, IOException {
		byte[] key = Cipher.getCipherKey();
    	String strReturn = null;
    	
		try {

			// 복호화
			if(encrypt!=null && encrypt.length()>0){
				strReturn = Cipher.decrypt(encrypt, key, key.length*8, "UTF-8");
			}

			// 암호화
			if(decrypt!=null && decrypt.length()>0){
				strReturn = Cipher.encrypt(decrypt, key, key.length*8, null);
			}

	        getJspContext().getOut().write(strReturn);
		} catch (Exception e) {

			logger.debug("CipherTagHandler Exception : " + e);

		}
    }
}
