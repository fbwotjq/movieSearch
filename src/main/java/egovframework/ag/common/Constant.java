package egovframework.ag.common;

public class Constant {
	public static final String PAGE_TITLE = "_title";
	public static final String ACTIVE_TYPE_LIVE = "LIVE";
	public static final String NICE_CHECK_REQ_HEADER = "_NICE_REQEST";
	public static final String PASS_CHANGE_USER_ID_REQ_HEADER = "_PASS_CHANGE_USER_ID";
	public static final String FIND_TYPE_PERSON = "PERSON";//개인인증 방식
	public static final String FIND_TYPE_EMAIL = "EMAIL";//이메일 방식

	public static final String JOIN_MEMBER_HEADER = "_JOIN_MEMBER_HEADER";
	public static final String JOIN_TYPE_OVER14 = "over14";//회원가입 - 14세 이상
	public static final String JOIN_TYPE_UNDER14 = "under14";//회원가입 - 14세 미만
	public static final String JOIN_TYPE_FOREIGN = "foreign";//회원가입 - 외국인

	public static final String GLOBAL_ERROR_MESSAGE = "GLOBAL_ERROR_MESSAGE";

	public static final String LIST_PATH = "_list_path";
	public static final String VIEW_PATH = "_view_path";
	public static final String CONTEXT_PATH = "_context_path";
	public static final String PAGE_INIT = "_pageInit";
	public static final String FULL_PATH = "_full_path";
	public static final String PAGE = "_page";
	public static final String PAGE_SIZE = "_pageSize";
	public static final String PAGE_BLOCK = "_pageBlock";
	public static final String PAGE_TOTAL = "_pageTotal";
	public static final String SORT_KEY = "_sortKey";
	public static final String SORT_WORD = "_sortWord";
	public static final String RESULT_MSG = "_resultMsg";
	public static final String SEARCH_TYPE = "searchType";
	public static final String SEARCH_TEXT = "searchText";
	public static final String PAGE_PARAM = "_page_param";

	//로컬은 개발을 바라본다.
	//public static final String UPLOAD_WEB_PATH = "http://kmdbadm.innodis.co.kr/upload/kmdbupload/";
	//개발, 운영 배포시 아래 경로 사용.
	public static final String UPLOAD_WEB_PATH = "/upload/kmdbupload/";
	public static final String MOVIE_LIST_M_IMG_PATH = "movieList/data/";//영화리스트의 분류2 모바일 이미지 경로 /ctsa6092/movieList/data/ -> /home/kmdbupload/movieList/data/
	public static final String THEME_KEYWORD_IMG_PATH = "keywordExpert/";//테마키워드 관리 이미지 경로 /_Upload/keywordExpert/ -> /home/kmdbupload/keywordExpert
	public static final String VOD_PLAN_IMG_PATH = "event/";//기획전 관리 이미지 경로 /upload/event/ -> /home/kmdbupload/event
	public static final String FAQ_ATTCH_PATH = "faq/";//테마키워드 관리 이미지 경로 /data/faq/ -> /home/kmdbupload/faq
	public static final String MAIN_CONTENT_IMG_PATH = "mainContent/";//홈페이지 메인 이미지 경로 신규 -> /home/kmdbupload/mainContent
	public static final String MOVIE_STORY_IMG_PATH = "story/";//영화글 이미지 경로 신규 -> /home/kmdbupload/story
	public static final String ONLINE_ARCHIVES_PATH = "archives/";//사료관 파일 경로 신규 -> /home/kmdbupload/archives

	public static final String KF_FILM_UPLOAD_PATH = "http://www.koreafilm.or.kr/upload/";
	public static final String KF_FILM_IMAGE_PATH = "http://file.koreafilm.or.kr";

	public static final String ARCHIVE_SPEECH_CODE = "10";//사료관 구술채록문 코드
	public static final String ARCHIVE_BOOK_CODE = "20";//사료관발간도서 코드
	public static final String ARCHIVE_MAGAZ_CODE = "30";//사료관 영화잡지 코드
	public static final String ARCHIVE_YEAR_CODE = "40";//사료관 연감/총서 코드
	public static final String ARCHIVE_PUBLIC_CODE = "50";//사료관 공문서 코드
	public static final String ARCHIVE_CONTENT_CODE = "60";//사료관 사료콘텐츠 코드

	public static final String NO_IMG_PATH = "/resources/images/common/noimage.gif";

	/* 인명DB - 인물 상세 */
	public static final String PERSON_IMG_PATH1 = "http://file.koreafilm.or.kr/thm/06/";
	public static final String PERSON_IMG_PATH2 = "http://file.koreafilm.or.kr/thm/01/copy/";
	public static final String PERSON_MUL_IMG_PATH = "http://file.koreafilm.or.kr/multi/";

	public static final String MOVIE_POSTER_PATH = "http://file.koreafilm.or.kr/thm/02/";
	public static final String MOVIE_STILL_PATH1 = "http://file.koreafilm.or.kr/thm/01/copy/";
	public static final String MOVIE_STILL_PATH2 = "http://file.koreafilm.or.kr/thm/03/";

	public static final String VIDEO_POSTER_PATH   = "http://file.koreafilm.or.kr/video/";

	public static final String HANDBILL_IMG_PATH = "http://file.koreafilm.or.kr/thm/07/";
	public static final String RECORD_IMG_PATH   = "http://file.koreafilm.or.kr/record/";
	public static final String EQUIP_IMG_PATH   = "https://ams.koreafilm.or.kr/kmdb_data/archive/svc_in/equip/";

/*
	// 기존 '이미지경로지정
	public static final String gPosterPath1  = "http://file.koreafilm.or.kr/webposter/";
	public static final String gPosterPath2  = "/vodserver/kfa_data$/CS/webposter/";
	public static final String gPosterPath3  = "http://file.koreafilm.or.kr/poster/";
	public static final String gPosterPath3_1  = "http://file.koreafilm.or.kr/thm/02/";
	public static final String gPosterPath3_2  = "http://file.koreafilm.or.kr/multi/";
	public static final String gPosterPath4  = "/poster/";
	public static final String gStillPath1   = "http://file.koreafilm.or.kr/webstill/";
	public static final String gStillPath2   = "/vodserver/kfa_data$/CS/webstill/";
	public static final String gStillPath3   = "http://file.koreafilm.or.kr/still/";
	public static final String gStillPath3_1   = "http://file.koreafilm.or.kr/thm/01/copy/";
	public static final String gStillPath4   = "/still/";
	public static final String gStillPath5   = "http://file.koreafilm.or.kr/slide/";
	public static final String gStillPath5_1   = "http://file.koreafilm.or.kr/thm/03/";
	public static final String gStillPath6   = "/slide/";
	public static final String gRecordPath   = "http://file.koreafilm.or.kr/record/";
	public static final String gCatalPath   = "http://file.koreafilm.or.kr/catalog/";
	public static final String gCatalPath_tn   = "http://file.koreafilm.or.kr/tn_catalog/";
	public static final String gHandbillPath3 = "http://file.koreafilm.or.kr/thm/07/";
	public static final String gHandbillPath3_1 = "http://file.koreafilm.or.kr/handbill/";

	//'시네마테크, CHOICE 정보;
	public static final String gWebCinematechPath = "/data/cinematech/";
	public static final String gWebChoicePath = "/data/choice/";

	//'인명정보;
	public static final String gPersonPath1  = "http://file.koreafilm.or.kr/person/";
	public static final String gPersonPath1_1  = "http://file.koreafilm.or.kr/thm/06/";
	public static final String gPersonPath2  = "/person/";

	//SHOP ITEM DOWN PATH
	public static final String gARTICLEPath  = "/ARTICLE/";
	public static final String gSCENARIOPath = "/SCENARIO/";
	public static final String gCRITICISMPath = "/CRITICISM/";
	public static final String gTHEORYPath   = "/THEORY/";

	// 동영상이미지
	public static final String gMultiPath = "http://file.koreafilm.or.kr/multi/";
	*/

}
