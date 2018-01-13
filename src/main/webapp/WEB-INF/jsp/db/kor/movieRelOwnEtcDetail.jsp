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
			<strong class="tit">기타 <span>(<c:out value="${ownListCount.etotal }"/>)</span></strong>
		</div>

		<c:if test="${not empty ostList.resultList}">
			<!-- OST -->
			<div id="anchorEtcOst" id="anchorMovieFilm" class="result-block mt0">
				<div class="result-block-tt type2">
					<h4>OST (<span class="em weighty"><c:out value="${ostList.totalCount }"/></span>)</h4>
				</div>
				<c:forEach var="item" items="${ostList.resultList  }" varStatus="status">
				<div class="mList13 image">
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
						<c:if test="${not empty item.recordNo}">
							<span class="gRt">관리번호: <c:out value="${item.recordNo}"/></span>
						</c:if>
					</div>
					<div class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath}"/>')"></span></div>
					<ul>
						<c:if test="${not empty item.recordClss}">
							<li class="col2 mr1">
								<span class="tit">종류</span>
								<span class="txt"><c:out value="${item.recordClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.devClssNm}">
							<li class="col2 mr1">
								<span class="tit">규격</span>
								<span class="txt"><c:out value="${item.devClssNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationClss}">
							<li class="col2 mr1">
								<span class="tit">제작국가</span>
								<span class="txt"><c:out value="${item.nationClss}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.prodCompy}">
							<li class="col2">
								<span class="tit">제작사</span>
								<span class="txt"><c:out value="${item.prodCompy}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.prodYear}">
							<li class="col2">
								<span class="tit">제작년도</span>
								<span class="txt"><c:out value="${item.prodYear}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.lable}">
							<li class="col2">
								<span class="tit">레이블</span>
								<span class="txt"><c:out value="${item.lable}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.outer}">
							<li class="col2">
								<span class="tit">배급사</span>
								<span class="txt"><c:out value="${item.outer}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.prodNo}">
							<li class="col2">
								<span class="tit">제품번호</span>
								<span class="txt"><c:out value="${item.prodNo}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.rectypeClss1Nm}">
							<li class="col2">
								<span class="tit">오디오채널</span>
								<span class="txt"><c:out value="${item.rectypeClss1Nm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.totalTime}">
							<li class="col2">
								<span class="tit">총연주시간</span>
								<span class="txt"><c:out value="${item.totalTime}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.rectypeClss2Nm}">
							<li class="clear">
								<span class="tit">녹음방식</span>
								<span class="txt"><c:out value="${item.rectypeClss2Nm}"/></span>
							</li>
						</c:if>
					</ul>
					<div class="list2 noline">
						<strong class="tit">트랙넘버</strong>
						<div class="lst2">
							<div class="ls col2">
								<div class="l1"><em>01</em> One Fine Spring Day (main theme),   3:05</div>
								<div class="l2">
									<em>아티스트</em>  조성우
									<span class="dots"><em>작사</em> 조성우</span>
									<span class="dots"><em>작곡</em> 조성우</span>
									<span class="dots"><em>편곡</em> 조성우, 이숙연, 김영애</span>
								</div>
							</div>
							<div class="ls col2">
								<div class="l1"><em>02</em> 그해 봄에 (theme from 상우),   3:05</div>
								<div class="l2">
									<em>작곡</em> 조성우
									<span class="dots"><em>편곡</em> 조성우</span>
								</div>
							</div>
							<div class="ls col2">
								<div class="l1"><em>03</em> 그해 봄에 (theme from 상우),   3:05</div>
								<div class="l2">
									<em>작곡</em> 조성우
									<span class="dots"><em>편곡</em> 조성우</span>
								</div>
							</div>
							<div class="ls col2">
								<div class="l1"><em>04</em> 그해 봄에 (theme from 상우),   3:05</div>
								<div class="l2">
									<em>작곡</em> 조성우
									<span class="dots"><em>편곡</em> 조성우</span>
								</div>
							</div>
							<div class="ls col2">
								<div class="l1"><em>05</em> 그해 봄에 (theme from 상우),   3:05</div>
								<div class="l2">
									<em>작곡</em> 조성우
									<span class="dots"><em>편곡</em> 조성우</span>
								</div>
							</div>
							<div class="ls col2">
								<div class="l1"><em>06</em> 그해 봄에 (theme from 상우),   3:05</div>
								<div class="l2">
									<em>작곡</em> 조성우
									<span class="dots"><em>편곡</em> 조성우</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			<!-- //OST -->
		</c:if>

		<!-- 박물류 -->
		<c:if test="${not empty equipList.resultList}">
			<div id="anchorEtcHistory" class="result-block mt2">
				<div class="result-block-tt type2">
					<h4>박물류 (<span class="em weighty"><c:out value="${equipList.totalCount}"/></span>)</h4>
				</div>
				<c:forEach var="item" items="${equipList.resultList  }" varStatus="status">
					<div class="mList13 image">
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
							<c:if test="${not empty item.equipNo}">
								<span class="gRt">관리번호: <c:out value="${item.equipNo}"/></span>
							</c:if>
						</div>
						<div class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath}"/>')"></span></div>
							<ul>
							<c:if test="${not empty item.div1ClssNm}">
								<li class="col2 mr1">
									<span class="tit">구분</span>
									<span class="txt"><c:out value="${item.div1ClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.div2ClssNm}">
								<li class="col2 mr1">
									<span class="tit">분류</span>
									<span class="txt"><c:out value="${item.div2ClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.weight}">
								<li class="col2 mr1">
									<span class="tit">무게</span>
									<span class="txt"><c:out value="${item.weight}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.country}">
								<li class="col2">
									<span class="tit">제작국가</span>
									<span class="txt"><c:out value="${item.country}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.component}">
								<li class="col2">
									<span class="tit">구성품</span>
									<span class="txt"><c:out value="${item.component}"/>모형 도끼(1ea)</span>
								</li>
							</c:if>
							<c:if test="${not empty item.cubicClssNm}">
								<li class="col2">
									<span class="tit">규격구분</span>
									<span class="txt"><c:out value="${item.cubicClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.materialClss}">
								<li class="col2">
									<span class="tit">재질</span>
									<span class="txt"><c:out value="${item.materialClss}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.equipContent}">
								<li class="col2">
									<span class="tit">내용</span>
									<span class="txt"><c:out value="${item.equipContent}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.fileNm}">
								<li class="thumb">
									<span class="tit row2">제명<br>(파일정보)</span>
									<span class="txt">
										<c:forTokens var="item2" items="${item.fileNm}" delims="," >
											<img src="${EQUIP_IMG_PATH}<c:out value="${item.fileSubPath}"/><c:out value="${item2}"/>" width="84" alt="">
										</c:forTokens>
									</span>
								</li>
							</c:if>
							<c:if test="${not empty item.equipContent}">
								<li class="clear">
									<span class="tit">내용</span>
									<div class="txt">
										<c:out value="${item.equipContent}"/>
									</div>
								</li>
							</c:if>
							</ul>
						</div>
				</c:forEach>
			</div>
			<!-- //박물류 -->
		</c:if>


        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {

	});


	function fcnKeyword(pKeyword) {
	    pKeyword = encodeURIComponent( encodeURIComponent( pKeyword ) );

		formSubmit("form1", "<c:url value="/history/talk/keyword/list"/>?keyword=" + pKeyword);
	}


	function fcnReviewDetail(idx){
		 var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/story/user/"+idx;
		    frm.submit();
	}
</script>