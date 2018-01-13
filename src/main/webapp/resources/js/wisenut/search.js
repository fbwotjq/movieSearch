/** 공통적으로 사용하는 펑션을 모움 */

/**
 * 통합검색 탭 클릭시 이동
 * @param tabStr
 */
function fnClickTab(tabName) {
    $("#tabName").val(tabName);
    var form = document.searchForm;
    form.target = "_self";
    if ("movieTab" == tabName) {
        form.action = "/search/movieSearch";    // 영화정보 페이지로 이동
    } else {
        form.action = "/search/sojangSearch";   // 소장정보 페이지로 이동
    }
    form.submit();
}

/**
 * 상세검색에서 검색버튼 누를 경우
 */
function detailDoSearch(tabName) {
    var form = document.searchForm;
    form.target = "_self";

    if ("movieTab" == tabName) {
        form.action = "/search/movieSearch";    // 영화정보 페이지로 이동
    } else {
        form.action = "/search/sojangSearch";   // 소장정보 페이지로 이동
    }
    form.submit();
}

function doCollectionSearch(collName, tabName) {
    $("#startCount").val(0);
    $("#tabName").val(tabName);
    $("#collection").val(collName);

    var form = document.searchForm;
    form.target = "_self";

    if ("movieTab" == tabName) {
        form.action = "/search/movieSearch";    // 영화정보 페이지로 이동
    } else {
        form.action = "/search/sojangSearch";   // 소장정보 페이지로 이동
    }
    form.submit();


}