package egovframework.ag.homepage.common.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.ag.common.util.ReferenceUtils;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.vo.PageListVo;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.common.service.CommonService;

@Controller
public class CommonController {

	@Autowired
	private CommonService commonService;

	@RequestMapping("")
	private String index() throws Exception {
		return "redirect:/main";
	}

	@RequestMapping("/exception")
	private String exception() throws Exception {
		return "/noLayout/exception/exception";
	}
	@RequestMapping("/exception/exception")
	private String exception2() throws Exception {
		return "/noLayout/exception/exception";
	}
	@RequestMapping("/exception/exception1")
	private String exception3() throws Exception {
		return "/noLayout/exception/exception1";
	}

	@RequestMapping("/download/url")
	public void getFileUrlDownload(@RequestParam("fileUrl") String fileUrl, @RequestParam(value="fileName", defaultValue = "") String fileName, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		try {
	        URL url = new URL(fileUrl);
	        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();

			if("".equals(fileName)){
				File file = new File(url.getFile());
				fileName = file.getName();
				//fileName = fileUrl.substring( fileUrl.lastIndexOf('\\')+1, fileUrl.length() );
			}

			fileName = ReferenceUtils.getDisposition(fileName, ReferenceUtils.getBrowser(request));
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; fileName=\""+ fileName + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");

			InputStream inStream = httpConn.getInputStream();
	        response.setContentLength((int) httpConn.getContentLength());

	        OutputStream outStream = response.getOutputStream();

	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	        while ((bytesRead = inStream.read(buffer)) != -1) {
	            outStream.write(buffer, 0, bytesRead);
	        }
	        inStream.close();
	        outStream.close();

	    } catch (MalformedURLException e) {
	    	e.printStackTrace();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }

	}

	@RequestMapping("/notice")
	public String selectNoticeList(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {

		PageListVo<Map<String, Object>> pageListVo = commonService.selectNoticeList(paramMap.getMap());

        model.addAttribute("paramMap", paramMap.getMap());
        model.addAttribute("paging", paramMap.getPagingTagString(pageListVo.getTotalCount()));
        model.addAttribute("pageListVo", pageListVo);

		return  "/main/notice";
	}

	@RequestMapping("/notice/{seq}")
	public String selectNoticeInfo(@PathVariable long seq, ParamMap paramMap, Model model) throws Exception {

		Map<String, Object> detailInfo = commonService.selectNoticeInfo(seq);

		if(detailInfo != null && detailInfo.size() > 0){
			//편집기 태그 정리
			detailInfo.put("contentDesc",StringUtils.getStripTagByPattern(StringUtils.getString(detailInfo.get("contentDesc"))));
		}

		model.addAttribute("paramMap", paramMap.getMap());
		model.addAttribute("detailInfo", detailInfo);

		return  "/main/noticeView";
	}

	@RequestMapping("/sitemap")
	public String sitemap(ParamMap paramMap, Model model, HttpServletRequest request) throws Exception {
		return  "/main/sitemap";
	}

}
