package egovframework.ag.homepage.sample.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.ag.homepage.common.service.MailService;
import egovframework.ag.homepage.sample.service.SampleService;

@Controller
@RequestMapping("/sample")
public class SampleController {
	private final static Logger logger = LogManager.getLogger();

	@Value("${sso.token.sigin.key}")
	private String ssoTokenSignKey;

	@Autowired
	private SampleService sampleService;

	@Autowired
	private MailService mailService;


	public void findSubFiles(File parentFile, ArrayList<File> subFiles)
    {
        if(parentFile.isFile())
        {
            subFiles.add(parentFile);
        }
        else if(parentFile.isDirectory())
        {
            subFiles.add(parentFile);
            File[] childFiles= parentFile.listFiles();
            for(File childFile : childFiles)
            {
                findSubFiles(childFile, subFiles);
            }
        }
    }
	@RequestMapping("/mail")
	public void mail(HttpServletRequest request, HttpServletResponse res) throws Exception {
		boolean result = false;
		logger.info("*************메일발송 시작******************");
		try {
			Map<String, Object> formModel = new HashMap<String, Object>();
			result= mailService.sendEmail("fighting333@innodis.co.kr", "발송자", "fighting333@hanmail.net", "수신자", "메일테스트 합니다." ,"폼 파일", formModel);
			logger.info("*************메일발송 "+result+"******************");
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("*************메일발송 끝******************");
	}
	@RequestMapping("/sample1")
	public String sample1(HttpServletRequest request, HttpServletResponse res) throws Exception {
		/*
		try {
			HttpSession session = request.getSession();
			System.out.println("session id : " + session.getId());

			String ssoToken = KFTokenUtil.generateToken(ssoTokenSignKey, "tipgiveme");

			System.out.println(ssoToken);


			res.addHeader("Authorization","Bearer  " + ssoToken);

		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		return "/sample/sample1";
	}

	@RequestMapping("/sample2")
	@ResponseBody
	public Map<String, Object> sample2() throws Exception {
		Map<String, Object> testMap = new HashMap<String, Object>();
		testMap.put("1", "one");
		testMap.put("2", "two");
		testMap.put("3", "three");

		return testMap;
	}

	@RequestMapping("/sample3")
	public String sample3(HttpServletResponse res, @RequestParam(value="userId", required=true) String userId, @RequestParam(value="callbackUrl", required=true) String callbackUrl, Model model) throws Exception {

		model.addAttribute("callbackUrl", callbackUrl);


		System.out.println("userId : " + userId);

        Cookie cookie = new Cookie("userId", userId);
		cookie.setDomain("localhost");
		cookie.setPath("/");
		cookie.setMaxAge(-1);
		cookie.setVersion(0);
		cookie.setSecure(false);

		res.addCookie(cookie);


		return "/sample/sample3";
	}


	@RequestMapping(value="/htmlText")
	@ResponseBody
	public Map<String, String> htmlText(Model model) throws Exception {

		Map<String, String> resultMap = new HashMap<String, String>();


		String htmlText = "";
        htmlText += "<div class=\"item\">     ";
        htmlText += "		<div class=\"wrapper\">";
        htmlText += "			<div class=\"data\">";
        htmlText += "				<strong class=\"title\">동주1</strong>";
        htmlText += "				<span class=\"str\">감독 변성현</span>";
        htmlText += "			</div>";
        htmlText += "			<div class=\"thumb\">";
        htmlText += "				<a href=\"javascript:console.log('click')\">";
        htmlText += "					<span class=\"pic\" style=\"background-image: url('http://images.huffingtonpost.com/2016-02-16-1455604314-9400996-e5ac98341a74a29dbc50444c59432ca99479b2ee.jpg')\"></span>";
        htmlText += "					<i class=\"ico vod\">vod</i>";
        htmlText += "				</a>";
        htmlText += "			</div>";
        htmlText += "			<p class=\"text\">";
        htmlText += "				역시 마찬가지로, 단순히 고통이라는 이유 때문에 고통 그 자체를 사랑하거나 추구하거나 소유하려는 자는 없다. 다만 노역과 고통이 아주 큰 즐거움을 선사하는 상황이 때로는 발생하기 때문에 고통을 찾는 사람이 있는 것이다. 간단한 예를 들자면, 모종의 이익을 얻을 수도 없는데 힘든 육체적 노력을 기꺼이 할 사람이 우리들 중에 과연 있겠는가? 하지만 귀찮은 일이 뒤따르지 않는 즐거움을 누리는 것을 선택한 사람, 혹은 아무런 즐거움도 생기지 않는 고통을 회피하는 사람을 누가 탓할 수 있겠는가?";
        htmlText += "			</p>";
        htmlText += "		</div>";
        htmlText += "		<span class=\"cover\"></span>";
        htmlText += "	</div> ";

		resultMap.put("result", htmlText);

		return resultMap;
	}

	@RequestMapping("/play")
	public String play(Model model) throws Exception {
		return  "/pop/sample/vodPlayer";
	}
	@RequestMapping("/pdf")
	public String pdf(Model model) throws Exception {
		return  "/noLayout/sample/sample_pdf";
	}

	@RequestMapping("/pdf2")
	public String pdf2(Model model) throws Exception {

		File originalFile = new File("C://eGovFrameDev-3.5.0-64bit/workspace/KMDB_HF/src/main/webapp/resources/viewer/pdf/document1.pdf");
        String encodedBase64 = null;
        try {
            FileInputStream fileInputStreamReader = new FileInputStream(originalFile);
            byte[] bytes = new byte[(int)originalFile.length()];
            fileInputStreamReader.read(bytes);
            encodedBase64 = new String(Base64.encodeBase64(bytes));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        model.addAttribute("pdf_base_64", encodedBase64);

		return  "/sample/sample_pdf2";
	}

	@RequestMapping("/pdf3")
	public String pdf3(Model model) throws Exception {

		File originalFile = new File("C://eGovFrameDev-3.5.0-64bit/workspace/KMDB_HF/src/main/webapp/resources/viewer/pdf/document2.pdf");
        String encodedBase64 = null;
        try {
            FileInputStream fileInputStreamReader = new FileInputStream(originalFile);
            byte[] bytes = new byte[(int)originalFile.length()];
            fileInputStreamReader.read(bytes);
            encodedBase64 = new String(Base64.encodeBase64(bytes));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        model.addAttribute("pdf_base_64", encodedBase64);

		return  "/noLayout/sample/sample_pdf3";
	}

	@RequestMapping("/pdf4")
	public String pdf4(Model model) throws Exception {

		File originalFile = new File("C://eGovFrameDev-3.5.0-64bit/workspace/KMDB_HF/src/main/webapp/resources/viewer/pdf/test.pdf");
        String encodedBase64 = null;
        try {
            FileInputStream fileInputStreamReader = new FileInputStream(originalFile);
            byte[] bytes = new byte[(int)originalFile.length()];
            fileInputStreamReader.read(bytes);
            encodedBase64 = new String(Base64.encodeBase64(bytes));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        model.addAttribute("pdf_base_64", encodedBase64);
		return  "/noLayout/sample/sample_pdf4";
	}


}
