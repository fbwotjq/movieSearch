package egovframework.ag.homepage.wisenut.common;

public class WNDefine {
	public final static int CONNECTION_TIMEOUT = 20000;
	public final static String CHARSET = "UTF-8";
	public final static int REALTIME_COUNT=100;
	public final static int PAGE_SCALE = 10; //view page list count

	public final static int CONNECTION_KEEP = 0; //recevive mode
	public final static int CONNECTION_REUSE = 2;
	public final static int CONNECTION_CLOSE = 3;

	public final static int ASC = 0; //order
	public final static int DESC = 1; //order

	public final static int USE_KMA_OFFOFF = 0; //synonym, morpheme
	public final static int USE_KMA_ONON = 1;
	public final static int USE_KMA_ONOFF = 2;


	public final static int IS_CASE_ON = 1; //case on, off
	public final static int IS_CASE_OFF = 0;

	public final static int HI_SUM_OFFOFF = 0; //summarizing, highlighting
	public final static int HI_SUM_OFFON = 1;
	public final static int HI_SUM_ONOFF = 2;
	public final static int HI_SUM_ONON = 3;

	public final static int INDEX_NAME = 0;
	public final static int COLLECTION_NAME = 1;
	public final static int PAGE_INFO = 2;
	public final static int ANALYZER = 3;
	public final static int SORT_FIELD = 4;
	public final static int SEARCH_FIELD = 5;
	public final static int RESULT_FIELD = 6;
	public final static int DATE_RANGE = 7;
	public final static int EXQUERY_FIELD = 8;
	public final static int COLLECTION_QUERY =9;
	public final static int FILTER_OPERATION = 10;
	public final static int GROUP_BY = 11;
	public final static int GROUP_SORT_FIELD = 12;
	public final static int CATEGORY_BOOST = 13;
	public final static int PROPERTY_GROUP = 14;
	public final static int SEARCH_MAPPING = 15;
	public final static int PREFIX_FIELD = 16;
	public final static int FAST_ACCESS = 17;
	public final static int MULTI_GROUP_BY = 18;
	public final static int COLLECTION_KOR = 19;
}
