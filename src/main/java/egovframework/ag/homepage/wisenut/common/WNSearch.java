package egovframework.ag.homepage.wisenut.common;

import org.apache.commons.lang.StringUtils;

import java.util.*;

import static egovframework.ag.homepage.wisenut.common.WNDefine.*;
import static egovframework.ag.homepage.wisenut.common.WNUtils.*;

/**
 * file: WNSearch.jsp
 * subject: 검색페이지에서 사용되는 메소드를 정의한 클래스
 *  ------------------------------------------------------------------------
 *  @original author: KoreaWISEnut
 *  @edit author: KoreaWISEnut
 *  @update date 2007.06.08
 *  ------------------------------------------------------------------------
 */
public class WNSearch {

    private WNCommon     common;
    private WNCollection wncol;
    private String[]     collections ;
    private String[]     searchFields;
    private String       managerURL = "";
    private int          hiSum = 0;
    private int          connectionOpt = 0;
    private StringBuffer sb = null;
    private StringBuffer warningMsg = null;
    private boolean      isAllSearchField = false;
    public  String       realTimeKeywords= "";
    boolean isDebug   = true;
    boolean isUidSrch = false;

    /**
     * WNCommon객체를 생성하고 검색 대상 컬렉션과 검색 대상 필드들을 설정한다.
     * @param isDebug 검색설정을 화면에 출력할 것인지 여부를 결정
     * @param isUidSrch 키워드 검색을 할 것인지 UID 검색을 할 것인지 여부를 결정
     * @param collections 검색하고자 하는 컬렉션들을 Array로 지정한다.
     * @param searchFields 검색하고자 하는 검색필드들을 Array로 지정한다.
     */
    public WNSearch(boolean isDebug, boolean isUidSrch, String[] collections, String[] searchFields) {
        this.common = new WNCommon();
        this.wncol = new WNCollection();
        this.collections = collections;
        this.searchFields = searchFields;
        this.sb = new StringBuffer();
        this.warningMsg = new StringBuffer();
        this.isDebug = isDebug;
        this.isUidSrch = isUidSrch;
    }

    /**
     * 검색 키워드를 설정한다.
     * @param query 검색 키워드
     * @param isAllSearchField 설정파일에 지정된 검색필드를 모두 검색할 것인지 여부를 결정
     * @param isRealQuery 실시간 검색어를 출력한 것인지 여부를 결정
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int search(String query, boolean isAllSearchField, boolean isRealQuery) {
        int connectionInfo = CONNECTION_CLOSE;
        if (isRealQuery) {
            connectionInfo = CONNECTION_REUSE;
        }
        return search(query, isAllSearchField, isRealQuery, null, HI_SUM_ONON, connectionInfo);
    }

    /**
     * 검색 키워드를 설정한다. 사용자 정보를 입력한다.
     * @param query 검색 키워드
     * @param isAllSearchField 설정파일에 지정된 검색필드를 모두 검색할 것인지 여부를 결정
     * @param isRealQuery 실시간 검색어를 출력한 것인지 여부를 결정
     * @param userInfo 사용자 정보
     * @param hiSum 하이라이팅 설정
     * @param connectionOpt 서버 접속 설정
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int search(String query, boolean isAllSearchField, boolean isRealQuery, String[] userInfo, int hiSum, int connectionOpt) {
        this.hiSum = hiSum;
        this.connectionOpt = connectionOpt;
        this.isAllSearchField = isAllSearchField;
        int ret = 0;
        if (!isUidSrch) {
            ret = common.setCommonQuery(query, CHARSET, userInfo);
        } else {
            ret = common.setCommonQuery("", CHARSET, userInfo);
        }

        if (collections != null) {
            for (int i = 0; i < collections.length; i++) {
                //컬렉션 index 설정
                int idx = getCollIdx(collections[i]);
                //컬렉션 index 결과 비교
                if (idx < 0) {
                    appendWarnings("[WARNING] [w3AddCollection] [search] ["+collections[i]+"] Collection name is not exist");
                    break;
                }

                //검색 컬렉션 설정
                ret = setCollectionBasicInfo(idx);
                //검색 필드 설정
                if (!isUidSrch) {
                    if (isAllSearchField) {
                        ret = setAllSearchFieldInfo(idx);
                    } else {
                        ret = setSearchFieldInfo(idx);
                    }
                    //날짜 범위 검색
                    ret = setDateRange(idx);
                    //ExField 조건 검색
                    ret = setExQuery(idx);
                    //CollectionQuery 검색
                    ret = setCollectionQuery(idx);
                    //카테고리 부스팅 적용
                    ret = setCategoryBoost(idx);
                    //FilterOperation 조건 검색
                    ret = setFilterOperation(idx);
                    //그룹바이 조건검색
                    ret = setGroupBy(idx);
                    //멀티그룹바이 조건검색
                    ret = addMultiGroupBy(idx);
                } else {
                    //UID검색
                    ret = setUid(idx, query);
                }
                //결과 필드 설정
                ret = setResultFieldInfo(idx);
            }
        } else {
            appendWarnings("[WARNING] [w3AddCollection] [search] [ ] CollectionName is null.");
        }

        //Connection
        ret = common.getConnection(wncol.SEARCH_IP, wncol.SEARCH_PORT, CONNECTION_TIMEOUT);

        //검색결과를 얻는다.
        if (!isUidSrch) {
            ret = common.recvResult(this.connectionOpt);
        } else {
            ret = common.recvDocument(this.connectionOpt);
        }

        if (isRealQuery) {
            this.realTimeKeywords = recvRealTimeSearchKeywordList(REALTIME_COUNT);
        }

        //실시간 검색키워드를 요청

        //디버그 모드일 경우
        if (isDebug) {
            //디버그 정보
            debugMsg(isRealQuery, query);
            //에러 정보
            String errMsg = common.getErrorInfo();
            appendErrors(common.getErrorInfo());
        }
        return ret;
    }

    /**
     * 기본 검색 정보를 설정한다. 언어분석, 페이지 설정, 정렬이 해당된다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCollectionBasicInfo(int idx) {
        int ret = 0;
        String[] analyzer = split(wncol.COLLECTION_INFO[idx][ANALYZER], ",");
        String[] pageInfo = split(wncol.COLLECTION_INFO[idx][PAGE_INFO], ",");
        String[] sortFieldInfo = split(wncol.COLLECTION_INFO[idx][SORT_FIELD], "/");

        if (analyzer.length != 2 || pageInfo.length != 2 || sortFieldInfo.length < 1) {
            appendWarnings("[WARNING] [ ] [setCollectionBasicInfo] ["+ wncol.COLLECTIONS[idx] + "] Analyzer : '"
                + wncol.COLLECTION_INFO[idx][ANALYZER] + "', PageInfo : '" + wncol.COLLECTION_INFO[idx][PAGE_INFO]
                + "', sortFieldInfo : '"+ wncol.COLLECTION_INFO[idx][SORT_FIELD] + "' error");
            return -1;
        }
        int useKma=Integer.parseInt(analyzer[0]);
        int isCase=Integer.parseInt(analyzer[1]);
        if (checkKeywordAnalyzer(wncol.COLLECTIONS[idx], useKma, isCase)== -1) {
            return -1;
        }
        ret = addCollection(idx, useKma, isCase);

        if (checkSetPageInfo(wncol.COLLECTIONS[idx], this.hiSum, Integer.parseInt(pageInfo[0]), Integer.parseInt(pageInfo[1])) == -1 ) {
            return -1;
        }
        ret = common.setPageInfo(wncol.COLLECTIONS[idx], this.hiSum, Integer.parseInt(pageInfo[0]), Integer.parseInt(pageInfo[1]));

        for (int i = 0; i < sortFieldInfo.length; i++) {
            String[] sortField = split(sortFieldInfo[i], ",");
            if (sortField.length != 2 ) {
                appendWarnings("[WARNING] [w3AddSortField] [setCollectionBasicInfo] ["+ wncol.COLLECTIONS[idx] + "] SortField '" + sortFieldInfo[i] + "'error");
                return -1;
            }
            if (checkSortFieldName(wncol.COLLECTIONS[idx], sortField[0], Integer.parseInt(sortField[1])) == -1) {
                return -1;
            }
            ret = common.setSortField(wncol.COLLECTIONS[idx], sortField[0], Integer.parseInt(sortField[1]));
        }
        return ret;
    }

    /**
     *
     * @param idx
     * @param useKma
     * @param isCase
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int addCollection(int idx, int useKma, int isCase){
        int ret = 0;
        String indexName = wncol.COLLECTIONS[idx];
        String colName   = wncol.COLLECTION_INFO[idx][COLLECTION_NAME];

        if (indexName.equals(colName)) {
            ret = common.addCollection(indexName, useKma, isCase);
        } else {
            ret = common.addAliasCollection(indexName, colName, useKma, isCase);
        }
        return ret;
    }

    /**
     * WNCollection의 COLLECTION_INFO에 설정이 필요한 값을 Assign한다.
     * @param collName 검색하고자 하는 컬렉션의 이름
     * @param target Assign 대상
     * @param value Assign 값
     * @return 성공이면 true, 실패하면 false를 반환한다.
     */
    public boolean setCollectionInfoValue(String collName, int target, String value) {
        int idx = getCollIdx(collName);
        if (idx == -1) {
            appendWarnings("[WARNING] [w3AddCollection] [setCollectionInfoValue] ["+collName+"] Collection name is not exist");
            return false;
        }
        wncol.COLLECTION_INFO[idx][target] = value;
        return true;
    }

    /**
     * 검색하고자 하는 컬렉션의 모든 검색 필드를 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setAllSearchFieldInfo(int idx) {
        int ret = 0;//설정된 검색필드 전체조건에서 검색
        //WNCollection에 정의된 검색필드 리스트를 얻는다.
        String[] searchFieldList = split(wncol.COLLECTION_INFO[idx][SEARCH_FIELD], ",");
        if (searchFieldList.length < 1) {
            appendWarnings("[WARNING] [w3AddSearchField] [setAllSearchFieldInfo] [" + wncol.COLLECTIONS[idx] + "] SEARCH_FIELD should be defined.");
            return -1;
        }
        int i = checkFieldName("[w3AddSearchField]", wncol.COLLECTIONS[idx], searchFieldList, SEARCH_FIELD);
        if (i != 0) {
            appendWarnings("[WARNING] [w3AddSearchField] [setAllSearchFieldInfo] [" + wncol.COLLECTIONS[idx] + "] '" + searchFieldList[i-1] + "' is not exist.");
            return -1;
        }
        ret = common.setSearchField(wncol.COLLECTIONS[idx], searchFieldList);
        return ret;
    }

    /**
     * 검색하고자 하는 컬렉션의 특정 기본 검색 필드를 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setSearchFieldInfo(int idx) {
        int ret = 0;
        //WNCollection에 정의된 Mapping 필드를 얻는다.
        String[] mappingFields = split(wncol.COLLECTION_INFO[idx][SEARCH_MAPPING], ",");
        //WNCollection에 정의된 검색필드 리스트를 얻는다.
        String[] orgFields = split(wncol.COLLECTION_INFO[idx][SEARCH_FIELD], ",");
        //Parameter 검색필드와 WNCollection 검색필드가 일치할 경우 assign할 array
        String [] sField = new String[searchFields.length];
        if (mappingFields.length < 1) {
            appendWarnings("[WARNING] [w3AddSearchField] [setSearchFieldInfo] [" + wncol.COLLECTIONS[idx] + "] SEARCH_MAPPING should be defined.");
            return -1;
        }
        int k= 0;
        for (int n = 0; n < mappingFields.length; n++) {
            for (int len=0; len < searchFields.length; len++) {
                if (mappingFields[n].equals(searchFields[len])) {
                    sField[k] = orgFields[n]; //Mapping필드에 해당하는 검색필드를 assign한다.
                    k++;
                    break;
                }
            }
        }

        //null 체크
        ArrayList aryLst = new ArrayList();
        for (int i = 0; i < sField.length; i++) {
            if (sField[i] != null) {
                aryLst.add(sField[i]);
            }
        }
        sField = (String[])aryLst.toArray(new String[0]);

        int i = checkFieldName("[w3AddSearchField]", wncol.COLLECTIONS[idx], sField, SEARCH_FIELD);
        if( i != 0 ) {
            appendWarnings("[WARNING] [w3AddSearchField] [setSearchFieldInfo] [" + wncol.COLLECTIONS[idx] + "] '" + searchFields[i-1] + "' is not exist.");
            return -1;
        }
        ret = common.setSearchField(wncol.COLLECTIONS[idx], sField);
        return ret;
    }

    /**
     * 컬렉션 별로 검색어 지정한다.
     * @param idx
     * @return  성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCollectionQuery(int idx) {
        int ret = 0;
        //컬렉션 검색 설정
        if (!wncol.COLLECTION_INFO[idx][COLLECTION_QUERY].equals("")) {
            if (isDebug) {
                checkCollectionQueryFieldName("[w3SetCollectionQuery] [setCollectionQuery]", wncol.COLLECTIONS[idx], wncol.COLLECTION_INFO[idx][COLLECTION_QUERY] );
            }
            ret = common.setCollectionQuery(wncol.COLLECTIONS[idx],
                    wncol.COLLECTION_INFO[idx][COLLECTION_QUERY]);
        }
        return ret;
    }

    /**
     * 검색하고자 하는 컬렉션의 UID 검색을 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @param value 검색하고자 하는 UID 값
     * @return  성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setUid(int idx, String value) {
        int ret = 0;
        if (!value.equals("")) {
            String[] values = split(value,",");
            ret = common.setUid(wncol.COLLECTIONS[idx], values);
        }
        return ret;
    }

    /**
     * 검색하고자 하는 컬렉션의 검색 날짜 범위를 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setDateRange(int idx) {
        int ret = 0;
        //날짜검색 범위 설정
        if (!wncol.COLLECTION_INFO[idx][DATE_RANGE].equals("")) {
            String[] dateFields = split(wncol.COLLECTION_INFO[idx][DATE_RANGE], ",");
            if (dateFields.length < 2) {
                appendWarnings("[WARNING] [w3SetDateRange] [setDateRange] [" + wncol.COLLECTIONS[idx] + "] DATE_RANGE : '" + wncol.COLLECTION_INFO[idx][DATE_RANGE] + "' error.");
                return -1;
            }
            ret = common.setDateRange(wncol.COLLECTIONS[idx], dateFields[0], dateFields[1], dateFields[2]);
        }
        return ret;
    }

    /**
     * 검색하고자 하는 컬렉션의 기본 검색 필드 외에 특정 필드에 키워드를 별도로 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setExQuery(int idx) {
        int ret = 0;
        //확장 검색 설정
        if (!wncol.COLLECTION_INFO[idx][EXQUERY_FIELD].equals("")) {
            if (isDebug) {
                checkExFieldName("[w3AddExQuery] [setExQuery]", wncol.COLLECTIONS[idx], wncol.COLLECTION_INFO[idx][EXQUERY_FIELD]);
            }
            ret = common.setExQuery(wncol.COLLECTIONS[idx], wncol.COLLECTION_INFO[idx][EXQUERY_FIELD]);
        }
        return ret;
    }

    /**
     * 카테고리 부스팅을 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setCategoryBoost(int idx){
        int ret = 0;
        //확장 검색 설정
        if (!wncol.COLLECTION_INFO[idx][CATEGORY_BOOST].equals("")) {
            String[] dataFields = split(wncol.COLLECTION_INFO[idx][CATEGORY_BOOST], ",");

            if (dataFields.length == 4) {
                ret = common.setCategoryBoost(wncol.COLLECTIONS[idx],dataFields[0], dataFields[1],dataFields[2], dataFields[3]);
            }
        }
        return ret;
    }

    /**
     * 검색하고자 하는 컬렉션의 특정 필드의 값으로 필터링 한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setFilterOperation(int idx) {
        int ret = 0;
        if (!wncol.COLLECTION_INFO[idx][FILTER_OPERATION].equals("")) {
            if (isDebug) {
                checkFilterFieldName("[w3AddFilterOperation] [setFilterOperation]", wncol.COLLECTIONS[idx], wncol.COLLECTION_INFO[idx][FILTER_OPERATION]);
            }
            ret = common.setFilterOperation(wncol.COLLECTIONS[idx], wncol.COLLECTION_INFO[idx][FILTER_OPERATION]);
        }
        return ret;
    }

    /**
     * 검색하고자 하는 컬렉션의 특정 필드의 값으로 그룹화 한고 정렬 조건이 있을 경우 정렬한다.
     * @param idx  검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int addMultiGroupBy(int idx) {
        int ret = 0;
        if (!wncol.COLLECTION_INFO[idx][MULTI_GROUP_BY].equals("")) {
            String field = wncol.COLLECTION_INFO[idx][MULTI_GROUP_BY];
            //그룹전달인자 확인
            ret = common.addMultiGroupBy(wncol.COLLECTIONS[idx], field);
        }
        return ret;
    }

    /**
     */
    public String getMultiGroupByResult(String collectionName, String fieldName) {
        int cnt = 0;
        int chk = checkValidCollection("[w3AddMultiGroupBy] [getMultiGroupByResult]", collectionName);
        if (chk == -1) {
            return null;
        }
        return common.getMultiGroupByResult(collectionName, fieldName);
    }

    /**
     * 검색하고자 하는 컬렉션의 특정 필드의 값으로 그룹화 한고 정렬 조건이 있을 경우 정렬한다.
     * @param idx  검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setGroupBy(int idx) {
        int ret = 0;
        if (!wncol.COLLECTION_INFO[idx][GROUP_BY].equals("")) {
            String[] groupby = split(wncol.COLLECTION_INFO[idx][GROUP_BY], ",");
            if (isDebug) {
                // 그룹화할 필드가 fastacces로 잡혀있는지 체크
                if(checkValidField(wncol.COLLECTIONS[idx], groupby[0], FAST_ACCESS) == -1) {
                    appendWarnings("[WARNING] [w3SetGroupBy] [setGroupBy] [" + wncol.COLLECTIONS[idx] + "] " +groupby[0]+ " is not fastaccess field.");
                }
            }
            //그룹전달인자 확인
            if (groupby.length == 2) {
                //그룹화 설정
                ret = common.setGroupBy(wncol.COLLECTIONS[idx], groupby[0], parseInt(groupby[1], 0));
                //그룹 정렬 전달 인자 확인
                ret = addSortFieldInGroup(idx);
            } else {
                appendWarnings("[WARNING] [w3SetGroupBy] [setGroupBy] [" + wncol.COLLECTIONS[idx] + "] " + wncol.COLLECTION_INFO[idx][GROUP_BY]+ "  Check variable format and value.");
            }
        }
        return ret;
    }

    /**
     * 그룹화 된 컬렉션의 정렬을 정한다.
     * @param idx
     * @return 성공이면 0 실패면 0 보다 작은 값 반환
     */
    public int addSortFieldInGroup(int idx) {
        int ret = -1;
        //그룹 정렬 전달인자 확인
        if (wncol.COLLECTION_INFO[idx][GROUP_SORT_FIELD] != "") {
            String[] sortField = split(wncol.COLLECTION_INFO[idx][GROUP_SORT_FIELD], ",");
            if (sortField.length == 2) {
                ret = common.addSortFieldInGroup(wncol.COLLECTIONS[idx], sortField[0], parseInt(sortField[1],0));
            } else {
                appendWarnings("[WARNING] [w3AddSortFieldInGroup] [addSortFieldInGroup] [" + wncol.COLLECTIONS[idx] + "] "
                        + wncol.COLLECTION_INFO[idx][GROUP_SORT_FIELD]+ " Check variable format and value.");
            }
        }
        return ret;
    }

    /**
     * 전체 그룹화 설정된 그룹 수를 가져온다.
     * @param collectionName
     * @return 성공이면 검색결과 개수을 반환한다. 실패하거나 결과가 없을 경우 0 값을 반환한다.
     */
    public int getGroupByCount(String collectionName) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetGroupByCount] [getGroupByCount]", collectionName);
        if (chk == -1) {
            return cnt;
        }
        return common.getGroupByCount(collectionName);
    }

    /**
     * 화면에 보여질 그룹화 설정된 그룹 수를 가져온다.
     * @param collectionName
     * @return 성공이면 검색결과 개수을 반환한다. 실패하거나 결과가 없을 경우 0 값을 반환한다.
     */
    public int getGroupCount(String collectionName) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetGroupCount] [getGroupCount]", collectionName);
        if (chk == -1) {
            return cnt;
        }
        return common.getGroupCount(collectionName);
    }

    /**
     * 그룹에 속하는 문서중 가져온 문서 개수를 구한다.
     * @param collectionName
     * @param groupIndex
     * @return 그룹에 속하는 전제문서 개수를 반환한다. 실패하거나 결과가 없을 경우 0 보다 작은값 반환한다.
     */
    public int getTotalCountInGroup(String collectionName, int groupIndex) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetTotalCountInGroup] [getTotalCountInGroup]", collectionName);
        if (chk == -1) {
            return cnt;
        }
        return common.getTotalCountInGroup(collectionName, groupIndex);
    }

    /**
     *
     * @param collectionName
     * @param groupIndex
     * @return 그룹에 속하는 문서중 가져온 문서 개수를 반환한다. 실패하거나 결과가 없을 경우 0 보다 작은값 반환한다.
     */
    public int getCountInGroup(String collectionName, int groupIndex) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetCountInGroup] [getCountInGroup]", collectionName);
        if (chk == -1) {
            return cnt;
        }
        return common.getCountInGroup(collectionName, groupIndex);
    }

    /**
     * 그룹에 속하는 문서중 특정 문서의 필드값을 구한다.
     * @param collectionName
     * @param fieldName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 특정 문서의 필드값을 반환한다. 실패할 경우 null값을 반환한다.
     */
    public String getFieldInGroup(String collectionName, String fieldName, int groupIndex, int docIndex) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetCountInGroup] [getCountInGroup]", collectionName);
        if (chk == -1) {
            return null;
        }
        chk = checkValidField(collectionName, fieldName, RESULT_FIELD);
        if (chk == -1) {
            appendWarnings("[WARNING] [w3AddDocumentField] [setResultFieldInfo] [" + collectionName + "] RESULT_FIELD should be defined.");
            return null;
        }
        return common.getFieldInGroup(collectionName, fieldName, groupIndex, docIndex);
    }

    /**
     * 그룹에 속하는 문서중 특정 문서의 UID값을 구한다.
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 특정 문서의 UID값을 반환한다. 실패할 경우 0보다 작은 값을 반환한다.
     */
    public long getUidInGroup(String collectionName, int groupIndex, int docIndex) {
        int cnt = 0;
        int chk = checkValidCollection("[w3getUidInGroup] [getCountInGroup]", collectionName);
        if (chk == -1) {
            return -1;
        }
        return common.getUidInGroup(collectionName, groupIndex, docIndex);
    }

    /**
     * 그룹에 속하는 문서중 특정 문서의 가중치값을 구한다.
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 특정 문서의 가중치값을 반환한다. 실패할 경우 0보다 작은 값을 반환한다.
     */
    public long getWeightInGroup(String collectionName, int groupIndex, int docIndex) {
        int cnt = 0;
        int chk = checkValidCollection("[w3getUidInGroup] [getCountInGroup]", collectionName);
        if (chk == -1) {
            return -1;
        }
        return common.getWeightInGroup(collectionName, groupIndex, docIndex);
    }

    /**
     * 그룹에 속하는 문서중 특정 문서의 날짜정보값을 구한다.
     * @param collectionName
     * @param groupIndex
     * @param docIndex
     * @return 그룹에 속하는 문서중 특정 문서의 날짜정보값을 반환한다. 실패할 경우 빈문자열을 반환한다.
     */
    public String getDateInGroup(String collectionName, int groupIndex, int docIndex) {
        int cnt = 0;
        int chk = checkValidCollection("[w3getUidInGroup] [getCountInGroup]", collectionName);
        if (chk == -1) {
            return "";
        }
        return common.getDateInGroup(collectionName, groupIndex, docIndex);
    }

    /**
     * 검색하고자 하는 컬렉션의 결과 필드를 설정한다.
     * @param idx 검색하고자 하는 컬렉션의 index
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int setResultFieldInfo(int idx) {
        int ret = 0;
        String[] resultFields = split(wncol.COLLECTION_INFO[idx][RESULT_FIELD],",");
        if (resultFields.length < 1) {
            appendWarnings("[WARNING] [w3AddDocumentField] [setResultFieldInfo] [" + wncol.COLLECTIONS[idx] + "] RESULT_FIELD should be defined.");
            return -1;
        }
        int i = checkFieldName("[w3AddDocumentField]", wncol.COLLECTIONS[idx], resultFields, RESULT_FIELD);
        if ( i != 0) {
            appendWarnings("[WARNING] [w3AddDocumentField] [setResultFieldInfo] [" + wncol.COLLECTIONS[idx] + "] '" + resultFields[i-1] + "' is not exist.");
            return -1;
        }
        ret = common.setResultField(wncol.COLLECTIONS[idx], resultFields);
        return ret;
    }

    /**
     * w3AddFilterOperation에 필요한 검색 조건 값을 조합한다.
     * @param fieldName 검색 필드 이름
     * @param value 필터링 조건 값
     * @param operation 필터링 조건 연산자
     * @param flag 필터링 조건 연산자 값
     * @return  w3AddFilterOperation에 검색 조건 값을 반환한다.
     */
    public String makeFilterOperation(String fieldName, String value, String operation, String flag) {
        StringBuffer buf = new StringBuffer();
        String values[] = split(value, " ");
        for (int i = 0; i < values.length; i++) {
            buf.append(" ").append(fieldName).append("<").append(operation).append(">").append(values[i]).append(flag);
        }
        return buf.toString();
    }

    /**
     * w3AddExQuery에 필요한 검색 조건 값을 조합한다.
     * @param exFieldValue ExQuery로 생성된 결과 값
     * @param fieldName 검색 필드
     * @param value 검색 키워드
     * @param operation 검색 연산자
     * @return w3AddExQuery에 필요한 검색 조건 값을 반환한다.
     */
    public String makeExField(String exFieldValue, String fieldName, String value, String operation) {
        StringBuffer buf = new StringBuffer();
        String[] values = split(value, " ");
        for (int i = 0; i < values.length; i++) {
            if (exFieldValue.trim().length() > 0 || i > 0) {
                buf.append(operation).append(fieldName).append(":").append(values[i]);
            } else {
                buf.append(fieldName).append(":").append(values[i]);
            }
        }
        return buf.toString();
    }

    /**
     * 검색 조건을 만족하는 레코드로 가져온 개수,
     * 검색 조건의 start 위치에서부터 count보다 같거나 작은 개수를 가져온다.
     * @param collectionName
     * @return 성공이면 검색결과 개수을 반환한다. 실패하거나 결과가 없을 경우 0 값을 반환한다.
     */
    public int getResultCount (String collectionName) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetResultCount] [getResultCount]", collectionName);
        if (chk == -1) {
            return cnt;
        }
        return common.getResultCount(collectionName);
    }

    /**
     * 검색 조건을 만족하는 총 검색 결과 개수
     * @param collectionName
     * @return 성공이면 검색결과 총 개수을 반환한다. 실패하거나 결과가 없을 경우 0 값을 반환한다.
     */
    public int getResultTotalCount (String collectionName) {
        int cnt = 0;
        int chk = checkValidCollection("[w3GetResultTotalCount] [getResultTotalCount]", collectionName);
        if (chk == -1) {
            return cnt;
        }
        return common.getResultTotalCount(collectionName);
    }

    /**
     * 현재 검색 되고 있는 실시간 검색어 리스트를 얻는다.
     * @param count 실시간 검색어 개수
     * @return 실시간 검색어 리스트를 반환한다.
     */
    public String recvRealTimeSearchKeywordList(int count) {
        StringBuffer sbKey = new StringBuffer();
        String[] keywordList = common.recvRealTimeSearchKeywordList(CONNECTION_CLOSE, count);
        if (keywordList != null) {
            int keyCount = keywordList.length;
            for (int i = 0; i < keyCount; i++) {
                sbKey.append("'").append(keywordList[i].replaceAll("'", "").replaceAll("\\\\", "")).append("'");
                if (i < keywordList.length - 1) {
                    sbKey.append(",");
                }
            }
        } else {
            return "";
        }
        return sbKey.toString();
    }

    /**
     * 검색 결과 필드의 값을 얻는다. field명에 따라서 UID, RANK, DATE 값을 얻을 수 있다.
     * @param collectionName 결과를 얻고자 하는 컬렉션 이름
     * @param field 결과 필드
     * @param idx 검색결과 컬렉션의 index
     * @param isHL 하이라이팅을 할 것인지 여부를 결정
     * @return FIELD VALUE
     */
    public String getField(String collectionName, String field, int idx, boolean isHL) {
        String ret = "";
        if (collectionName.equals("")) {
            return ret;
        }

        if (field.toUpperCase().equals("UID")) {
            ret = String.valueOf(common.getUid(collectionName, idx));
        } else if (field.toUpperCase().equals("RANK")) {
            ret = String.valueOf(common.getRank(collectionName, idx));
        } else  if (field.toUpperCase().equals("DATE")) {
            ret = parseDate(common.getDate(collectionName, idx),"yyyy/MM/dd HH:mm:ss","yyyy.MM.dd");
        } else  if (field.toUpperCase().equals("WEIGHT")) {
            ret = String.valueOf(common.getWeight(collectionName, idx));
        } else {
            if (checkValidField(collectionName, field, RESULT_FIELD) == -1) {
                return ret;
            }
            if (isHL) {
                ret = getKeywordHl(common.getField(collectionName, field ,idx), "red");
            } else {
                ret = common.getField(collectionName, field ,idx);
            }
        }
        return ret;
    }

    /**
     * 네트워크 종료
     */
    public void closeServer(){
        common.closeServer();
    }


    /**
     * 검색된 키워드의 분석 결과의 리스트를 얻어서 인자로 받은 문자열에 하이라이팅 한다.
     * @param content 하이라이팅 하고자 하는 문자열
     * @param color
     * @return 하이라이팅된 문자열을 반환한다.
     */
    public String getKeywordHl(String content, String color) {
        if (content != null) {
            content = content.replaceAll("<!HS>", "<font color='" + color + "'>");
            content = content.replaceAll("<!HE>", "</font>");
        }
        return content;
    }


    /**
     * 검색된 키워드의 분석 결과의 리스트를 얻어서 인자로 받은 문자열에 하이라이팅 한다.
     * @param content 하이라이팅 하고자 하는 문자열
     * @param startTag 하이라이팅 하고자 하는 Tag의 시작 문자
     * @param endTag 하이라이팅 하고자 하는 Tag의 끝 문자
     * @return 하이라이팅된 문자열을 반환한다.
     */
    public String getKeywordHl(String content, String startTag, String endTag) {
        if (content != null) {
            content = replace(content, "<!HS>", startTag);
            content = replace(content, "<!HE>", endTag);
        }
        return content;
    }


    /**
     * WNCollection에서 정의된 COLLECTIONS의 index를 얻는다.
     * @param collName 검색하고자 하는 컬렉션의 이름
     * @return 컬렉션 index를 반환한다.
     */
    public int getCollIdx(String collName) {
        for (int i = 0; i < wncol.COLLECTIONS.length; i++) {
            if (wncol.COLLECTIONS[i].equals(collName)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * 형태소 분석 및 대소문자 값을 체크한다.
     * @param useKma 형태소 분석 값
     * @param isCase 대소문자 구분 여부
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkKeywordAnalyzer(String collectionName, int useKma, int isCase) {
        int chk = 0;
        if (useKma != 0 && useKma != 1 && useKma != 2) {
            appendWarnings("[WARNING] [w3SetQueryAnalyzer] [checkKeywordAnalyzer] ["+ collectionName + "] '" + useKma + "' is not kma option");
            return -1;
        }
        if (isCase != 0 && isCase != 1) {
            appendWarnings("[WARNING] [w3SetQueryAnalyzer] [checkKeywordAnalyzer] ["+ collectionName + "] '" + isCase + "' is not case option");
            return -1;
        }
        return chk;
    }

    /**
     * 검색하고자 하는 컬렉션을 체크한다.
     * @param collectionName 검색하고자 하는 컬렉션
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkValidCollection(String msg, String collectionName) {
        int chk = -1;
        for (int i = 0; i < wncol.COLLECTIONS.length; i++) {
            if (collectionName.equals(wncol.COLLECTIONS[i])) {
                chk =i;
                break;
            }
        }
        if(chk == -1) {
            appendWarnings("[WARNING] "+msg+" [" + collectionName + "] Collection name is not exist.");
        }
        return chk;
    }

    /**
     * 필드를 체크하는 각 함수에서 사용된다.
     * @param collectionName 검색하고자 하는 컬렉션
     * @param field 필드 이름
     * @param item WNCollection에 지정된 상수
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkValidField(String collectionName, String field, int item) {
        int idx = getCollIdx(collectionName);
        String[] fields = split(wncol.COLLECTION_INFO[idx][item], ",");
        int chk = findArrayValue(field, fields);
        return chk;
    }

    /**
     * 검색하고자 하는 컬렉션의 각 필드 값을 체크한다.
     * @param msg 화면에 출력할 메시지
     * @param collectionName 검색하고자 하는 컬렉션
     * @param fields 체크하고자 하는 필드
     * @param item WNCollection에 지정된 상수
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkFieldName(String msg, String collectionName, String[] fields, int item) {
        int chk = 0;
        for (int i = 0; i<fields.length; i++) {
            if(fields[i] == null || (checkValidField(collectionName, fields[i], item) == -1)) {
                return i+1;
            }
        }
        return chk;
    }

    /**
     * 검색하고자 하는 컬렉션의 확장 필드 값을 체크한다.
     * @param msg 화면에 출력할 메시지
     * @param collectionName 검색하고자 하는 컬렉션
     * @param value 체크하고자 하는 필드
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkExFieldName(String msg, String collectionName, String value) {
        int chk = 0;
        String[] replaceChar = new String[]{"!", "|", "(", ")", "[", "]", "{", "}", "\"", "^", "<", ">"};
        for (int i = 0; i < replaceChar.length; i++) {
            value = replace(value, replaceChar[i], " ");
        }

        String[] fieldName = split(value, " ");
        for (int i = 0; i < fieldName.length; i++) {
            int index = 0;
            if (fieldName[i].indexOf(":", 0) != -1) {
                index = fieldName[i].indexOf(":", 0);
                fieldName[i] = fieldName[i].trim().substring(0, index);
            }
            // 확장검색 필드 검사
            if (checkValidField(collectionName, fieldName[i], PREFIX_FIELD) == -1) {
                appendWarnings("[WARNING] " + msg + "[" + collectionName + "] " +fieldName[i]+ " is not prefix field.");
                chk = -1;
            }
        }
        return chk;
    }

    /**
     * 검색하고자 하는 컬렉션의 쿼리 필드 값을 체크한다.
     * @param msg 화면에 출력할 메시지
     * @param collectionName 검색하고자 하는 컬렉션
     * @param value 체크하고자 하는 필드
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkCollectionQueryFieldName(String msg, String collectionName, String value) {
        int chk = 0;
        String[] replaceChar = new String[]{"!", "|", "(", ")", "[", "]", "{", "}", "\"", "^", "<", ">"};
        for (int i = 0; i < replaceChar.length; i++) {
            value = replace(value, replaceChar[i], " ");
        }

        String[] fieldName = split(value, " ");
        for (int i = 0; i < fieldName.length; i++) {
            int index = 0;
            if (fieldName[i].indexOf(":", 0) != -1) {
                index = fieldName[i].indexOf(":", 0);
                fieldName[i] = fieldName[i].trim().substring(0, index);
            }
            String[] fields = fieldName[i].split(",");
            for (int j = 0; j < fields.length; j++) {
                // 컬렉션 쿼리 필드 검사
                if (checkValidField(collectionName, fields[j], PREFIX_FIELD) != -1) {
                    appendWarnings("[WARNING] " + msg + "[" + collectionName + "] " +fields[j]+ " is prefix field.");
                    chk = -1;
                }
            }
        }
        return chk;
    }

    /**
     * 검색하고자 하는 컬렉션의 필터링 필드 값을 체크한다.
     * @param msg 화면에 출력할 메시지
     * @param collectionName 검색하고자 하는 컬렉션
     * @param value 체크하고자 하는 필드
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkFilterFieldName(String msg, String collectionName, String value) {
        int chk = 0;
        String[] replaceChar = new String[]{"|", "(", ")", "[", "]", "{", "}", "\"", "^"};
        for (int i = 0; i < replaceChar.length; i++) {
            value = replace(value, replaceChar[i], " ");
        }

        String[] fieldName = split(value, " ");
        for (int i = 0; i < fieldName.length; i++) {
            int index = 0;
            if (fieldName[i].indexOf("<", 0) != -1) {
                index = fieldName[i].indexOf("<", 0);
                fieldName[i] = fieldName[i].trim().substring(0, index);
                // 필터링 검색 필드 검사
                if (checkValidField(collectionName, fieldName[i], FAST_ACCESS) == -1) {
                    appendWarnings("[WARNING] " + msg + " [" + collectionName + "] " +fieldName[i]+ " is not fastaccess field.");
                    chk = -1;
                }
            }
        }
        return chk;
    }

    /**
     * 검색결과의 지정 범위를 체크한다.
     * @param collectionName 검색하고자 하는 컬렉션
     * @param highlight 하이라이팅 옵션 값
     * @param startPos 검색결과 시작 offset
     * @param resultCnt 검색 결과 count
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkSetPageInfo(String collectionName, int highlight, int startPos, int resultCnt) {
        int chk = 0;
        if (highlight < 0 || highlight> 3 || startPos < 0 || resultCnt < 0) {
            appendWarnings("[WARNING] [] [checkSetPageInfo] [" + collectionName + "] Highlight: '"
                    + highlight + "', StartPosition: '"+startPos+ "', ResultCount: '"+resultCnt+"' is invalid value");
            return -1;
        }
        return chk;
    }

    /**
     * 검색 정렬 필드를 체크한다.
     * @param collectionName 검색하고자 하는 컬렉션
     * @param sortField 정렬필드
     * @param sortOrder 오름차순/내림차순
     * @return 성공이면 0을 반환한다. 실패면 0이 아닌 값을 반환한다.
     */
    public int checkSortFieldName(String collectionName, String sortField, int sortOrder) {
        int chk = 0;
        if (sortField.toUpperCase().equals("DATE")) {
            if (sortOrder != 1 && sortOrder != 0) {
                //DATE는 오름차순(0)과 내림차순(1)으로만 정렬 가능
                appendWarnings("[WARNING] [w3AddSortField] [checkSortFieldName] [" + collectionName + "] Date sortOrder : '" + sortOrder + "' Only 0 or 1");
                return -1;
            }
        } else if (sortField.toUpperCase().equals("RANK")) {
            if (sortOrder != 1) {
                //RANK는 내림차순(1)으로만 정렬 가능
                appendWarnings("[WARNING] [w3AddSortField] [checkSortFieldName] [" + collectionName + "] RANK sortOrder '" + sortOrder +"' Only 1");
                return -1;
            }
        }else if (sortField.toUpperCase().equals("WEIGHT")) {
            if (sortOrder != 1 && sortOrder != 0) {
                //WEIGHT는 오름차순(0)과 내림차순(1)으로만 정렬 가능
                appendWarnings("[WARNING] [w3AddSortField] [checkSortFieldName] [" + collectionName + "] WEIGHT sortOrder '" + sortOrder +"' Only 0 or 1");
                return -1;
            }
        }else {
            // 정렬 필드 검사
            if (checkValidField(collectionName, sortField, RESULT_FIELD) == -1) {
                appendWarnings("[WARNING] [w3AddSortField] [checkSortFieldName] [" + collectionName + "] '" + sortField + "' is not exist.");
                return -1;
            }
            if (checkValidField(collectionName, sortField, FAST_ACCESS) == -1) {
                // fastaccess가 지정되지 않은 필드에서 속도 느릴수 있음.
                appendWarnings("[WARNING] [w3AddSortField] [checkSortFieldName] [" + collectionName + "] " +sortField+ " is not fastaccess field.");
            }
        }
        return chk;
    }

    /**
     * 디버그 메시지를 구성한다.
     * @param isRealQuery
     * @param query
     */
    public void debugMsg(boolean isRealQuery, String query){
        sb.append("[CHARSET] " + CHARSET + " [QUERY] " + query);
        sb.append("<br>[w3ConnectServer] [IP] " + wncol.SEARCH_IP + " [PORT] " + wncol.SEARCH_PORT + " [TIMEOUT]" + CONNECTION_TIMEOUT);
        if (!isUidSrch) {
            sb.append("<br>[w3RecvResult] Mode : " + this.connectionOpt);
            if (isRealQuery) {
                sb.append("<br>[w3GetRealTimeSearchKeywordList] Set Count : " + REALTIME_COUNT);
            }
        }

        sb.append("<br>");
        for (int i = 0; i < collections.length; i++) {
            int idx = getCollIdx(collections[i]);

            if (idx < 0) {
                return;
            }
            int count = 0;

            // 컬렉션 정보
            String content = wncol.COLLECTION_INFO[idx][INDEX_NAME];
            if (content != null && !content.equals("")) {
                sb.append("<br>[w3AddCollection] <b>" + content + "</b>");
            }
            if (!isUidSrch) {
                //페이지 설정
                content = wncol.COLLECTION_INFO[idx][PAGE_INFO];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3SetPageInfo] " + content);
                }

                //분석 정보
                content = wncol.COLLECTION_INFO[idx][ANALYZER];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3SetQueryAnalyzer] " + content);
                }

                //하이라이팅 정보
                count = this.hiSum;
                if (count >= 0) {
                    switch (count) {
                        case 0:
                            content = " : Highlight off, Summarize off.";break;
                        case 1:
                            content = " : Highlight off, Summarize on.";break;
                        case 2:
                            content = " : Highlight on, Summarize off.";break;
                        case 3:
                            content = " : Highlight on, Summarize on.";break;
                        default:
                            content = " : wrong infomation";
                    }
                    sb.append("<br>[w3SetQueryAnalyzer] " + count + content);
                }

                //정렬 정보
                content = wncol.COLLECTION_INFO[idx][SORT_FIELD];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3AddSortField] " + content);
                }

                //검색 필드 정보
                String [] searchField = null;
                if (isAllSearchField) {
                    String search_field = wncol.COLLECTION_INFO[idx][SEARCH_FIELD];
                    searchField = search_field.split(",");
                } else {
                    //WNCollection에 정의된 Mapping 필드를 얻는다.
                    String[] mappingFields = split(wncol.COLLECTION_INFO[idx][SEARCH_MAPPING], ",");
                    //WNCollection에 정의된 검색필드 리스트를 얻는다.
                    String[] orgFields = split(wncol.COLLECTION_INFO[idx][SEARCH_FIELD], ",");
                    //Parameter 검색필드와 WNCollection 검색필드가 일치할 경우 assign할 array
                    searchField = new String[searchFields.length];

                    if (mappingFields.length > 0) {
                        int k= 0;
                        for (int n = 0; n < mappingFields.length; n++) {
                            for (int len = 0; len < searchFields.length; len++) {
                                if (mappingFields[n].equals(searchFields[len])) {
                                    searchField[k] = orgFields[n]; //Mapping필드에 해당하는 검색필드를 assign한다.
                                    k++;
                                    break;
                                }
                            }
                        }
                    }
                }

                content = wncol.COLLECTION_INFO[idx][SEARCH_FIELD];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3AddSearchField] " );
                    for (int k = 0; k<searchField.length; k++) {
                        if (k != 0) {
                            sb.append(", ");
                        }
                        sb.append(searchField[k]);
                    }
                }

                //검색 필드 매핑 정보
                content = wncol.COLLECTION_INFO[idx][SEARCH_MAPPING];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[SEARCH_MAPPING] " + content);
                }

                //기간 정보
                content = wncol.COLLECTION_INFO[idx][DATE_RANGE];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3SetDateRange] " + content);
                }

                //확장 검색  정보
                content = wncol.COLLECTION_INFO[idx][EXQUERY_FIELD];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3AddExQuery] " + content.replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
                }

                //카테고리 부스트 정보
                content = wncol.COLLECTION_INFO[idx][CATEGORY_BOOST];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3SetCategoryBoost] " + content);
                }

                //컬렉션 쿼리 정보
                content = wncol.COLLECTION_INFO[idx][COLLECTION_QUERY];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3SetCollectionQuery] " + content.replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
                }

                //필터 정보
                content = wncol.COLLECTION_INFO[idx][FILTER_OPERATION];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3AddFilterOperation] " + content.replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
                }

                //그룹화  정보
                content = wncol.COLLECTION_INFO[idx][GROUP_BY];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3SetGroupBy] " + content);
                }

                //그룹 정렬  정보
                content = wncol.COLLECTION_INFO[idx][GROUP_SORT_FIELD];
                if (content != null && !content.equals("")) {
                    sb.append("<br>[w3AddSortFieldInGroup] " + content);
                }

					/*
					content = COLLECTION_INFO[idx][PROPERTY_GROUP];
					if(content != null && !content.equals("")){
						sb.append("<br>[PROPERTY_GROUP] " + content);
					}
					*/

                if (!wncol.COLLECTION_INFO[idx][GROUP_BY].equals("")) {
                    //전체 그룹 개수 정보
                    count = getGroupByCount(collections[i]);
                    if (count > 0) {
                        sb.append("<br>[w3GetGroupBycount] " + count);
                    }

                    //페이지 보여지는 그룹  개수 정보
                    count = getGroupCount(collections[i]);
                    if (count > 0) {
                        sb.append("<br>[w3GetGroupCount] " + count);
                        sb.append("<br>[w3GetTotalCountInGroup] ");
                        for (int j = 0; j < count; j++) {
                            if (j != 0) {
                                sb.append(", ");
                            }
                            sb.append(getTotalCountInGroup(collections[i], j));
                        }
                        sb.append("<br>[w3GetCountInGroup] ");
                        for (int j = 0; j < count; j++) {
                            if (j != 0) {
                                sb.append(", ");
                            }
                            sb.append(getCountInGroup(collections[i], j));
                        }
                    }
                }
            }

            //결과 필드 정보
            content = wncol.COLLECTION_INFO[idx][RESULT_FIELD];
            if (content != null && !content.equals("")) {
                sb.append("<br>[w3AddDocumentField] " + content);
            }

            //sb.append("<br>[PREFIX_FIELD] " + COLLECTION_INFO[idx][PREFIX_FIELD]);
            //sb.append("<br>[FAST_ACCESS] " + COLLECTION_INFO[idx][FAST_ACCESS]);
            sb.append("<br>");
        }
    }

    /**
     * 경고 메시지를 버퍼에 저장한다.
     * @param msg 경고 메시지
     */
    public void appendWarnings(String msg) {
        if (isDebug && !msg.equals("")) {
            warningMsg.append(msg + "<br>");
        }
    }


    /**
     * 에러 메시지를 버퍼에 저장한다.
     * @param msg 에러 메시지
     */
    public void appendErrors(String msg) {
        if (!msg.equals("")) {
            sb.append("<br>" + msg + "<br>");
        }
    }

    /**
     * 디버그 정보를 화면에 출력할 경우 메시지를 반환한다.
     * @return 디버그 정보 반환
     */
    public String printDebug() {
        if (!warningMsg.toString().equals("")) {
            return sb.toString() + "<br>" + warningMsg.toString()+ "<br>";
        }
        return sb.toString();
    }

    /**
     * 관리도구의 경로를 지정한다.
     * @param managerURL 관리도구 경로
     */
    public void setManagerMode(String managerURL) {
        if (managerURL != null && !managerURL.trim().equals("")) {
            this.managerURL = managerURL;
        }
    }

    /*
     * 매니저 동작 준비 테그를 생성한다.
     * @param colName 컬렉션 명
     * @param idx 결과 인덱스
     * @param docid 특정 결과 DOCID
     * @return 매니저 동작 준비 테그
     */
    public String getManagerOperationTag(String colName, int idx, String docid) {
        String uniid = colName + "_" + idx;
        if (!this.managerURL.equals("")) {
            return "<input type='checkbox' name='manager_idx' id='" + uniid + "'  value='checkbox' onclick=\"javascript:manager_addDocIdForDelete('" + colName + "', '" + docid + "', '" + uniid + "')\" />" + docid + "&nbsp";
        } else {
            return "";
        }
    }

    /*
     * 매니저 동작 테그를 생성한다.
     * @param transferURL xml 파싱 파일 경로
     * @return 매니저 동작 테그
     */
    public String getManagerActionTag(String transferURL) {
        if (!this.managerURL.equals("")) {
            return "<input type='button'  value='Delete' onclick=\"javascript:manager_runDelete('" + transferURL + "', '" + this.managerURL + "', '" + wncol.SEARCH_IP + "', " + wncol.SEARCH_PORT + ")\" />";
        } else {
            return "";
        }
    }

    /**
     * 검색 결과 페이징 번호를 출력한다.
     * @param startCount 검색 결과 시작 offset
     * @param totalCount 검색 결과의 총 개수
     * @param viewListCount 검색결과로 요청된 offset의 개수
     * @param bundleCount 페이지 이동할 개수
     * @return 페이징 문자열 반환
     */
    public String getPageLinks(int startCount, int totalCount, int viewListCount, int bundleCount) {
        StringBuffer sbRet = new StringBuffer();
        WNAnchor wnanchor = getPageAnchor(startCount, totalCount, viewListCount, bundleCount);
        String ppreImg="";
        String preImg="";
        String nextImg="";
        String nnextImg="";
        ppreImg = "<IMG SRC='images/icon_first.gif' BORDER='0' align='absmiddle'>";
        preImg = "<IMG SRC='images/icon_preview.gif' BORDER='0' align='absmiddle'>";
        nextImg = "<IMG SRC='images/icon_next.gif' BORDER='0' align='absmiddle'>";
        nnextImg = "<IMG SRC='images/icon_end.gif' BORDER='0' align='absmiddle'>";
        if (wnanchor.getFirstPage() != -1) {
            sbRet.append("<A HREF=\"javascript:goPage('"+wnanchor.getFirstPage()+"');\"  ONFOCUS='this.blur();'>"+ppreImg+"</A>&nbsp;");
        } else {
            sbRet.append(ppreImg+"&nbsp;");
        }

        if (wnanchor.getBundleBefore() != -1) {
            sbRet.append("<A HREF=\"javascript:goPage('"+wnanchor.getBundleBefore()+"');\"  ONFOCUS='this.blur();'>"+preImg+"</A>&nbsp;");
        } else {
            sbRet.append(preImg+"&nbsp;");
        }
        int pageCount = wnanchor.getPageCount();
        String pages[][] = wnanchor.getPages();

        for (int i = 0; i<pageCount && i < pages.length; i++) {
            if (pages[i][1].equals("-1")) {
                sbRet.append(pages[i][0]+"");
            } else {
                sbRet.append("<A HREF=\"javascript:goPage('"+pages[i][1]+"');\"  ONFOCUS='this.blur();' class='nav'> "+pages[i][0]+" </A>");
            }

            if (pageCount > i+1) {
                sbRet.append("    &nbsp;&nbsp;|&nbsp;&nbsp;");// 페이지 경계 1 | 2 | 3
            }
        }
        if (wnanchor.getBundleNext() != -1) {
            sbRet.append("&nbsp;<A HREF=\"javascript:goPage('"+wnanchor.getBundleNext()+"');\" ONFOCUS='this.blur();'>"+nextImg+"</A>");
        } else {
            sbRet.append("&nbsp;"+nextImg+"");
        }

        if (wnanchor.getLastPage() != -1) {
            sbRet.append("&nbsp;<A HREF=\"javascript:goPage('"+wnanchor.getLastPage()+"');\" ONFOCUS='this.blur();'>"+nnextImg+"</A>");
        } else {
            sbRet.append("&nbsp;"+nnextImg+"");
        }
        return sbRet.toString();
    }

    /**
     * 페이지 Anchor를 생성한다.
     * @param startNum 검색 결과 시작 offset
     * @param totalcount 검색 결과의 총 개수
     * @param resultCnt 검색결과로 요청된 offset의 개수
     * @param anchorSacle 페이지 이동할 개수
     * @return WNAnchor Object를 반환
     */
    public WNAnchor getPageAnchor(int startNum, int totalcount, int resultCnt, int anchorSacle) {
        WNAnchor anchor = new WNAnchor();

        if (totalcount == 0) {   //등록된 정보가 없으면 페이지 Anchor를 생성 하지 않는다.
            return anchor;
        }

        int curBunbleNum = startNum / (resultCnt * anchorSacle);
        int totalPageCnt = totalcount / resultCnt;
        if (totalcount % resultCnt > 0) {
            totalPageCnt++;
        }
        anchor.setTotalPgCount(totalPageCnt);      // 전체 페이지 세팅

        if (startNum > 0) {        // 이전 페이지
            int beforePg = startNum - resultCnt;
            anchor.setBefore(beforePg);
        }

        if (startNum+resultCnt < totalcount) {        // 다음페이지
            int nextPg = startNum + resultCnt;
            anchor.setNext(nextPg);
        }

        //번들 뒤로 이동
        int bunbleBeforePg = (curBunbleNum-1) * resultCnt * anchorSacle;    //이전 번들로 이동하는 번호
        if (curBunbleNum > 0) {
            anchor.setBundleBefore(bunbleBeforePg);
        }

        //번들 앞으로 이동
        int bundleNextPg = (1 + curBunbleNum) * anchorSacle * resultCnt;
        if (totalPageCnt >= anchorSacle && (curBunbleNum+1) * anchorSacle <  totalPageCnt) {
            anchor.setBundleNext(bundleNextPg);
        }

        //맨처음..
        if (startNum != 0 && curBunbleNum != 0) {
            anchor.setFirstPage(0);
        }
        //맨끝...
        int lastPage = (resultCnt * totalPageCnt) - resultCnt ;
        if(totalPageCnt >= anchorSacle && (curBunbleNum+1) * anchorSacle <  totalPageCnt) {
            anchor.setLastPage(lastPage);
        }

        int pageCount = 1;
        String[][] pages = new String[anchorSacle][2];
        for (int i = 0; i < anchorSacle; i++) {
            int startCnt = ((curBunbleNum * anchorSacle) + i) * resultCnt;
            int pageNum = (curBunbleNum * anchorSacle) + i + 1;
            if (startCnt < totalcount) {
                if (startCnt != startNum) {
                    pages[i][0] = Integer.toString(pageNum);
                    pages[i][1] = Integer.toString(startCnt);
                } else {
                    pages[i][0] = Integer.toString(pageNum);
                    pages[i][1] = "-1";
                    anchor.setCurPageNumber(pageNum);
                }
                anchor.setPageCount(pageCount);
                pageCount++;
            }
        }
        anchor.setPages(pages);
        return anchor;
    }



    /**
     * 검색 결과 페이징 번호를 출력한다.
     * @param startCount 검색 결과 시작 offset
     * @param totalCount 검색 결과의 총 개수
     * @param viewListCount 검색결과로 요청된 offset의 개수
     * @param bundleCount 페이지 이동할 개수
     * @return 페이징 문자열 반환
     */
    public String getPageLinksWebAccess(String base, String url, int startCount, int totalCount, int viewListCount, int bundleCount) {

        String RequestURI = base;
        String RequestURL = url;

        StringBuffer sbRet = new StringBuffer();
        WNAnchor wnanchor = getPageAnchor(startCount, totalCount, viewListCount, bundleCount);
        String ppreImg="";
        String preImg="";
        String nextImg="";
        String nnextImg="";
        ppreImg = "<IMG SRC='images/navi/icon_first.gif' BORDER='0' align='absmiddle'>";
        preImg = "<IMG SRC='images/navi/icon_preview.gif' BORDER='0' align='absmiddle'>";
        nextImg = "<IMG SRC='images/navi/icon_next.gif' BORDER='0' align='absmiddle'>";
        nnextImg = "<IMG SRC='images/navi/icon_end.gif' BORDER='0' align='absmiddle'>";

        if (wnanchor.getFirstPage() != -1) {
            sbRet.append("<A HREF='" + replaceURL(RequestURI, RequestURL, "startCount",String.valueOf(wnanchor.getFirstPage())) +"'  >"+ppreImg+"</A>&nbsp;&nbsp;");
        } else {
            sbRet.append(ppreImg+"&nbsp;");
        }
        if (wnanchor.getBundleBefore() != -1) {
            sbRet.append("<A HREF='" + replaceURL(RequestURI, RequestURL, "startCount", String.valueOf(wnanchor.getFirstPage())) +"'  >"+preImg+"</A>&nbsp;&nbsp;");
        } else {
            sbRet.append(preImg+"&nbsp;");
        }

        int pageCount = wnanchor.getPageCount();
        String pages[][] = wnanchor.getPages();

        for (int i = 0; i<pageCount && i < pages.length; i++) {
            if (pages[i][1].equals("-1")) {
                sbRet.append("<b>" + pages[i][0]+"</b>");
            } else {
                sbRet.append("<A HREF='" + replaceURL(RequestURI,RequestURL,"startCount", String.valueOf(pages[i][1])) + "' class='nav'> "+pages[i][0]+" </A>");
            }
            if (pageCount > i+1) {
                sbRet.append("&nbsp;|&nbsp;");// 페이지 경계 1 | 2 | 3
            }
        }
        if (wnanchor.getBundleNext() != -1) {
            sbRet.append("&nbsp;&nbsp;<A HREF='" + replaceURL(RequestURI,RequestURL,"startCount",String.valueOf(wnanchor.getBundleNext())) + "'>"+nextImg+"</A>");
        } else {
            sbRet.append("&nbsp;&nbsp;"+nextImg+"");
        }
        if (wnanchor.getLastPage() != -1) {
            sbRet.append("&nbsp;&nbsp;<A HREF='" + replaceURL(RequestURI,RequestURL,"startCount",String.valueOf(wnanchor.getLastPage())) + "'>"+nnextImg+"</A>");
        } else {
            sbRet.append("&nbsp;&nbsp;"+nnextImg+"");
        }
        return sbRet.toString();
    }

    /**
     * 하이라이팅될 문자열을 보여주는 함수이다.
     * @return 하이라이팅될 문자열
     */
    public String getHighlightKeyword() {
        return common.getHighlightKeyword();
    }

    public String getCollectionKorName(String col) {
        String value = "";
        for (int idx=0; idx < wncol.COLLECTIONS.length; idx++) {
            String coll = wncol.COLLECTION_INFO[idx][COLLECTION_NAME].trim();
            if (coll.equals(col)) {
                return wncol.COLLECTION_INFO[idx][COLLECTION_KOR];
            }
        }

        return value;
    }

    /**
     * ksooss 추가
     * WNCollection의 wncol.COLLECTION_INFO의 설정 값을 Return한다.
     * @param collName 검색하고자 하는 컬렉션의 이름
     * @param target Return 대상
     * @return 설정 값, 실패하면 Null을 반환한다.
     */
    public String getCollectionInfoValue(String collName, int target) {
        int idx = getCollIdx(collName);
        if (idx == -1){
            appendWarnings("[WARNING] [getCollectionInfoValue] ["+collName+"] Collection name is not exist");
            return null;
        }
        return wncol.COLLECTION_INFO[idx][target];
    }

    public List<Map<String, Object>> getDocList(String collection, int colCount) {

        List<Map<String, Object>> docList = new ArrayList<Map<String, Object>>();
        String resultFieldList = getCollectionInfoValue(collection, RESULT_FIELD);

        Map<String, Object> docData = null;
        List<String> atchFnList = null;
        List<String> atchConList = null;

        for(int j = 0; j < colCount; j++) {
            docData = new HashMap<String, Object>();
            atchFnList = new ArrayList<String>();
            atchConList = new ArrayList<String>();

            for(String docField : resultFieldList.split(",")) {
                if(docField.contains("/")) {
                    docField = docField.substring(0, docField.indexOf("/"));
                }
                if(docField.contains("ATCHFN")) {
                    atchFnList.add(getField(collection, docField, j, true));
                    if(docField.equals("ATCHFN20"))
                        docData.put("atchFnList", atchFnList);
                } else if(docField.contains("ATCHCON")) {
                    atchConList.add(getField(collection, docField, j, true));
                    if(docField.equals("ATCHCON20"))
                        docData.put("atchConList", atchConList);
                } else {
                    docData.put(StringUtils.upperCase(docField), getField(collection, docField, j, true));
                }
            }
            docList.add(docData);
        }

        return docList;

    }
}
