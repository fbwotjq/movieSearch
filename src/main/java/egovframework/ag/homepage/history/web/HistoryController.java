package egovframework.ag.homepage.history.web;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.ag.common.Constant;
import egovframework.ag.common.annotation.LoginUser;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.common.web.ParamMap;
import egovframework.ag.homepage.common.service.CommonService;
import egovframework.ag.homepage.history.service.HistoryService;

@Controller
@RequestMapping("/history")
public class HistoryController {

	@Autowired
	private HistoryService historyService;

	@Autowired
	private CommonService commonService;

	/**
	 * 사료관 메인
	 * @param model
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/main")
	public String mainView(ParamMap paramMap, Model model) throws Exception {
		//구술채록문 목록
		//paramMap.put("codeGroupId", "C110");
		//List<Map<String, Object>> codeList = commonService.selectCodeTreeList(paramMap.getMap());

		paramMap.put(Constant.PAGE_SIZE, "5");
		paramMap.put("archivesTypeCd", Constant.ARCHIVE_SPEECH_CODE);
		model.addAttribute("talkList", historyService.selectArchivesPageList(paramMap.getMap()));

		//메인 사료콘텐츠
		model.addAttribute("mainArchivesContentList", historyService.selectMainArchivesContentList());

		//영화잡지 목록
		paramMap.put("archivesTypeCd", Constant.ARCHIVE_MAGAZ_CODE);
		model.addAttribute("magazineList", historyService.selectArchivesPageList(paramMap.getMap()));

		//공문서
		paramMap.put("archivesTypeCd", Constant.ARCHIVE_PUBLIC_CODE);
		model.addAttribute("documentList", historyService.selectArchivesPageList(paramMap.getMap()));

		//발간도서
		paramMap.put("archivesTypeCd", Constant.ARCHIVE_BOOK_CODE);
		model.addAttribute("bookList", historyService.selectArchivesPageList(paramMap.getMap()));

		//서울의 극장 목록
		model.addAttribute("theaterList", historyService.selectTheaterList());


		return "/history/main";
	}

	/**
	 * 사료관 파일 다운로드
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/download", method=RequestMethod.POST)
	public String archivesFileDownload(@LoginUser MemberDetails memberDetail, ParamMap paramMap, Model model, HttpServletRequest request) {
		String returnView = "/common/attach/dfload";
		String returnCode = "99";
		String returnMsg  = "파일 다운로드에 실패하였습니다.";
		File downloadFile = null;
		String orgFileName = "";
		try {
			String returnUrl = paramMap.getString("dReturnUrl");

			Long lFileSeq = StringUtils.getLong(paramMap.getString("dFileSeq"));
			Long lFileOrder = StringUtils.getLong(paramMap.getString("dFileOrder"));

			String loginUserId = "";

			try {
				loginUserId = memberDetail.getUserid();
			}catch(Exception e) {
				loginUserId = "";
			}


			Map<String, Object> fileInfoMap = historyService.selectArchivesFileInfo(lFileSeq, lFileOrder, loginUserId);

			if (fileInfoMap == null) {
				returnMsg = "파일을 찾을 수 없습니다.";
				throw new Exception("file info not exist");
			}


			String downYn = StringUtils.getString(fileInfoMap.get("downYn"));
			String freeYn = StringUtils.getString(fileInfoMap.get("freeYn"));
			String payYn = StringUtils.getString(fileInfoMap.get("payYn"));

			if ("Y".equals(downYn) == false) {
				returnMsg = "해당파일은 다운로드 불가 파일입니다.";
				throw new Exception("ban Download");
			}

			if ("N".equals(freeYn) == true) {//유료파일은 로그인 필요
				if ("".equals(loginUserId) == true) {
					returnView = "redirect:/login?returnUrl=" + returnUrl;
					throw new Exception("need login");
				}
			}

			if ("N".equals(freeYn) == true && "N".equals(payYn) == true) {//결제 필요
				returnMsg = "결제가 필요합니다.";
				throw new Exception("need pay");
			}


			String uploadPath = StringUtils.getString(commonService.selectCodeInfo("C001", "10").get("cCodeSubName")) + Constant.ONLINE_ARCHIVES_PATH;

			downloadFile = new File(uploadPath, StringUtils.getString(fileInfoMap.get("fileName")));

			if (downloadFile.exists() == false) {
				returnMsg = "파일을 찾을 수 없습니다.";
				throw new Exception("file not exist");
			}


			historyService.increaseArchivesFileDownCount(lFileSeq, lFileOrder);

			orgFileName = StringUtils.getString(fileInfoMap.get("orgFileName"));

			returnView = "dfload";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("keyFileMask", orgFileName);
		model.addAttribute("codeResult", returnCode);
		model.addAttribute("returnMsg", returnMsg);

		return returnView;
	}

	/**
	 * 사료관 PDF VIEWER
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/pdfViewer", method=RequestMethod.POST)
	public String archivesFileViewer(@LoginUser MemberDetails memberDetail, ParamMap paramMap, Model model, HttpServletRequest request) {
		String returnView = "/common/attach/pdfViewerError";
		String returnMsg  = "";

		try {
			String returnUrl = paramMap.getString("dReturnUrl");

			Long lFileSeq = StringUtils.getLong(paramMap.getString("dFileSeq"));
			Long lFileOrder = StringUtils.getLong(paramMap.getString("dFileOrder"));


			String loginUserId = "";

			try {
				loginUserId = memberDetail.getUserid();
			}catch(Exception e) {
				loginUserId = "";
			}


			Map<String, Object> fileInfoMap = historyService.selectArchivesFileInfo(lFileSeq, lFileOrder, loginUserId);

			if (fileInfoMap == null) {
				returnMsg = "파일정보를 찾을 수 없습니다.";
				throw new Exception("file info not exist");
			}


			String viewYn = StringUtils.getString(fileInfoMap.get("viewYn"));
			String freeYn = StringUtils.getString(fileInfoMap.get("freeYn"));
			String payYn = StringUtils.getString(fileInfoMap.get("payYn"));

			if ("Y".equals(viewYn) == false) {
				returnMsg = "해당파일은 다운로드 불가 파일입니다.";
				throw new Exception("ban View");
			}

			if ("N".equals(freeYn) == true) {//유료파일은 로그인 필요
				if ("".equals(loginUserId) == true) {
					returnView = "redirect:/login?returnUrl=" + returnUrl;
					throw new Exception("need login");
				}
			}

			if ("N".equals(freeYn) == true && "N".equals(payYn) == true) {//결제 필요
				returnMsg = "결제가 필요합니다.";
				throw new Exception("need pay");
			}


			//String uploadPath = StringUtils.getString(commonService.selectCodeInfo("C001", "10").get("cCodeSubName")) + Constant.ONLINE_ARCHIVES_PATH;

			//File downloadFile = new File(uploadPath, StringUtils.getString(fileInfoMap.get("fileName")));

			//if (downloadFile.exists() == false) {
				//returnMsg = "파일을 찾을 수 없습니다.";
				//throw new Exception("file not exist");
			//}
//
//			FileInputStream fileInputStreamReader = null;
//			try {
//	            fileInputStreamReader = new FileInputStream(downloadFile);
//	            byte[] bytes = new byte[(int)downloadFile.length()];
//	            fileInputStreamReader.read(bytes);
//	            String encodedBase64 = new String(Base64.encodeBase64(bytes));
//
//	            model.addAttribute("base64PdfInfo", encodedBase64);
//			}catch (Exception e) {
//				returnMsg = "파일 정보를 읽을 수 없습니다.";
//				throw new Exception("fileInputStreamReader Error");
//			}finally {
//				if (fileInputStreamReader != null) {
//					try {fileInputStreamReader.close();}catch(Exception e){}
//				}
//			}
//
//			historyService.increaseArchivesFileViewCount(lFileSeq, lFileOrder);

			model.addAttribute("fileInfo", fileInfoMap);
			model.addAttribute("paramMap", paramMap.getMap());

			returnView = "/noLayout/common/viewer/pdfViewer";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("returnMsg", returnMsg);

		return returnView;
	}

	/**
	 * 사료관 PDF VIEWER
	 * @param paramMap
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/pdfFile", method=RequestMethod.POST)
	public String archivesFileStream(@LoginUser MemberDetails memberDetail, ParamMap paramMap, Model model, HttpServletRequest request, HttpServletResponse response) {
		//String returnView = "/common/attach/pdfViewerError";
		String returnMsg  = "";

		try {
			//String returnUrl = paramMap.getString("dReturnUrl");

			Long lFileSeq = StringUtils.getLong(paramMap.getString("dFileSeq"));
			Long lFileOrder = StringUtils.getLong(paramMap.getString("dFileOrder"));

			String loginUserId = "";

			try {
				loginUserId = memberDetail.getUserid();
			}catch(Exception e) {
				loginUserId = "";
			}


			Map<String, Object> fileInfoMap = historyService.selectArchivesFileInfo(lFileSeq, lFileOrder, loginUserId);

			if (fileInfoMap == null) {
				returnMsg = "파일정보를 찾을 수 없습니다.";
				throw new Exception("file info not exist");
			}


			String viewYn = StringUtils.getString(fileInfoMap.get("viewYn"));
			String freeYn = StringUtils.getString(fileInfoMap.get("freeYn"));
			String payYn = StringUtils.getString(fileInfoMap.get("payYn"));

			if ("Y".equals(viewYn) == false) {
				returnMsg = "해당파일은 다운로드 불가 파일입니다.";
				throw new Exception("ban View");
			}

			if ("N".equals(freeYn) == true && "N".equals(payYn) == true) {//결제 필요
				returnMsg = "결제가 필요합니다.";
				throw new Exception("need pay");
			}


			String uploadPath = StringUtils.getString(commonService.selectCodeInfo("C001", "10").get("cCodeSubName")) + Constant.ONLINE_ARCHIVES_PATH;

			File downloadFile = new File(uploadPath, StringUtils.getString(fileInfoMap.get("fileName")));

			if (downloadFile.exists() == false) {
				returnMsg = "파일을 찾을 수 없습니다.";
				throw new Exception("file not exist");
			}


//			FileInputStream fileInputStreamReader = null;
//			OutputStream out = response.getOutputStream();
//
//			response.setContentType("application/octet-stream");
//			try {
////				out = response.getWriter();
////
////
////
////
////				fileInputStreamReader = new FileInputStream(downloadFile);
////
////				int readBuffer = 0;
////				byte[] buffer = new byte[512];
////
////				while ((readBuffer = fileInputStreamReader.read(buffer)) != -1) {
////					String encodedBase64 = new String(Base64.encodeBase64(buffer));
////
////					String str = new String(buffer, "UTF-8");
////
////					System.out.println("str : " + str);
////
////					//FileCopyUtils.copy(encodedBase64, out);
////
////					out.write(str);
////				}
//
//				fileInputStreamReader = new FileInputStream(downloadFile);
//				FileCopyUtils.copy(fileInputStreamReader, out);
//
//
//			}catch (Exception e) {
//				returnMsg = "파일 정보를 읽을 수 없습니다.";
//				throw new Exception("fileInputStreamReader Error");
//			}finally {
//				if (fileInputStreamReader != null) {
//					try {fileInputStreamReader.close();}catch(Exception e){}
//				}
//				if (out != null) {
//					try {out.close();}catch(Exception e){}
//				}
//			}

			historyService.increaseArchivesFileViewCount(lFileSeq, lFileOrder);

			String orgFileName = StringUtils.getString(fileInfoMap.get("orgFileName"));

			model.addAttribute("downloadFile", downloadFile);
			model.addAttribute("keyFileMask", orgFileName);
		} catch (Exception e) {
			e.printStackTrace();

			return returnMsg;
		}

		return "dfload";
	}
}
