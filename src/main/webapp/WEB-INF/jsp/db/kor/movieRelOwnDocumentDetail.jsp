<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">


<div id="contents">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area pb1">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="tabIndex" name="tabIndex" value="<c:out value="${paramMap.tabIndex }"/>">
        <input type="hidden" id="movielistNo" name="movielistNo" value=""/>
        <input type="hidden" id="ownCategory" name="ownCategory" value="<c:url value='${paramMap.ownCategory}'/>"/>
        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <section id="fieldset">

        <%@ include file="/WEB-INF/jsp/db/kor/movieProfile.jsp"%>

        <div class="mTitle4">
			<strong class="tit">문헌자료 <span>(<c:out value="${ownListCount.btotal }"/>)</span></strong>
		</div>

		<c:if test="${not empty scenarioList.resultList}">
			<!-- 시나리오/콘티 -->
			<div id="anchorLiteratureScenario" class="result-block pt1">
				<div class="result-block-tt type2 mb2">
					<h4>시나리오/콘티 (<span class="em weighty"><c:out value="${scenarioList.totalCount }"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${scenarioList.resultList  }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.sTitle }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<c:if test="${not empty item.scenarioNo}">
							<span class="gRt">관리번호: <c:out value="${item.scenarioNo}"/></span>
						</c:if>
					</div>
					<div class="mList13">
						<ul>
						<c:if test="${not empty item.formClssNm}">
						<li class="col2">
							<span class="tit">형태</span>
							<span class="txt"><c:out value="${item.formClssNm}"/></span>
						</li>
						</c:if>
						<c:if test="${not empty item.contensClss}">
							<li class="col2">
								<span class="tit">내용구분</span>
								<span class="txt"><c:out value="${item.contensClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.sScenario}">
							<li class="col2">
								<span class="tit">각본</span>
								<span class="txt"><c:out value="${item.sScenario}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.sAuthor}">
							<li class="col2">
								<span class="tit">원작자</span>
								<span class="txt"><c:out value="${item.sAuthor}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.sFilmzation}">
							<li class="col2">
								<span class="tit">각색</span>
								<span class="txt"><c:out value="${item.sFilmzation}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.director}">
							<li class="col2">
								<span class="tit">감독</span>
								<span class="txt"><c:out value="${item.director}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.posClssNm}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt"><c:out value="${item.posClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.orgTitle}">
							<li class="col2">
								<span class="tit">원작</span>
								<span class="txt"><c:out value="${item.orgTitle}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.cAuthor}">
							<li class="col2">
								<span class="tit">콘티작가</span>
								<span class="txt"><c:out value="${item.cAuthor}"/></span>
							</li>
						</c:if>
						<%-- <c:if test="${not empty item.scenarioNo}">
							<li class="col2">
								<span class="tit">연계작품</span>
								<span class="txt"><c:out value="${item.formClssNm}"/>살인의 추억(봉준호, 2004)</span>
							</li>
						</c:if> --%>
						<c:if test="${not empty item.produce}">
							<li class="col2">
								<span class="tit">제작사</span>
								<span class="txt"><c:out value="${item.produce}"/>(주)싸이더스</span>
							</li>
						</c:if>
						<c:if test="${not empty item.sYear}">
							<li class="col2">
								<span class="tit">발행년도</span>
								<span class="txt"><c:out value="${item.sYear}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.hSize and not empty item.vSize }">
							<li class="col2">
								<span class="tit">실물크기</span>
								<span class="txt"><c:out value="${item.vSize}"/>X<c:out value="${item.hSize}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.langClss}">
							<li class="col2">
								<span class="tit">언어</span>
								<span class="txt"><c:out value="${item.langClss}"/>49</span>
							</li>
						</c:if>
						<c:if test="${not empty item.sPage}">
							<li class="col2">
								<span class="tit">페이지</span>
								<span class="txt"><c:out value="${item.sPage}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.mngno}">
							<li class="col2">
								<span class="tit">배가번호</span>
								<span class="txt"><c:out value="${item.mngno}"/></span>
							</li>
						</c:if>
						<c:if test="${item.formClss eq '1' or item.formClss eq '2'}">
							<li class="col2">
								<span class="tit">원본/사본정보</span>
								<span class="txt">
									<c:out value="${item.mngno}"/>의
									<c:if test="${item.formClss eq '1'}">
										원본
									</c:if>
									<c:if test="${item.formClss eq '2'}">
										사본
									</c:if>
								</span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
			<!-- //시나리오/콘티 -->
		</c:if>

		<c:if test="${not empty handbillList.resultList}">
			<!-- 전단 -->
			<div id="anchorLiteratureDiagnosis" class="result-block">
				<div class="result-block-tt type2 mb1">
					<h4>전단 (<span class="em weighty"><c:out value="${handbillList.totalCount}"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${handbillList.resultList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.handblNm }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<c:if test="${not empty item.handbillNo}">
							<span class="gRt">관리번호: <c:out value="${item.handbillNo}"/></span>
						</c:if>
					</div>
					<div class="mList13">
						<ul>
						<c:if test="${not empty item.kindClssNm}">
							<li class="col2">
								<span class="tit">형태</span>
								<span class="txt"><c:out value="${item.kindClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.divClssNm}">
							<li class="col2">
								<span class="tit">구분</span>
								<span class="txt"><c:out value="${item.divClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pubPlace}">
							<li class="col2">
								<span class="tit">배급</span>
								<span class="txt"><c:out value="${item.pubPlace}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationalClssNm}">
							<li class="col2">
								<span class="tit">국가구분</span>
								<span class="txt"><c:out value="${item.nationalClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationClssNm}">
							<li class="col2">
								<span class="tit">발행국</span>
								<span class="txt"><c:out value="${item.nationClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.langClss}">
							<li class="col2">
								<span class="tit">언어</span>
								<span class="txt"><c:out value="${item.langClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.hPage}">
							<li class="col2">
								<span class="tit">페이지</span>
								<span class="txt"><c:out value="${item.hPage}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.posClssNm or item.kindClssNm eq '파일'}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt">
									<c:out value="${item.posClssNm}"/>
									<c:if test="${item.kindClssNm eq '파일'}">영상도서관</c:if>
								</span>
							</li>
						</c:if>
						<c:if test="${not empty item.vSize}">
							<li class="clear">
								<span class="tit">크기</span>
								<span class="txt"><c:out value="${item.vSize}"/> x <c:out value="${item.hSize}"/>cm</span>
							</li>
						</c:if>
						<c:if test="${not empty item.tnImageNm}">
							<li class="thumb">
								<span class="tit">썸네일</span>
								<span class="txt">
									<img src="<c:out value="${item.imgPath }"/>" width="84" alt="">
								</span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
			<!-- //전단 -->
		</c:if>

		<c:if test="${not empty bookList.resultList}">
			<!-- 도서 -->
			<div id="anchorLiteratureBook" class="result-block">
				<div class="result-block-tt type2 mb1">
					<h4>도서 (<span class="em weighty"><c:out value="${bookList.totalCount}"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${bookList.resultList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.bookNm }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<c:if test="${not empty item.bookNo}">
							<span class="gRt">관리번호: <c:out value="${item.bookNo}"/></span>
						</c:if>
					</div>
					<div class="mList13">
					<ul>
						<c:if test="${not empty item.typeClssNm}">
							<li class="col2">
								<span class="tit">형태</span>
								<span class="txt"><c:out value="${item.typeClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.contensClssNm}">
							<li class="col2">
								<span class="tit">구분</span>
								<span class="txt"><c:out value="${item.contensClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationalClssNm}">
							<li class="col2">
								<span class="tit">국가구분</span>
								<span class="txt"><c:out value="${item.nationalClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationClssNm}">
							<li class="col2">
								<span class="tit">발행국</span>
								<span class="txt"><c:out value="${item.nationClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.oriBnm}">
							<li class="col2">
								<span class="tit">원서명</span>
								<span class="txt"><c:out value="${item.oriBnm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.cTtlNm}">
							<li class="col2">
								<span class="tit">총서명</span>
								<span class="txt"><c:out value="${item.cTtlNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.writer}">
							<li class="col2">
								<span class="tit">저자</span>
								<span class="txt"><c:out value="${item.writer}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.translator}">
							<li class="col2">
								<span class="tit">역자</span>
								<span class="txt"><c:out value="${item.translator}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.editor}">
							<li class="col2">
								<span class="tit">편저자</span>
								<span class="txt"><c:out value="${item.editor}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.director}">
							<li class="col2">
								<span class="tit">총괄책임자</span>
								<span class="txt"><c:out value="${item.director}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pubPlace}">
							<li class="col2">
								<span class="tit">발행처</span>
								<span class="txt"><c:out value="${item.pubPlace}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pubYear}">
							<li class="col2">
								<span class="tit">발행년도</span>
								<span class="txt"><c:out value="${item.pubYear}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.langClss}">
							<li class="col2">
								<span class="tit">언어</span>
								<span class="txt"><c:out value="${item.langClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.bCopy}">
							<li class="col2">
								<span class="tit">판차</span>
								<span class="txt"><c:out value="${item.bCopy}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.vSize}">
							<li class="col2">
								<span class="tit">크기</span>
								<span class="txt"><c:out value="${item.vSize}"/> X <c:out value="${item.hSize}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.bPage}">
							<li class="col2">
								<span class="tit">페이지</span>
								<span class="txt"><c:out value="${item.bPage}"/>쪽</span>
							</li>
						</c:if>
						<c:if test="${not empty item.supplement}">
							<li class="col2">
								<span class="tit">부록</span>
								<span class="txt"><c:out value="${item.supplement}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.themeDiv}">
							<li class="col2">
								<span class="tit">주제구분</span>
								<span class="txt"><c:out value="${item.themeDiv}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.posClss}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt"><c:out value="${item.posClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.mngno}">
							<li class="col2">
								<span class="tit">배가번호</span>
								<span class="txt"><c:out value="${item.mngno}"/></span>
							</li>
						</c:if>
				<%-- 		<c:if test="${not empty item.vSize}">
							<li class="col2">
								<span class="tit">연관작품</span>
								<span class="txt"><c:out value="${item.typeClssNm}"/>292쪽</span>
							</li>
						</c:if>
						<c:if test="${not empty item.vSize}">
							<li class="col2">
								<span class="tit">연관인명</span>
								<span class="txt"><c:out value="${item.typeClssNm}"/>292쪽</span>
							</li>
						</c:if> --%>
						<c:if test="${not empty item.keywords}">
							<li class="col2">
								<span class="tit">키워드</span>
								<span class="txt"><c:out value="${item.keywords}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.note}">
							<li class="col2">
								<span class="tit">내용</span>
								<span class="txt"><c:out value="${item.note}"/></span>
							</li>
						</c:if>
					</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
		<!-- //도서 -->
		</c:if>

		<c:if test="${not empty theoryList.resultList}">
			<!-- 논문 -->
			<div id="anchorLiteratureThesis" class="result-block">
				<div class="result-block-tt type2 mb1">
					<h4>논문 (<span class="em weighty"><c:out value="${theoryList.totalCount}"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${theoryList.resultList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.theoryNm }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<span class="gRt">관리번호: <c:out value="${item.theoryNo}"/></span>
					</div>
					<div class="mList13">
						<ul>
						<c:if test="${not empty item.typeClss}">
							<li class="col2">
								<span class="tit">형태</span>
								<span class="txt"><c:out value="${item.typeClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.contensClssNm}">
							<li class="col2">
								<span class="tit">구분</span>
								<span class="txt"><c:out value="${item.contensClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.degreeClss}">
							<li class="col2">
								<span class="tit">학위구분</span>
								<span class="txt"><c:out value="${item.degreeClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationalClss}">
							<li class="col2">
								<span class="tit">국가구분</span>
								<span class="txt"><c:out value="${item.nationalClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationClss}">
							<li class="col2">
								<span class="tit">발행국</span>
								<span class="txt"><c:out value="${item.nationClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.thPage}">
							<li class="col2">
								<span class="tit">페이지</span>
								<span class="txt"><c:out value="${item.thPage}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pubYear}">
							<li class="col2">
								<span class="tit">발행년도</span>
								<span class="txt"><c:out value="${item.pubYear}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pubPlace}">
							<li class="col2">
								<span class="tit">발행처</span>
								<span class="txt"><c:out value="${item.pubPlace}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.thMajor}">
							<li class="col2">
								<span class="tit">학과/전공명</span>
								<span class="txt"><c:out value="${item.thMajor}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.writer}">
							<li class="col2">
								<span class="tit">저자</span>
								<span class="txt"><c:out value="${item.writer}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.thTutor}">
							<li class="col2">
								<span class="tit">지도교수</span>
								<span class="txt"><c:out value="${item.thTutor}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.themeDiv}">
							<li class="col2">
								<span class="tit">주제구분</span>
								<span class="txt"><c:out value="${item.themeDiv}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.langClss}">
							<li class="col2">
								<span class="tit">언어</span>
								<span class="txt"><c:out value="${item.langClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.posClssNm}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt"><c:out value="${item.posClssNm}"/></span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
			<!-- //논문 -->
		</c:if>

		<c:if test="${not empty censorshipList.resultList}">
		<!-- 심의자료 -->
			<div id="anchorLiteratureDeliberation" class="result-block">
				<div class="result-block-tt type2 mb1">
					<h4>심의자료 (<span class="em weighty"><c:out value="${censorshipList.totalCount}"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${censorshipList.resultList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.title }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<span class="gRt">관리번호: <c:out value="${item.censorNo}"/></span>
					</div>
					<div class="mList13">
						<ul>
						<c:if test="${not empty item.kindClssNm}">
							<li class="col2">
								<span class="tit">형태</span>
								<span class="txt"><c:out value="${item.kindClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.writeDate}">
							<li class="col2">
								<span class="tit">작성일</span>
								<fmt:parseDate value="${item.writeDate}" var="writeDate" pattern="yyyyMMdd"/>
								<span class="txt"><fmt:formatDate value="${writeDate}" pattern="yyyy-MM-dd"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.writer}">
							<li class="col2">
								<span class="tit">작성자</span>
								<span class="txt"><c:out value="${item.writer}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.ePage}">
							<li class="col2">
								<span class="tit">페이지</span>
								<span class="txt"><c:out value="${item.ePage}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.area}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt"><c:out value="${item.area}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.plot}">
							<li class="col2">
								<span class="tit">첨부</span>
								<span class="txt"><c:out value="${item.plot}"/></span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
			<!-- //심의자료 -->
		</c:if>

		<c:if test="${not empty newsList.resultList}">
			<!-- 보도자료 -->
			<div id="anchorLiteratureReport" class="result-block">
				<div class="result-block-tt type2 mb1">
					<h4>보도자료 (<span class="em weighty"><c:out value="${newsList.totalCount}"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${newsList.resultList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.newsNm }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<span class="gRt">관리번호: <c:out value="${item.newsNo}"/></span>
					</div>

					<div class="mList13">
						<ul>
						<c:if test="${not empty item.kindClssNm}">
							<li class="col2">
								<span class="tit">형태</span>
								<span class="txt"><c:out value="${item.kindClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationalClssNm}">
							<li class="col2">
								<span class="tit">국가구분</span>
								<span class="txt"><c:out value="${item.nationalClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationClssNm}">
							<li class="col2">
								<span class="tit">발행국</span>
								<span class="txt"><c:out value="${item.nationClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pubPlace}">
							<li class="col2">
								<span class="tit">배급</span>
								<span class="txt"><c:out value="${item.pubPlace}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nPage}">
							<li class="clear">
								<span class="tit">페이지</span>
								<span class="txt"><c:out value="${item.nPage}"/></span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
			<!-- //보도자료 -->
		</c:if>

		<c:if test="${not empty etcList.resultList}">
			<!-- 기타자료 -->
			<div id="anchorLiteratureEtc" class="result-block">
				<div class="result-block-tt type2 mb1">
					<h4>기타자료 (<span class="em weighty"><c:out value="${etcList.totalCount}"/></span>)</h4>
				</div>
				<!-- list -->
				<c:forEach var="item" items="${etcList.resultList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.title }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<span class="gRt">관리번호: <c:out value="${item.etcNo}"/></span>
					</div>
					<div class="mList13">
						<ul>
						<c:if test="${not empty item.kindClssNm}">
							<li class="col2">
								<span class="tit">형태</span>
								<span class="txt"><c:out value="${item.kindClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.divClssNm}">
							<li class="col2">
								<span class="tit">구분</span>
								<span class="txt"><c:out value="${item.divClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationClssNm}">
							<li class="clear">
								<span class="tit">발행국</span>
								<span class="txt"><c:out value="${item.nationClssNm}"/></span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<!--//list -->
			</div>
			<!-- //기타자료 -->
		</c:if>

        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {

	});


</script>