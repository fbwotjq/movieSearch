    package egovframework.ag.homepage.wisenut.common;

/**
 *  subject: 검색엔진 설정 페이지
 */

public class WNCollection {

    /** 운영계 */
//    static String SEARCH_IP = "127.0.0.1";
//    static int SEARCH_PORT = 7000;

    /** 개발계 */
    static String SEARCH_IP = "14.63.223.245";
    static int SEARCH_PORT = 7000;

    static String MANAGER_IP = "127.0.0.1";
    static int MANAGER_PORT = 7800;

//    public static String[] COLLECTIONS = new String[] {"kmDCFILM", "kmMOVIE", "kmMSTORY", "kmSALYO", "kmVIDEO"};

    public static String[] COLLECTIONS = new String[] {"kmKORMOVIE","kmFORMOVIE","kmMOVIEIN","kmDCFILM","kmVIDEO","kmMOVIE","kmPOSTERFILE","kmPOSTERPRINT","kmSTILLFILE","kmSTILLPRINT"
                                                    ,"kmSALYO","kmMSTORY","kmSCENARIO","kmBOOK","kmOST","kmCENSOR","kmEQUIPMENT","kmFLYER","kmMOVIEJE","kmPLACE","kmEVENT"};

    public String[][] COLLECTION_INFO = null;
    public WNCollection() {
        COLLECTION_INFO = new String[][] {
            {
                "kmKORMOVIE", // set collection name
                "kmKORMOVIE", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "NATIONAL_CLSS,PATTEN_CLSS,CONTENS_DETAIL_CLSS,TITLE,TITLE_SEARCH,DIRECTOR_LINK,DIRECTOR_SEARCH,ACTOR_LINK,ACTOR_SEARCH,STAFF,COMPANY,KEYWORDS,PLOT,PROD_YEAR,RELEASE_DATE,NATION_CLSS,LENGTH_CLSS,TYPE_CLSS,LEVEL_CLSS,FILMCNS_CLSS",// set search field
                "DOCID,DATE,MOVIE_ID,MOVIE_SEQ,PATTEN_CLSS,CONTENS_DETAIL_CLSS,TITLE,TITLE_SEARCH,DIRECTOR_LINK,DIRECTOR_SEARCH,ACTOR_LINK,ACTOR_SEARCH,STAFF,COMPANY,KEYWORDS,PLOT,NATIONAL_CLSS,PROD_YEAR,NATION_CLSS,TYPE_CLSS,RELEASE_DATE,LENGTH_CLSS,LEVEL_CLSS,FILMCNS_CLSS,PLACE,NOTE,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "국내영화" // collection display name
            }, {
                "kmFORMOVIE", // set collection name
                "kmFORMOVIE", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "NATIONAL_CLSS,PATTEN_CLSS,CONTENS_DETAIL_CLSS,TITLE,TITLE_SEARCH,DIRECTOR_LINK,DIRECTOR_SEARCH,ACTOR_LINK,ACTOR_SEARCH,STAFF,COMPANY,KEYWORDS,PLOT,PROD_YEAR,RELEASE_DATE,NATION_CLSS,LENGTH_CLSS,TYPE_CLSS,LEVEL_CLSS,FILMCNS_CLSS",// set search field
                "DOCID,DATE,MOVIE_ID,MOVIE_SEQ,PATTEN_CLSS,CONTENS_DETAIL_CLSS,TITLE,TITLE_SEARCH,DIRECTOR_LINK,DIRECTOR_SEARCH,ACTOR_LINK,ACTOR_SEARCH,STAFF,COMPANY,KEYWORDS,PLOT,NATIONAL_CLSS,PROD_YEAR,NATION_CLSS,TYPE_CLSS,RELEASE_DATE,LENGTH_CLSS,LEVEL_CLSS,FILMCNS_CLSS,PLACE,NOTE,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "국내영화" // collection display name
            }, {
                "kmMOVIEIN", // set collection name
                "kmMOVIEIN", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "NAME_SEARCH,NAME,FILMOGRAPHY_SEARCH,FILMOGRAPHY,BIRTH_DATE",// set search field
                "DOCID,DATE,NAME_SEARCH,NAME,FILMOGRAPHY_SEARCH,FILMOGRAPHY,BIRTH_DATE,DEATH_DATE,PERSON_FILED,PERSON_AWARD,NOTE,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "국내영화" // collection display name
            }, {
                "kmDCFILM", // set collection name
                "kmDCFILM", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "PATTEN_CLSS,TITLE_SEARCH,SUBDIRECTOR,ACTOR,STAFF,COMPANY,KEYWORD,PLOT,NATIONAL_CLSS,PROD_YEAR,TYPE_CLSS,FILMCNS_CLSS,MEDIUM,SPEC,CAP_CLSS",// set search field
                "DOCID,DATE,PATTEN_CLSS,PATTEN_CLSS_SEARCH,TITLE,TITLE_SEARCH,DIRECTOR,SUBDIRECTOR,ACTOR,STAFF,COMPANY,KEYWORD,PLOT,NATIONAL_CLSS,PROD_YEAR,TYPE_CLSS,FILMCNS_CLSS,DB,MEDIUM,SPEC,CAP_CLSS,AMOUNT,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "필름/D시네마" // collection display name
            }, {
                "kmVIDEO", // set collection name
                "kmVIDEO", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "PATTEN_CLSS,TITLES,DIRECTOR,ACTOR,STAFF,INVEST,KEYWORDS,PLOT,EXYEAR,NATIONAL_CLSS,PROD_NATION,TYPE_CLSS,DEV_CLSS,COMPANY,PROD_YEAR,VIEW_STANDARD,COLOR_CLSS,LANG_CLSS,CAP_CLSS,POS_CLSS",// set search field
                "DOCID,DATE,TITLES,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,MOVIE_COUNT,PATTEN_CLSS,DIRECTOR,ACTOR,STAFF,INVEST,KEYWORDS,PLOT,EXYEAR,NATIONAL_CLSS,PROD_NATION,TYPE_CLSS,DEV_CLSS,STANDARD,COMPANY,PROD_YEAR,LEVEL_CLSS,COLOR_CLSS,LANG_CLSS,CAP_CLSS,POS_CLSS,AMOUNT,VIEW_STANDARD,MOVIE_CODE,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "동영상" // collection display name
            }, {
                "kmMOVIE", // set collection name
                "kmMOVIE", // set index name
                "0,4",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "PATTEN_CLSS,DIRECTOR,ACTOR,STAFF,COMPANY,KEYWORDS,PLOT,NATIONAL_CLSS,PROD_YEAR,PROD_NATION,TYPE_CLSS,USE_CLSS,MSCREEN_CLSS",// set search field
                "DOCID,DATE,MUL_TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,PATTEN_CLSS,PATTEN_CLSS_SEARCH,TITLE,DIRECTOR,ACTOR,STAFF,COMPANY,KEYWORDS,PLOT,NATIONAL_CLSS,PROD_YEAR,PROD_NATION,TYPE_CLSS,USE_CLSS,MSCREEN_CLSS,MSCREEN_CLSS_TEXT,LEVEL_CLSS_TEXT,MOVIE_CODE,IMG_DIR,IMAGE_NM,RUNTIME,SECONDS,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "비디오" // collection display name
            }, {
                "kmPOSTERFILE", // set collection name
                "kmPOSTERFILE", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "CONTENS_CLSS,MATERIAL_CLSS,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,PERSON_NM,FESTIVAL_TITLE,ETC_TITLE,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE",// set search field
                "DOCID,DATE,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,MOVIE_CODE,PERSON_NM,PERSON_CODE,FESTIVAL_TITLE,FESTIVAL_CODE,FESTIVAL_AWARD_CODE,ETC_TITLE,OTHER_ID,CONTENS_CLSS,CONTENS_CLSS_TEXT,MATERIAL_CLSS,FORM,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE,CONTENS_DETAIL_CLSS,SIZE,CONTENTS,FILE_DIR,FILE_NM,PROHIBIT_19,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "포스터파일" // collection display name
        }, {
                "kmPOSTERPRINT", // set collection name
                "kmPOSTERPRINT", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "CONTENS_CLSS,MATERIAL_CLSS,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,PERSON_NM,FESTIVAL_TITLE,ETC_TITLE,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE",// set search field
                "DOCID,DATE,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,MOVIE_CODE,PERSON_NM,PERSON_CODE,FESTIVAL_TITLE,FESTIVAL_CODE,FESTIVAL_AWARD_CODE,ETC_TITLE,OTHER_ID,CONTENS_CLSS,CONTENS_CLSS_TEXT,MATERIAL_CLSS,FORM,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE,CONTENS_DETAIL_CLSS,SIZE,CONTENTS,FILE_DIR,FILE_NM,PROHIBIT_19,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "포스터인쇄물" // collection display name
        }, {
                "kmSTILLFILE", // set collection name
                "kmSTILLFILE", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "CONTENS_CLSS,MATERIAL_CLSS,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,PERSON_NM,FESTIVAL_TITLE,ETC_TITLE,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE",// set search field
                "DOCID,DATE,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,MOVIE_CODE,PERSON_NM,PERSON_CODE,FESTIVAL_TITLE,FESTIVAL_CODE,FESTIVAL_AWARD_CODE,ETC_TITLE,OTHER_ID,CONTENS_CLSS,CONTENS_CLSS_TEXT,MATERIAL_CLSS,FORM,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE,CONTENS_DETAIL_CLSS,SIZE,CONTENTS,FILE_DIR,FILE_NM,PROHIBIT_19,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "스틸파일" // collection display name
        }, {
                "kmSTILLPRINT", // set collection name
                "kmSTILLPRINT", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "CONTENS_CLSS,MATERIAL_CLSS,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,PERSON_NM,FESTIVAL_TITLE,ETC_TITLE,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE",// set search field
                "DOCID,DATE,IMAGE_TITLE1,IMAGE_TITLE2,IMAGE_TITLE3,IMAGE_TITLE4,MOVIE_TITLE,MOVIE_CODE,PERSON_NM,PERSON_CODE,FESTIVAL_TITLE,FESTIVAL_CODE,FESTIVAL_AWARD_CODE,ETC_TITLE,OTHER_ID,CONTENS_CLSS,CONTENS_CLSS_TEXT,MATERIAL_CLSS,FORM,REL_PERSON_NM1,REL_PERSON_NM2,NATIONAL_CLSS,PROD_YEAR,HAVEFILE,CONTENS_DETAIL_CLSS,SIZE,CONTENTS,FILE_DIR,FILE_NM,PROHIBIT_19,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "스틸인쇄물" // collection display name
        }, {
                "kmSALYO", // set collection name
                "kmSALYO", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "SUBJECT,SUMMARY_DESC,CHERCHEUR,TARGET_NAME",// set search field
                "DOCID,Date,ARCHIVES_TYPE_CD,CODE01,TXT_CODE_NAME,SUBJECT,TARGET_NAME,CHERCHEUR,FILE_NAME,SUMMARY_DESC,BIRTH_DATE,DEPTH_01,DEPTH_02,DEPTH_03,DEPTH_04,DEPTH_ETC,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "사료관" // collection display name
        }, {
                "kmMSTORY", // set collection name
                "kmMSTORY", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE01,TITLE02,SUBJECT,WRITER",// set search field
                "DOCID,Date,WRITER_SEQ,STORY_SEQ,STORY_DIV_SEQ,TITLE01,TITLE02,SUBJECT,WRITER,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "영화글" // collection display name
            }, {
                "kmSCENARIO", // set collection name
                "kmSCENARIO", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,M_TITLE,DIRECTOR,AUTHOR,CONTENTS_CLSS,PROD_YEAR,POS_CLSS",// set search field
                "DOCID,DATE,TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,M_TITLE,DIRECTOR,AUTHOR,CONTENTS_CLSS,PROD_YEAR,KIND_CLSS,FORM_CLSS,POS_CLSS,COUNT,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "시나리오" // collection display name
            }, {
                "kmBOOK", // set collection name
                "kmBOOK", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE_SEARCH,BOOK_NM,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,WRITER,TRANSLATOR,TOC,ABSTRACT,KEYWORDS,PUB_PLACE,NATIONAL_CLSS,PUB_YEAR,POS_CLSS",// set search field
                "DOCID,Date,DB_CLSS,DEGREE_CLASS,TITLE_SEARCH,BOOK_NM,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,WRITER,TRANSLATOR,PUB_PLACE,NATIONAL_CLSS,PUB_YEAR,PAGE,TOC,ABSTRACT,KEYWORDS,POS_CLSS,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "도서/논문" // collection display name
        }, {
                "kmOST", // set collection name
                "kmOST", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE_SEARCH,TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,MOVIE_TITLE,SONG_TITLE,ARTIST,RECORD_CLSS,PROD_YEAR,POS_CLSS",// set search field
                "DOCID,DATE,TITLE_SEARCH,TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,MOVIE_TITLE,SONG_TITLE,ARTIST,RECORD_CLSS,DEV_CLSS,PROD_COMPY,PROD_YEAR,TOTAL_TIME,TRACK_COUNT,POS_CLSS,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "음반" // collection display name
        }, {
                "kmCENSOR", // set collection name
                "kmCENSOR", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "MOVIE_TITLE,DIRECTOR_SEARCH,DIRECTOR,AUTHORS,PROD_COMPY,CONTENTS,PROD_YEAR,POS_CLSS",// set search field
                "DOCID,DATE,TITLE,MOVIE_TITLE,DIRECTOR_SEARCH,DIRECTOR,AUTHORS,PROD_COMPY,CONTENTS,PROD_YEAR,DOC_COUNT,POS_CLSS,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "심의서류" // collection display name
        }, {
                "kmEQUIPMENT", // set collection name
                "kmEQUIPMENT", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,MOVIE_TITLE,DIR,IMAGE",// set search field
                "DOCID,DATE,TITLE,TITLE_SUB,TITLE_ETC,TITLE_EQUAL,MOVIE_TITLE,DIR,CLASS,IMAGE,SEARCH_ETC,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "박물류" // collection display name
        }, {
                "kmFLYER", // set collection name
                "kmFLYER", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "HDIV1,HDIV2,HDIV3,HTITLE1,HTITLE2,HTITLE3,HTITLE4,TITLE_SEARCH,SEARCH_ETC",// set search field
                "DOCID,DATE,HDIV1,HDIV2,HDIV3,HTITLE1,HTITLE2,HTITLE3,HTITLE4,TITLE_SEARCH,PRID_YEAR,KIND_CLASS,COUNT,SEARCH_ETC,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "전단/보도자료/기타자료" // collection display name

        }, {
                "kmMOVIEJE", // set collection name
                "kmMOVIEJE", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE,TITLE_SEARCH",// set search field
                "DOCID,Date,TITLE,TITLE_SEARCH,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "영화제" // collection display name

        }, {
                "kmPLACE", // set collection name
                "kmPLACE", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE,TITLE_SEARCH,SEARCH_ETC",// set search field
                "DOCID,Date,TITLE,TITLE_SEARCH,SEARCH_ETC,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "장소" // collection display name
         }, {
                "kmEVENT", // set collection name
                "kmEVENT", // set index name
                "0,3",  // set pageinfo (start,count)
                "1,0", // set query analyzer (useKMA,isCase)
                "RANK,1",  // set sort field (field,order) multi sort '/'
                "TITLE,TITLE_SEARCH,SEARCH_ETC",// set search field
                "DOCID,Date,TITLE,TITLE_SEARCH,SEARCH_ETC,alias",// set document field
                "",// set date range
                "", // set exquery (fieldname:value...) and ' ', or '|'/, not '!'
                "", // set collection query (<fieldname:value> <fieldname,fieldname2:value> | <field3:value>...) and ' ', or '|'
                "", // set filter operation (fieldname <operator>value)
                "",// set groupby field(field, count)
                "",// set sort field group(field,order)
                "",// set categoryBoost(fieldname,matchType,boostID,boostKeyword)
                "",// set property group (fieldname,from,to)
                "",// set mapping search field
                "", //use check exquery filed
                "", // set use check fast access field
                "", // set multigroupby field
                "행사/사건" // collection display name
            }
        };
    }
}