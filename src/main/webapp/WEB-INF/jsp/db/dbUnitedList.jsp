<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/db.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">


<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<div class="submenu-depth3">
						<h3 class="submenu-depth3-title">통합리스트</h3>
					</div>
				</div>
				<form id="form1" name="form1" method="post">
					<sec:csrfInput/>
			        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
				    <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
			        <section id="fieldset" >

			                <!-- search -->
			                <div class="mSort3">
			                    <div class="gLeft">
			                        <input type="text" id="searchText" name="searchText" placeholder="검색어 입력" value="<c:out value="${paramMap.searchText }"/>">
			                        <button class="ico-search"></button>
			                    </div>
			                    <div class="gLeft">
			                        <div class="asset">
			                            <label><input type="radio" name="searchType" id="searchType" value="TITLE" <c:if test="${empty paramMap.searchType || paramMap.searchType eq 'TITLE' }">checked="checked"</c:if>> <span class="label">제목</span></label>
			                        </div>
			                        <div class="asset">
			                            <label><input type="radio" name="searchType" id="searchType" value="YEAR" <c:if test="${paramMap.searchType eq 'YEAR' }">checked="checked"</c:if>> <span class="label">제작년도</span></label>
			                        </div>
			                    </div>
			                    <div class="gRight"><p class="txt1">
									총<em><c:out value="${pageListVo.totalCount}"/></em>건(전체 영화 편수), 페이지 <em>${paramMap._page}/${totalpage}</em>
								</div>
			                </div>
			   				<!-- graph -->
							<div class="mGraph1">
								<p class="txt1">${pageListVo.totalCount}편중 <em><c:out value="${userDbViewCount}"/></em>편 관람</p>
								<fmt:parseNumber var="var1" value="${pageListVo.totalCount}" integerOnly="true" />
								<fmt:parseNumber var="var2" value="${userDbViewCount}" integerOnly="true" />
								<fmt:parseNumber var="var3" value="${var2/var1*100}" integerOnly="true"  />
								<div class="graph">
									<span class="cur" style="width:${var3}%;"><em></em></span>
								</div>
								<div class="percent">${var3}%</div>
							</div>
							<!-- //graph -->
			                <!-- list -->
							<table border="1" class="data-table medium transform-m">
								<caption>통합리스트 테이블</caption>
								<colgroup>
									<col style="*">
									<col style="width:19%">
									<col style="width:8.5%">
									<col style="width:19%">
									<col style="width:8.5%">
								</colgroup>
								<thead>
								<tr>
									<th scope="col">제목</th>
									<th scope="col">감독</th>
									<th scope="col">제작년도</th>
									<th scope="col">포함된 리스트 내역</th>
									<th scope="col">내가 본<br> 영화</th>
								</tr>
								</thead>
								<tbody>
								<c:if test="${pageListVo.totalCount <= 0 }">
					                <div class="noresult">
										<p>검색 내용이 없습니다.</p>
									</div>
							    </c:if>
							    <c:if test="${pageListVo.totalCount > 0 }">
									<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
										<tr>
											<td class="title align-left"><a href="javascript:void(0);">${item.title}</a></td>
												<td>${item.director}</td>
												<td>${item.prodYear}</td>
												<td class="row2">
													<span class="ro1">${item.div1MovielistName}</span>
													<span class="ro2">등 ${item.groupcnt}개 리스트</span>
												</td>
											<td class="check">
												<label><input type="checkbox" name="checkbox1" id="checkbox1" onclick="fncRegDel('${item.movielistId}','${item.movieId}','${item.movieSeq}','${item.userview}');" <c:if test="${item.userview eq 'Y'}">checked="checked"</c:if> /></label>
											</td>
										</tr>
									</c:forEach>
								</c:if>

								</tbody>
							</table>
							<div class="paging-area">
								<!-- pagination -->
								<div class="pagination medium">
									${paging}
								</div>
								<!-- //pagination -->
							</div>
						<!-- //list -->

						</section>
					</form>
				</div>
			</div>


<script type="text/javascript">
$(document).ready(function(){

});

function fncGoPage(nPage){
    $("#_page").val(nPage);

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncReload(){
	window.location.reload(true);
}

function fcnDetail(idx,mNo){
	$("#movielistNo").val(mNo);
	formSubmit("form1", "<c:url value="/db/list/"/>"+ idx);
}

//내가 본 영화
function fncRegDel(movielistId,movieId,movieSeq,userview) {
	var frm = document.form1;

	var response = $.fnAjax({
		params:{movielistId: movielistId,
				movieId: movieId,
				movieSeq: movieSeq,
				userview: userview
				}
		, url:"<c:url value='/db/list/detail/"+movielistId+"/proc'/>"
		, async:false
		, showMessage:false});
	    if (response.result == "true") {
	    	if(response.resultCnt == 1){
	    		alert("내가 본 영화에 등록되었습니다.");
	    	}else{
	    		alert("내가 본 영화에서 삭제되었습니다.");
	    	}
			return;
	    }else {
	    	alert("영화 등록중 에러가 발생하였습니다. 로그인 상태를 확인해주세요");
	    	return;
	    }
	    return false;
}



</script>