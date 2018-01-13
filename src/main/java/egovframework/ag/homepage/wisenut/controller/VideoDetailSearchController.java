package egovframework.ag.homepage.wisenut.controller;

import egovframework.ag.homepage.wisenut.common.WNSearch;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static egovframework.ag.homepage.wisenut.common.WNCollection.COLLECTIONS;
import static egovframework.ag.homepage.wisenut.common.WNDefine.*;
import static egovframework.ag.homepage.wisenut.common.WNUtils.*;


@RequestMapping(value = "/detailSearch")
@Controller
public class VideoDetailSearchController {
	// 실시간 검색어 화면 출력 여부 체크
    private boolean isRealTimeKeyword = false;
    // 오타 후 추천 검색어 화면 출력 여부 체크
    private boolean useSuggestedQuery = false;
	// 디버깅 보기 설정
    private boolean isDebug = false;
    private int COLLECTIONVIEWCOUNT = 10;    //더보기시 출력건수
    private String START_DATE = "2000/01/01";	// 기본 시작일

    /** 인명 상세 페이지 이동 */
    @RequestMapping(value = "/moveVideoSearch")
    public String artMoveSearch(HttpServletRequest request, Model model) {
        return "/wisenut/detail/videoDetailSearch";
    }

	@RequestMapping(value = "/videoSearch")
	public String videoSearch(HttpServletRequest request, Model model) {

        //실시간 검색어 화면 출력 여부 체크
        boolean isRealTimeKeyword = false;

        //디버깅 보기 설정
        boolean isDebug = true;

        int TOTALVIEWCOUNT = 3;    //통합검색시 출력건수
        int COLLECTIONVIEWCOUNT = 10;    //더보기시 출력건수

        String START_DATE = "1970.01.01";	// 기본 시작일

        // 결과 시작 넘버
        int startCount = parseInt(getCheckReqXSS(request, "startCount", "0"), 0);	//시작 번호
        String query = getCheckReqXSS(request, "query", "");						//검색어
        String collection = getCheckReqXSS(request, "collection", "ALL");			//컬렉션이름
        String rt = getCheckReqXSS(request, "rt", "");								//결과내 재검색 체크필드
        String rt2 = getCheckReqXSS(request, "rt2", "");							//결과내 재검색 체크필드
        String reQuery = getCheckReqXSS(request, "reQuery", "");					//결과내 재검색 체크필드
        String realQuery = getCheckReqXSS(request, "realQuery", "");				//결과내 검색어
        String sort = getCheckReqXSS(request, "sort", "RANK");						//정렬필드
        String range = getCheckReqXSS(request, "range", "A");						//기간관련필드
        String startDate = getCheckReqXSS(request, "startDate", START_DATE);		            //시작날짜
        String endDate = getCheckReqXSS(request, "endDate", getCurrentDate());		            //끝날짜
        String writer = getCheckReqXSS(request, "writer", "");						//작성자
        String searchField = getCheckReqXSS(request, "searchField", "");			//검색필드


        String tabName = getCheckReqXSS(request, "tabName", "");			//검색필드

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
        if(collection.equals("ALL")) { //통합검색인 경우
            collections = COLLECTIONS;      // 영화인만 TODO
        } else {                        //개별검색인 경우
            collections = new String[] { collection };
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

            //출력건수
            wnsearch.setCollectionInfoValue(collections[i], PAGE_INFO, startCount+","+viewResultCount);

            //검색어가 없으면 DATE_RANGE 로 전체 데이터 출력
            if (!query.equals("") ) {
                wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, sort + ",1");
            } else {
                wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, START_DATE.replaceAll("[.]","/") + ",2030/01/01,-");
                wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, "DATE,1");
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

            //기간 설정 , 날짜가 모두 있을때
            if (!startDate.equals("")  && !endDate.equals("") ) {
                wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, startDate.replaceAll("[.]","/") + "," + endDate.replaceAll("[.]","/") + ",-");
            }
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
		return "/wisenut/sojangSearch";
	}

}