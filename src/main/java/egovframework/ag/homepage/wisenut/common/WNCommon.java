package egovframework.ag.homepage.wisenut.common;

import java.io.IOException;
import java.util.StringTokenizer;
import javax.servlet.jsp.JspWriter;

import QueryAPI453.Search;
import static egovframework.ag.homepage.wisenut.common.WNUtils.*;

/**
 *  file: WNCommon.jsp
 *  subject: Search Formula-1 API Wrapper 클래스
 *  ------------------------------------------------------------------------
 *  @original author: KoreaWISEnut
 *  @edit author: KoreaWISEnut
 *  @update date 2007.01.29
 *  ------------------------------------------------------------------------
 */

public class WNCommon {
    private Search    search = null;
    private JspWriter out    = null;
    boolean isDebug          = false;

    /**
     * SF-1 QueryAPI Search 클래스 객체를 생성하는 WNCommon의 생성자 함수이다.
     */
    public WNCommon() {
        this.search = new Search();
    }

    /**
     * WNCommon 오버로딩(overloading) 함수이다.
     * WNCommon을 단독으로 사용할 경우 debug 사용유무를 지정할 수 있다.
     * @param out
     * @param isDubug
     */
    public WNCommon(JspWriter out, boolean isDubug) {
        this.search = new Search();
        this.out = out;
        this.isDebug = isDubug;
    }

    /**
     * 검색 질의 키워드와 질의나 출력에 사용될 문자집합을 정한다.
     * @param query
     * @param charSet
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCommonQuery(String query, String charSet) {
        int ret = 0;
        ret = search.w3SetCodePage(charSet);
        ret = search.w3SetQueryLog(1);
        ret = search.w3SetCommonQuery(query);
        return ret;
    }

    /**
     * setCommonQuery의 오버로딩(overloading) 함수로
     * session정보를 부가기능으로 사용할 수 있다.
     * @param query
     * @param charSet
     * @param logInfo
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCommonQuery(String query, String charSet, String[] logInfo) {
        int ret = 0;
        if (logInfo != null && logInfo.length > 2) {
            ret = search.w3SetSessionMgr(logInfo[0],logInfo[1],logInfo[2]);
        }
        setCommonQuery(query, charSet);
        return ret;
    }

    /**
     * 컬렉션 별로 검색어 지정
     * @param collectionName
     * @param query
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCollectionQuery(String collectionName, String query) {
        return search.w3SetCollectionQuery(collectionName, query);
    }

    /**
     * 검색하고자 하는 컬렉션의 UID를 설정한다.
     * @param collectionName
     * @param values
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setUid(String collectionName, String[] values) {
        int ret = 0;
        for (int i = 0; i < values.length; i++) {
            int uid = 0;
            try {
                uid= Integer.parseInt(values[i]);
            } catch (NumberFormatException e) {
                return -1;
            }
            ret = search.w3AddUid(collectionName, uid);

        }
        return ret;
    }

    /**
     * 검색대상 컬렉션, 언어분석기 사용유무, 대소문자 구분유무를 설정한다.
     * @param collectionName
     * @param useKma
     * @param isCase
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int addCollection(String collectionName, int useKma, int isCase) {
        int ret = 0;
        ret = search.w3AddCollection(collectionName);
        ret =  search.w3SetQueryAnalyzer(collectionName, useKma, isCase );
        //systemOut("[w3AddCollection] "+collectionName);
        return ret;
    }

    /**
     * 추상 컬렉션 추가
     * @param aliasName 설정한 별칭 컬렉션명
     * @param collectionName 실제 컬렉션
     * @param useKma
     * @param isCase
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int addAliasCollection(String aliasName, String collectionName, int useKma, int isCase){
        int ret = 0;
        ret = search.w3AddAliasCollection(aliasName, collectionName);
        ret =  search.w3SetQueryAnalyzer(aliasName, useKma, isCase );
        return ret;
    }

    /**
     * 검색기 연결
     * @param ip
     * @param port
     * @param timeOut
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int getConnection(String ip, int port, int timeOut) {
        int ret = search.w3ConnectServer(ip, port, timeOut);
        return ret;
    }

    /**
     * 해당 컬렉션의 검색 대상 필드를 여러 개를 설정한다.
     * @param collectionName
     * @param fields
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setSearchField(String collectionName, String[] fields) {
        int ret = 0;
        for (int i = 0; i < fields.length; i++) {
            ret = search.w3AddSearchField(collectionName, fields[i]);
            systemOut("[w3AddSearchField] " + collectionName + " / " + fields[i]);
        }
        return ret;
    }

    /**
     * 검색결과의 정렬필드를 설정한다.
     * @param collectionName
     * @param sortField
     * @param sortOrder
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setSortField(String collectionName, String sortField, int sortOrder) {
        int ret = 0;
        ret = search.w3AddSortField(collectionName, sortField, sortOrder);
        systemOut("[w3AddSortField] " + collectionName + " / " + sortField);
        return ret;
    }

    /**
     *
     * @param collectionName
     * @param fieldNameValues
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setExQuery(String collectionName, String fieldNameValues)  {
        int ret = search.w3AddExQuery(collectionName, fieldNameValues);
        systemOut("[w3AddExQuery]" + fieldNameValues);
        return ret;
    }

    /**
     *
     * @param collectionName
     * @param fieldNameValues
     * @return  성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setFilterOperation(String collectionName, String fieldNameValues)  {
        int ret = search.w3AddFilterOperation(collectionName, fieldNameValues);
        systemOut("[w3AddFilterOperation]" + fieldNameValues);
        return ret;
    }

    /**
     *  setResultField에서 지정한 결과 필드들의 값을 얻는 함수이다.
     * @param collectionName
     * @param fields
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setResultField(String collectionName, String[] fields) {
        int ret = 0;
        for (int i = 0; i< fields.length; i++) {
            ret = search.w3AddDocumentField(collectionName, fields[i]);
            systemOut("[w3AddDocumentField] " + collectionName + " / " + fields[i]);
        }
        return ret;
    }

    /**
     * 해당 컬렉션의 몇 번째 검색 결과부터 몇 개를
     * 가져올 것인지를 지정하고 하이라이트 기능과 요약기능을 지정하는 함수이다.
     * 검색 API v3.5에서는 w3SetHighlight의 파라미터가 2개이지만 v3.7에서는 3개이다.
     * @param collName
     * @param highlight
     * @param startPos
     * @param resultCnt
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setPageInfo(String collName,  int highlight, int startPos, int resultCnt) {
        int ret = 0;
        ret = search.w3SetHighlight(collName, highlight, 5);
        // 페이지, 기본정렬 설정
        ret = search.w3SetPageInfo(collName, startPos, resultCnt);

        return ret;
    }

    /**
     * 검색한 결과 날짜/시간 범위를 지정하고
     * 시작날짜와 종료날짜의 형식이 YYYY/MM/DD가 아니라면
     * 변경할 문자를 인자로 지정한다.
     * @param collectionName
     * @param startDate
     * @param endDate
     * @param replaceChr
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setDateRange(String collectionName, String startDate, String endDate, String replaceChr) {
        // 날짜 조건 세팅
        int ret = 0;
        if (!startDate.equals("") && !endDate.equals("")) {
            startDate = replace(startDate, replaceChr, "/");
            endDate = replace(endDate,replaceChr, "/");
            ret = search.w3SetDateRange(collectionName, startDate, endDate);
        }
        return ret;
    }

    /**
     *
     * @param collectionName
     * @param field
     * @param matchType
     * @param boostID
     * @param boostKeyword
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCategoryBoost(String collectionName, String field, String matchType, String boostID, String boostKeyword) {
        int ret = 0;
        ret = search.w3SetCategoryBoost(collectionName, field, matchType, boostID, boostKeyword);
        return ret ;
    }

    public int addMultiGroupBy(String collectionName, String fields) {
        int ret = 0;
        String[] field = split(fields, ",");
        int length = field.length;
        for (int i = 0; i < length; i++ ) {
            ret = search.w3AddMultiGroupBy(collectionName, field[i]);
        }
        return ret ;
    }

    /**
     * 멀티 그룹바이된 결과를 반환
     * @param collectionName 컬렉션명
     * @param fieldName 그룹핑할 필드명
     * @return 성공 시 해당 컬렉션 결과에서 인자로 주어진 필드의 그룹핑 결과 문자열을 반환하며, 에러 발생시 빈 문자열을 반환
     */
    public String getMultiGroupByResult(String collectionName, String fieldName) {
        String ret = "";
        ret = search.w3GetMultiGroupByResult(collectionName, fieldName);
        return ret ;
    }

    /**
     * v3.7에서는 2개의 전달인자 v4.0에서는 3개의 전달인자
     * @param collectionName
     * @param field
     * @param docCount
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setGroupBy(String collectionName, String field, int docCount) {
        int ret = 0;
        ret = search.w3SetGroupBy(collectionName, field, docCount);
        return ret ;
    }

    /**
     * 그룹 검색결과의 정렬필드를 설정한다.
     * @param collectionName
     * @param sortField
     * @param sortOrder
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int addSortFieldInGroup(String collectionName, String sortField, int sortOrder) {
        int ret = 0;
        ret = search.w3AddSortFieldInGroup(collectionName, sortField, sortOrder);
        systemOut("[w3AddSortFieldInGroup] " + collectionName + " / " + sortField);
        return ret;
    }

    /**
     *
     * @param collectionName
     * @return 전체 그룹 개수
     */
    public int getGroupByCount(String collectionName) {
        return search.w3GetGroupByCount(collectionName);
    }

    /**
     *
     * @param collectionName
     * @return 가져온 그룹 개수
     */
    public int getGroupCount(String collectionName) {
        return search.w3GetGroupCount(collectionName);
    }

    /**
     *
     * @param collectionName
     * @parma groupIndex
     * @return 그룹에 속하는 전체문서 개수
     */
    public int getTotalCountInGroup(String collectionName, int groupIndex) {
        return search.w3GetTotalCountInGroup(collectionName, groupIndex);
    }

    /**
     *
     * @param collectionName
     * @parma groupIndex
     * @return 그룹에 속하는 문서 중 가져온 문서 개수
     */
    public int getCountInGroup(String collectionName, int groupIndex) {
        return search.w3GetCountInGroup(collectionName, groupIndex);
    }

    /**
     *
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 원하는 문서의 필드값
     */
    public String getFieldInGroup(String collectionName, String fieldName, int groupIndex, int docIndex) {
        return search.w3GetFieldInGroup(collectionName, fieldName, groupIndex, docIndex);
    }

    /**
     *
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 원하는 문서의 uid값
     */
    public long getUidInGroup(String collectionName, int groupIndex, int docIndex) {
        return search.w3GetUidInGroup(collectionName, groupIndex, docIndex);
    }

    /**
     *
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 원하는 문서의 가중치 값
     */
    public long getWeightInGroup(String collectionName, int groupIndex, int docIndex) {
        return search.w3GetWeightInGroup(collectionName, groupIndex, docIndex);
    }

    /**
     *
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 원하는 문서의 날짜 정보
     */
    public String getDateInGroup(String collectionName, int groupIndex, int docIndex) {
        return search.w3GetDateInGroup(collectionName, groupIndex, docIndex);
    }

    /**
     * 하이라이팅될 문자열을 보여주는 함수이다.
     * @return 하이라이팅될 문자열
     */
    public String getHighlightKeyword() {
        String keyWord = this.search.w3GetHighlightKeyword().trim();
        return keyWord;
    }

    /**
     * 형태소 분석된 결과 문자열을 보여주는 함수이다.
     * @param colName
     * @param searchField
     * @return 하이라이팅될 문자열
     */
    public String getHighlightKeywordByField(String colName, String searchField) {
        String keyWord = this.search.w3GetHighlightKeywordByField(colName, searchField);
        return keyWord;
    }

    /**
     *
     * @param collectionName
     * @return 검색결과 개수
     */
    public int getResultCount(String collectionName) {
        return search.w3GetResultCount(collectionName);
    }

    /**
     *
     * @param collectionName
     * @return 검색결과 총 개수
     */
    public int getResultTotalCount(String collectionName) {
        return search.w3GetResultTotalCount(collectionName);
    }


    /**
     * 최근에 검색된 키워드리스트를 반환한다.
     * @param count
     * @return 최근에 검색된 키워드리스트
     */
    public String[] recvRealTimeSearchKeywordList(int mode, int count) {
        String realKeyword = search.w3RecvRealTimeSearchKeywordList(mode, count);
        String[] keyList = null;
        if (realKeyword != null) {
            StringTokenizer token = new StringTokenizer(realKeyword, ",");
            keyList = new String[token.countTokens()];
            for (int i = 0; token.hasMoreTokens(); i++) {
                keyList[i] = token.nextToken();
            }
        }
        return keyList;
    }

    /**
     *
     * @param mode
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int recvResult(int mode) {
        int ret = search.w3RecvResult(mode);
        return ret;
    }

    /**
     * UID 검색을 검색기에 전달하고, 결과를 받는 함수이다.
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int recvDocument(int mode) {
        int ret = search.w3RecvDocument(mode);
        return ret;
    }

    /**
     *
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int recvAnalyzedQuery(int mode) {
        int ret = search.w3RecvAnalyzedQuery(mode);
        return ret;
    }

    /**
     *
     * @param coll
     * @param field
     * @param idx
     * @return FIELD VALUE
     */
    public String getField(String coll, String field, int idx) {
        return search.w3GetField(coll,field,idx);
    }

    /**
     *
     * @param coll
     * @param idx
     * @return DATE
     */
    public String getDate(String coll, int idx) {
        return search.w3GetDate(coll,idx);
    }

    /**
     *
     * @param coll
     * @param idx
     * @return DATE
     */
    public long getWeight(String coll, int idx) {
        return search.w3GetWeight(coll,idx);
    }

    /**
     *
     * @param coll
     * @param idx
     * @return RANK
     */
    public  long getRank(String coll, int idx) {
        return search.w3GetRank(coll,idx);
    }

    /**
     *
     * @param coll
     * @param idx
     * @return UID
     */
    public  long getUid(String coll, int idx) {
        return search.w3GetUid(coll,idx);
    }

    /**
     * 네트워크 종료
     */
    public void closeServer() {
        if (search != null) {
            search.w3CloseServer();
            search = null;
        }
    }

    /**
     *
     * @return
     */
    public String getErrorInfo() {
        String errorMsg = "";
        int errorCode = search.w3GetLastError();
        if (errorCode != 0) {
            errorMsg = search.w3GetErrorInfo(errorCode);
            errorMsg = errorMsg + "(<b>code:<font color='red'>"+errorCode+"</font></b>)";
        }
        return errorMsg;
    }

    /**
     * 에러 코드에 대한 에러정보를 web application의 standard out log에 출력한다.
     * @param msg
     */
    public void systemOut(String msg) {
        if (out != null && isDebug) {
            try {
                out.println(msg+"<br>");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}