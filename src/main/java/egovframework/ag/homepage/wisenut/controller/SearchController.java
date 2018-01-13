package egovframework.ag.homepage.wisenut.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

import egovframework.ag.homepage.wisenut.common.WNSearch;
import org.springframework.web.bind.annotation.RequestMethod;

import static egovframework.ag.homepage.wisenut.common.WNDefine.*;
import static egovframework.ag.homepage.wisenut.common.WNUtils.getCheckReqXSS;
import static egovframework.ag.homepage.wisenut.common.WNUtils.getCurrentDate;
import static egovframework.ag.homepage.wisenut.common.WNUtils.parseInt;
import static egovframework.ag.homepage.wisenut.common.WNCollection.COLLECTIONS;


@RequestMapping(value = "/search")
@Controller
public class SearchController {
	// 실시간 검색어 화면 출력 여부 체크
    private boolean isRealTimeKeyword = false;
    // 오타 후 추천 검색어 화면 출력 여부 체크
    private boolean useSuggestedQuery = false;
	// 디버깅 보기 설정
    private boolean isDebug = false;
    private int COLLECTIONVIEWCOUNT = 10;    //더보기시 출력건수
    private String START_DATE = "2000/01/01";	// 기본 시작일

	@RequestMapping(value = "/movieSearch", method={RequestMethod.POST, RequestMethod.GET})
	public String movieSearch(HttpServletRequest request, Model model) {

        //실시간 검색어 화면 출력 여부 체크
        boolean isRealTimeKeyword = false;

        //디버깅 보기 설정
        boolean isDebug = true;

        int TOTALVIEWCOUNT = 3;    //통합검색시 출력건수
        int COLLECTIONVIEWCOUNT = 10;    //더보기시 출력건수

        // 사용안함.
        //String START_DATE = "1970.01.01";	                                        //기본 시작일
        //String range = getCheckReqXSS(request, "range", "A");						//기간관련필드
        //String startDate = getCheckReqXSS(request, "startDate", START_DATE);		//시작날짜
        //String endDate = getCheckReqXSS(request, "endDate", getCurrentDate());	//끝날짜

        // 결과 시작 넘버
        int startCount = parseInt(getCheckReqXSS(request, "startCount", "0"), 0);	//시작 번호
        String query = getCheckReqXSS(request, "query", "");						//검색어
        String collection = getCheckReqXSS(request, "collection", "ALL");			//컬렉션이름
        String rt = getCheckReqXSS(request, "rt", "");								//결과내 재검색 체크필드
        String rt2 = getCheckReqXSS(request, "rt2", "");							//결과내 재검색 체크필드
        String reQuery = getCheckReqXSS(request, "reQuery", "");					//결과내 재검색 체크필드
        String realQuery = getCheckReqXSS(request, "realQuery", "");				//결과내 검색어
        String sort = getCheckReqXSS(request, "sort", "RANK");						//정렬필드
        String writer = getCheckReqXSS(request, "writer", "");						//작성자
        String searchField = getCheckReqXSS(request, "searchField", "");			//검색필드
        String tabName = getCheckReqXSS(request, "tabName", "movieTab");			//검색필드

        String strOperation  = "" ;												//operation 조건 필드
        String exquery = "" ;													//exquery 조건 필드

        String[] searchFields = null;

        // 상세검색 검색 필드 설정이 되었을때
        if (!searchField.equals("")) {
            // 작성자
            if (!writer.equals("")) {
//                exquery = "<WRITER:" + writer + ">";
            }
        } else {
            searchField = "ALL";
        }

        String[] collections = null;
        if("ALL".equals(collection)) { //통합검색인 경우
            // collections = COLLECTIONS;
            // 국내영화, 국외영화, 영화인, 동영상, 이미지, 사료관, 영화글, 영화제, 장소, 행사/사건
            collections = new String[] {"kmKORMOVIE","kmFORMOVIE","kmMOVIEIN","kmMOVIE","kmPOSTERFILE","kmPOSTERPRINT","kmSTILLFILE","kmSTILLPRINT","kmSALYO","kmMSTORY","kmMOVIEJE","kmPLACE","kmEVENT"};
        } else {                        //개별검색인 경우
            if ("kmIMAGE".equals(collection)) { // 이미지일 경우
                collections = new String[] {"kmPOSTERFILE","kmPOSTERPRINT","kmSTILLFILE","kmSTILLPRINT"};
            } else {
                collections = new String[] { collection };
            }

        }

        if (reQuery.equals("1")) {
            realQuery = query + " " + realQuery;
        } else if (!reQuery.equals("2")) {
            realQuery = query;
        }

        WNSearch wnsearch = new WNSearch(isDebug,false, collections, searchFields);

        int viewResultCount = COLLECTIONVIEWCOUNT;
        if ( collection.equals("ALL") ||  collection.equals("") )
            viewResultCount = TOTALVIEWCOUNT;

        for (int i = 0; i < collections.length; i++) {

            System.out.println("collection Name == " + collections[i]);
            System.out.println("SORT_FIELD == " + SORT_FIELD);
            System.out.println("sort == " + sort);

            //출력건수
            wnsearch.setCollectionInfoValue(collections[i], PAGE_INFO, startCount+","+viewResultCount);

            //검색어가 없으면 DATE_RANGE 로 전체 데이터 출력
            if (!query.equals("") ) {
                wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, sort + ",1");
            //} else {
                //wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, START_DATE.replaceAll("[.]","/") + ",2030/01/01,-"); 날짜 없음.
                //wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, "RANK,1");
            }

            //searchField 값이 있으면 설정, 없으면 기본검색필드
            if (!searchField.equals("") && !searchField.equals("WRITER") && searchField.indexOf("ALL") == -1 ) {
                wnsearch.setCollectionInfoValue(collections[i], SEARCH_FIELD, searchField);
            }

            //operation 설정
            if (!strOperation.equals("")) {
                wnsearch.setCollectionInfoValue(collections[i], FILTER_OPERATION, strOperation);
            }

            //exquery 설정
            if (!exquery.equals("")) {
                wnsearch.setCollectionInfoValue(collections[i], EXQUERY_FIELD, exquery);
            }

            //기간 설정 , 날짜가 모두 있을때 날짜 없음.
            //if (!startDate.equals("")  && !endDate.equals("") ) {
            //    wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, startDate.replaceAll("[.]","/") + "," + endDate.replaceAll("[.]","/") + ",-");
            //}
        };

        // 검색 요청
        wnsearch.search(realQuery, true, isRealTimeKeyword);

        // 디버그 메시지 출력
        String debugMsg = wnsearch.printDebug() != null ? wnsearch.printDebug().trim() : "";
        if ( !debugMsg.trim().equals("")) {
            System.out.println(debugMsg);
        }

        // 검색 결과
        int colCount = 0;
        int totalCount = 0;
        List<Map<String, Object>> docList = null;
        Map<String, Object> resultData = new HashMap<String, Object>();
        String paging = "";

        // 전체건수 구하기
        if ( collection.equals("ALL") ) {

            for (int i = 0; i < collections.length; i++) {
                colCount = wnsearch.getResultTotalCount(collections[i]);
                resultData.put(collections[i]+"Count", colCount);
                if(colCount > 0) {
                    docList = wnsearch.getDocList(collections[i], colCount < viewResultCount ? colCount : viewResultCount);
                    resultData.put(collections[i]+"List", docList);
                }
                totalCount += colCount;
            }

        } else {
            // 개별건수 구하기
            colCount = wnsearch.getResultTotalCount(collection);
            resultData.put(collection+"Count", colCount);
            if(colCount > 0) {
                docList = wnsearch.getDocList(collection, colCount-startCount < viewResultCount ? colCount-startCount : viewResultCount);
                resultData.put(collection+"List", docList);
            }
            totalCount = colCount;

            if(totalCount > viewResultCount) {
                paging = wnsearch.getPageLinks(startCount, totalCount, viewResultCount, 5);
            }

            if(totalCount > viewResultCount) {
                paging = wnsearch.getPageLinks(startCount, totalCount, viewResultCount, 5);
            }
        }

        model.addAttribute("query", query);                 // 검색어
        model.addAttribute("collection", collection);       // collection
        model.addAttribute("startCount", startCount);       // 시작번호
        model.addAttribute("totalCount", totalCount);       // 전체 건수
        model.addAttribute("paging", paging);               // 페이징 결과
        model.addAttribute("resultData", resultData);       // 검색결과
        model.addAttribute("tabName", tabName);               // 페이징 결과

		return "/wisenut/movieSearch";
	}

}