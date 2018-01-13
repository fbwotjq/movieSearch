package egovframework.ag.homepage.common.service;

import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	private final static Logger logger = LogManager.getLogger();

	@Value(value="${active.type}")
	private String activeType;

	@Autowired
	private JavaMailSender mailSender;

	public boolean sendEmail(String fromEmail, String fromName, String toEmail, String toName, String subject , String formFileName, Map<String, Object> formModel ) {
		boolean result = false;

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			String bodyText = "";

			messageHelper.setSubject(subject);
			messageHelper.setText("<html>테스트입니다.</html>", true);
			messageHelper.setFrom(new InternetAddress(fromEmail, fromName, "UTF-8"));
			messageHelper.addTo(new InternetAddress(toEmail, toName, "UTF-8"));

			if (activeType.equals("LIVE") || activeType.equals("TEST")) {
				mailSender.send(message);
			}else {

				logger.debug("##########################################################################################");
				logger.debug("from email : " + fromEmail);
				logger.debug("from name : " + fromName);

				logger.debug("to email : " + toEmail);
				logger.debug("to name : " + toName);

				logger.debug("subject : " + subject);

				logger.debug("formFileName : " + formFileName);
				logger.debug("formModel :" + formModel.toString());

				logger.debug("body\n");
				logger.debug(bodyText);

				logger.debug("##########################################################################################");
			}

			result = true;
		}catch(Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
