<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/archives.css">

<div id="contents">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
            <%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>


        <input type="hidden" id="partCode" name="partCode" value="<c:out value="${paramMap.partCode }"/>"/>
        <input type="hidden" id="code01" name="code01" value="<c:out value="${paramMap.code01 }"/>"/>
        <input type="hidden" id="code02" name="code02" value="<c:out value="${paramMap.code02 }"/>"/>
        <input type="hidden" id="searchGbn" name="searchGbn" value="<c:out value="${paramMap.searchGbn }"/>"/>


        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">
	        <!-- tab -->
	        <div class="mTab1">
				<c:forEach var="item" items="${code01List }">
				<c:if test="${paramMap.code01 ==  item.cCodeSubId }">
				    <c:set var="code01" value="${item.cCodeSubId }"/>
				    <c:set var="code01Name" value="${item.cCodeSubName }"/>
				</c:if>

				<span class="ls <c:if test="${paramMap.code01 ==  item.cCodeSubId }">selected</c:if>"><a href="javascript:fcnMainSearch('<c:out value="${item.cCodeSubId }"/>');"><c:out value="${item.cCodeSubName }"/></a></span>
				</c:forEach>
	        </div>
	        <!-- //tab -->


            <!--  setting var -->
	        <c:set var="hasSubList" value="F"/>
	        <c:set var="code02" value=""/>
	        <c:set var="partCode" value=""/>

            <c:forEach var="item" items="${code01List }">
                <c:if test="${paramMap.code01 == item.cCodeSubId}">
                    <c:forEach var="subItem" items="${item.subList }" varStatus="status">
                        <c:if test="${status.first }">
                            <c:set var="code02" value="${subItem.cCodeSubId }"/>
                        </c:if>
                    </c:forEach>
                </c:if>


                <c:if test="${paramMap.code01 == item.cCodeSubId && fn:length(item.subList) > 0 }">
                    <c:set var="hasSubList" value="T"/>
                </c:if>
            </c:forEach>


            <c:forEach var="item" items="${partCodeList }" varStatus="status">
                <c:if test="${status.first }">
                    <c:set var="partCode" value="${item.cCodeSubId }"/>
                </c:if>
            </c:forEach>
            <!--  //setting var -->

	        <!-- slide tab -->
	        <div class="mMenu1 type2 nonavi">
                <!-- depth1 -->
                <div class="owl-carousel dep1 jsTab1" id="archives-tab-menu3">
                    <a href="#archives-tab-menu4" onclick="fcnSearch('ALL');" <c:if test="${empty paramMap.code02 && empty paramMap.partCode  }">class="selected"</c:if>>전체</a>
                    <a href="#archives-tab-menu4_1" onclick="fcnSearch('SUB_PART');" <c:if test="${not empty paramMap.partCode }">class="selected"</c:if>>분야</a>
                    <c:if test="${hasSubList eq 'T' }">
                        <a href="#archives-tab-menu4_2" onclick="fcnSearch('SUB_CODE');" <c:if test="${not empty paramMap.code02 }">class="selected"</c:if>>분류</a>
                    </c:if>

                </div>
                <!-- //depth1 -->

	            <!-- depth2 for 분야 -->
	            <div class="owl-carousel dep2" <c:if test="${not empty paramMap.partCode }">id="archives-tab-menu4_1"</c:if> <c:if test="${empty paramMap.partCode }">style="display: none;"</c:if>>
                    <c:forEach var="item" items="${partCodeList }">
                        <a href="#none;" onclick="fcnSubSearch('SUB_PART', '<c:out value="${item.cCodeSubId }"/>');" <c:if test="${paramMap.partCode eq item.cCodeSubId}">class="selected"</c:if>><c:out value="${item.cCodeSubName }"/></a>
                    </c:forEach>
	            </div>

	            <c:if test="${hasSubList eq 'T' }">
	            <!-- depth2 for 분류 -->
	            <div class="owl-carousel dep2" <c:if test="${not empty paramMap.code02 }">id="archives-tab-menu4_2"</c:if> <c:if test="${empty paramMap.code02 }">style="display: none;"</c:if>>

                    <c:forEach var="item" items="${code01List }">
                        <c:if test="${paramMap.code01 == item.cCodeSubId }">
                            <c:forEach var="subItem" items="${item.subList }">
                                <a href="#none;" onclick="fcnSubSearch('SUB_CODE', '<c:out value="${subItem.cCodeSubId }"/>');" <c:if test="${paramMap.code02 eq subItem.cCodeSubId}">class="selected"</c:if>><c:out value="${subItem.cCodeSubName }"/></a>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
	            </div>
	            <!-- //depth2 for 분류 -->
	            </c:if>
	        </div>
	        <!-- //slide tab -->


			 <!-- search -->
			 <div class="mSearch">
			     <div class="dbinfo-search">
			         <input type="text" id="searchText" name="searchText" placeholder="리스트내 검색" value="<c:out value="${paramMap.searchText }"/>">
			         <button class="ico-search"></button>
			     </div>
			     <div class="dbinfo-radio selector-wrap horizontal">
			         <div class="asset type2">
			             <label><input type="radio" name="searchType" id="searchType_TARGET" value="TARGET" <c:if test="${paramMap.searchType == 'TARGET' || empty paramMap.searchType }">checked="checked"</c:if>> <span class="label">구술인</span></label>
			         </div>
			         <div class="asset type2">
			             <label><input type="radio" name="searchType" id="searchType_STUDY" value="STUDY" <c:if test="${paramMap.searchType == 'STUDY'}">checked="checked"</c:if>> <span class="label">채록연구자</span></label>
			         </div>
			     </div>
			     <div class="gRt">
			         <a href="javascript:fcnTargetNameView();" class="iDot"><span>구술인 전체보기</span></a>
			         <a href="javascript:fcnTalkIntor();" class="iFeel"><span>구술사업소개</span></a>
			     </div>
			 </div>
			 <!-- //search -->

			 <!-- sort -->
			 <div class="mSort1">
			     <h4><c:out value="${code01Name }"/> (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
			     <div class="rt">
			         <div class="dbinfo-table-sort">
			             <div class="area">
			                 <label for="searchOrderType" class="blind">내림차순</label>
			                 <select name="searchOrderType" id="searchOrderType" class="select-tric">
                                <option value="DESC" <c:if test="${paramMap.searchOrderType == 'DESC' || empty paramMap.searchOrderType }">selected="selected"</c:if>>내림차순</option>
                                <option value="ASC" <c:if test="${paramMap.searchOrderType == 'ASC'}">selected="selected"</c:if>>오름차순</option>
			                 </select>
			             </div>
			             <div class="area">
			                 <label for="_pageSize" class="blind">10개 출력</label>
			                 <select name="_pageSize" id="_pageSize" class="select-tric">
			                     <option value="10" <c:if test="${paramMap._pageSize == '10' || empty paramMap.searchType }">selected="selected"</c:if>>10개 출력</option>
			                     <option value="20" <c:if test="${paramMap._pageSize == '20'}">selected="selected"</c:if>>20개 출력</option>
			                 </select>
			             </div>
			         </div>
			     </div>
			 </div>
			 <!-- //sort -->

			 <!-- list -->
			 <div class="mImage10 type3">
			     <ul>
			     <%--
			     <li class="pt0">
			         <a href="###">
			             <span class="mImg1"><span style="background-image: url('../../resources/images/@temp/archives01-01.jpg')"></span></span>
			             <span class="text">
			                 <span class="tit">생애사</span>
			                 <span class="nam">김호길 (감독),  1941 김호길 (감독),  1941</span>
			                 <span class="lst">
			                     <span class="ls"><em>채록연구자</em> 이정아</span>
			                     <span class="ls"><em>구술면담일</em> 2016-5~6</span>
			                 </span>
			             </span>
			         </a>
			     </li>
			      --%>
			     <c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
			         <c:choose>
			             <c:when test="${status.count <= 4 }">
			                 <li class="pt0">
			             </c:when>
			             <c:otherwise>
			                 <li>
			             </c:otherwise>
			         </c:choose>

	                     <div class="cont">
	                         <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                         <span class="text">
	                             <a href="javascript:fcnDetail('<c:out value="${item.archivesSeq }"/>');">
	                                 <c:choose>
	                                     <c:when test="${not empty item.subject }">
	                                         <span class="tit"><c:out value="${item.subject }"/></span>
	                                     </c:when>
	                                     <c:otherwise>
	                                         <span class="tit"><c:out value="${code01Name }"/></span>
	                                     </c:otherwise>
	                                 </c:choose>
	                                 <span class="nam"><c:out value="${item.targetName }"/> (<c:choose><c:when test="${item.partCode == '9999' }"><c:out value="${item.txtPartCodeName }"/></c:when><c:otherwise><c:out value="${item.partCodeName }"/></c:otherwise></c:choose>) , <c:out value="${item.birthYear }"/></span>
	                             </a>
	                             <span class="lst">
                                     <span class="ls"><em>채록연구자</em> <c:out value="${item.chercheur }"/></span>
                                     <span class="ls"><em>구술면담일</em> <c:out value="${item.talkTerm }"/></span>
	                             </span>
	                         </span>
	                     </div>
			         </li>
			     </c:forEach>
			     <%--
			     <li class="blank"></li> <!-- 좌측 회색선을 위한 코드 -->
			     <li class="blank"></li> <!-- 좌측 회색선을 위한 코드 -->
			      --%>
			     </ul>
			 </div>
			 <!-- //list -->

			 <div class="paging-area">
			     <!-- pagination -->
			     <div class="pagination medium">${paging}</div>
			     <!-- //pagination -->
			 </div>
        </section>
        </form>
    </div>
</div>

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->
<script type="text/javascript" src="/resources/js/history/history.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    $("#form1").validate({
        submitHandler: function(form) {
            $("#_page").val("1");
            formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
        }
    });

    $("#_pageSize, #searchOrderType").bind("change", function() {
    	$("#_page").val("1");
        formSubmit("form1", "/history/talk");
    });
});

function fncGoPage(nPage){
    $("#_page").val(nPage);
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function initSearchValue() {
	$("#_page").val("1");
	$("#_pageSize").val("");
	$(":input[name='searchType']:checked").val("");
	$("#searchType").val("");
	$("#searchText").val("");
	$("#searchOrderType").val("");
}

function fcnMainSearch(pCode01) {
	initSearchValue();

    $("#searchGbn").val("ALL");
    $("#code01").val(pCode01);
    $("#code02").val("");
    $("#partCode").val("");

    formSubmit("form1", "<c:url value="/history/talk"/>");
}

function fcnSearch(pSearchGbn) {
	initSearchValue();

    $("#searchGbn").val(pSearchGbn);
    $("#code01").val("<c:out value="${code01}"/>");

    if (pSearchGbn == "ALL") {
        $("#code02").val("");
        $("#partCode").val("");
    } else if (pSearchGbn == "SUB_PART") {
    	$("#code02").val("");
        $("#partCode").val("<c:out value="${partCode}"/>");
    } else if (pSearchGbn == "SUB_CODE") {
    	$("#code02").val("<c:out value="${code02}"/>");
    	$("#partCode").val("");
    }

    formSubmit("form1", "<c:url value="/history/talk"/>");
}

function fcnSubSearch(pSearchGbn, pSubCode) {
	initSearchValue();

    $("#searchGbn").val(pSearchGbn);

    $("#code01").val("<c:out value="${code01}"/>");


    if (pSearchGbn == "SUB_PART") {
    	$("#code02").val("");
    	$("#partCode").val(pSubCode);
    } else if (pSearchGbn == "SUB_CODE") {
        $("#code02").val(pSubCode);
        $("#partCode").val("");
    }

    formSubmit("form1", "<c:url value="/history/talk"/>");
}


function fcnDetail(pArchivesSeq) {
	formSubmit("form1", "<c:url value="/history/talk/"/>" + pArchivesSeq);
}

function fcnTargetNameView() {
	formSubmit("form1", "<c:url value="/history/talk/target/list"/>");
}

function fcnTalkIntor() {
	formSubmit("form1", "<c:url value="/history/talk/intro"/>");
}
</script>