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
			<strong class="tit">영상자료 <span>(<c:out value="${ownListCount.mtotal }"/>)</span></strong>
		</div>

		<c:if test="${not empty filmList}">
			<!-- 필름 -->
			<div id="anchorMovieFilm" class="result-block pt1">
				<div class="result-block-tt type2">
					<h4>필름 (<span class="em weighty"><c:out value="${fn:length(filmList)}"/></span>)</h4>
				</div>
				<c:forEach var="item" items="${filmList }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit"><c:out value="${detailInfo.info.title}"/> </strong>
					</div>
					<div class="mList13">
						<ul>
						<c:if test="${not empty item.fItemNm}">
							<li class="col2">
								<span class="tit">구분</span>
								<span class="txt">
								<c:choose>
									<c:when test="${item.fItemNm eq 'DN'}">듀프 네거티브(DB)</c:when>
									<c:when test="${item.fItemNm eq 'MP'}">마스터 포지티브(MP)</c:when>
									<c:when test="${item.fItemNm eq 'ON'}">오리지널 네거티브(ON)</c:when>
									<c:otherwise>릴리스 프린트(RP)</c:otherwise>
								</c:choose>
								</span>
							</li>
						</c:if>
					 	<c:if test="${not empty item.fUnitNm}">
							<li class="col2">
								<span class="tit">규격</span>
								<span class="txt"><c:out value="${item.fUnitNm}"/>mm</span>
							</li>
						</c:if>
						<c:if test="${not empty item.fColorNm}">
							<li class="col2">
								<span class="tit">색채</span>
								<span class="txt"><c:out value="${item.fColorNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.fScreenNm}">
							<li class="col2">
								<span class="tit">화면비</span>
								<span class="txt"><c:out value="${item.fScreenNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.fSoundNm}">
							<li class="col2">
								<span class="tit">사운드</span>
								<span class="txt"><c:out value="${item.fSoundNm}"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.fLang}">
							<li class="col2">
								<span class="tit">언어</span>
								<span class="txt"><c:out value="${item.fLang}"/></span>
							</li>
						</c:if>
					 	<c:if test="${not empty item.fJamak}">
							<li class="col2">
								<span class="tit">자막</span>
								<span class="txt"><c:out value="${item.fJamak}"/></span>
							</li>
						</c:if>
					 	<c:if test="${not empty item.fRuntime}">
							<li class="col2">
								<span class="tit">시간</span>
								<span class="txt"><c:out value="${item.fRuntime}"/>분</span>
							</li>
						</c:if>
						<c:if test="${not empty item.fPositionNm}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt">${item.fPositionNm}</span>
							</li>
						</c:if>
						<c:if test="${not empty item.fImethodNm}">
							<li class="col2">
								<span class="tit">입수방법</span>
								<span class="txt"><c:out value="${item.fImethodNm}"/></span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<div class="mList14 type3">
					<ul>
					<li>필름정보는 일부사실과 차이가 있을수 있습니다.</li>
					<li>ON,DN,MP는 영사할 수 없는 필름입니다.</li>
					<li>RP 필름 중에서도 상태 등에 따라 상영할 수 없는 경우가 있으므로 수집부(02-3153-2047)으로 문의 바랍니다.</li>
					</ul>
				</div>
				<!-- 필름용어 설명 -->
				<div class="mList14 box1">
					<strong class="tit">필름용어 설명</strong>
					<ul>
					<li><span class="ti">ON :</span> 오리지널 네거티브(Original Negative). 최초로 카메라에서 노출된 네가티브 필름입니다.</li>
					<li><span class="ti">MP :</span> 마스터 포지티브(Master Positive). ON에서 만들어진 고화질 포지티브 필름입니다.</li>
					<li><span class="ti">DN :</span> 듀프 네거티브(Dupe Negative). MP에서 현상, 인화된 필름으로 오리지널 네거티브의 보존을 위해 제작됩니다.</li>
					<li><span class="ti">RP :</span> 릴리스 프린트(Release Print). 영사를 위해 포지티브 이미지와 사운드트랙을 합한 필름입니다.</li>
					</ul>
				</div>
				<!-- //필름용어 설명 -->
			</div>
			<!-- //필름 -->
		</c:if>

		<c:if test="${not empty dcinemaList}">
			<!-- D시네마 -->
			<div id="anchorMovieDCinema" class="result-block mt2">
				<div class="result-block-tt type2">
					<h4>D시네마 (<span class="em weighty"><c:out value="${fn:length(dcinemaList)}"/></span>)</h4>
				</div>
				<c:forEach var="item" items="${dcinemaList  }" varStatus="status">
					<div class="mList13">
						<div class="mTitle5">
							<strong class="tit"><c:out value="${detailInfo.info.title}"/> [<c:out value="${item.classClssNm}"/>]</strong>
							<span class="gRt">관리번호 : <c:out value="${item.dDetailNo}"/></span>

						</div>
						<ul>
						<c:if test="${not empty item.formClssNm}">
							<li class="col2">
								<span class="tit">파일종류</span>
								<span class="txt"><c:out value="${item.formClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.classClssNm}">
							<li class="col2">
								<span class="tit">구분</span>
								<span class="txt"><c:out value="${item.classClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.formatClssNm}">
							<li class="col2">
								<span class="tit">파일형식</span>
								<span class="txt"><c:out value="${item.formatClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.screenSizeNm}">
							<li class="col2">
								<span class="tit">해상도</span>
								<span class="txt"><c:out value="${item.screenSizeNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.pictureRatioNm}">
							<li class="col2">
								<span class="tit">화면비</span>
								<span class="txt"><c:out value="${item.pictureRatioNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.colorModeNm}">
							<li class="col2">
								<span class="tit">컬러모드</span>
								<span class="txt"><c:out value="${item.colorModeNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.soundChannel}">
							<li class="col2">
								<span class="tit">사운드채널수</span>
								<span class="txt"><c:out value="${item.soundChannel }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.methodClssNm}">
							<li class="col2">
								<span class="tit">입수방법</span>
								<span class="txt"><c:out value="${item.methodClssNm }"/></span>
							</li>
						</c:if>
						</ul>
					</div>
				</c:forEach>
				<div class="mList14 type3">
					<ul>
					<li>DSM : 설명문구가 들어가는 영역입니다.</li>
					<li>DCP : 설명문구가 들어가는 영역입니다.</li>
					</ul>
				</div>
			</div>

			<!-- //D시네마 -->
		</c:if>

		<c:if test="${not empty tapeList }">
		<!-- 테이프 -->
		<div id="anchorMovieTape" class="result-block mt2">
			<div class="result-block-tt type2">
				<h4>테이프 (<span class="em weighty"><c:out value="${fn:length(tapeList)}"/></span>)</h4>
			</div>
			<c:forEach var="item" items="${tapeList  }" varStatus="status">
			<div class="mList13 image">
				<div class="mTitle5">
					<strong class="tit">
						<c:out value="${item.titles}"/>
						<c:if test="${not empty item.titleSub}">
							&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
						</c:if>
						<c:if test="${not empty item.titleEtc}">
							[<c:out value="${item.titleEtc}"/>]
						</c:if>
					</strong>
					<span class="gRt">관리번호 : <c:out value="${item.videoNo }"/></span>
				</div>
				<div class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath }"/>')"></span></div>
				<ul>
				<c:if test="${not empty item.devClssNm}">
					<li class="col2 mr1">
						<span class="tit">규격</span>
						<span class="txt"><c:out value="${item.devClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.compy}">
					<li class="col2 mr1">
						<span class="tit">제조사</span>
						<span class="txt"><c:out value="${item.compy }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.vSale}">
					<li class="col2">
						<span class="tit">판매원</span>
						<span class="txt"><c:out value="${item.vSale }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.nationalClssNm}">
					<li class="col2">
						<span class="tit">제작국가</span>
						<span class="txt"><c:out value="${item.nationalClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.vCnt}">
					<li class="col2">
						<span class="tit">수량</span>
						<span class="txt"><c:out value="${item.vCnt }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.prodYear}">
					<li class="col2">
						<span class="tit">제조년도</span>
						<span class="txt"><c:out value="${item.prodYear }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.cnsNo}">
					<li class="col2">
						<span class="tit">심의번호</span>
						<span class="txt"><c:out value="${item.cnsNo }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.langClss}">
					<li class="col2">
						<span class="tit">언어</span>
						<span class="txt"><c:out value="${item.langClss }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.capClss}">
					<li class="col2">
						<span class="tit">자막</span>
						<span class="txt"><c:out value="${item.capClss }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.vTapebun}">
					<li class="col2">
						<span class="tit">매체분량</span>
						<span class="txt"><c:out value="${item.vTapebun }"/>분</span>
					</li>
				</c:if>
				<c:if test="${not empty item.barcode}">
					<li class="col2">
						<span class="tit">바코드</span>
						<span class="txt"><c:out value="${item.barcode }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.levelClssNm}">
					<li class="col2">
						<span class="tit">관람기준</span>
						<span class="txt"><c:out value="${item.levelClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.cnsNo}">
					<li class="col2">
						<span class="tit">심의번호</span>
						<span class="txt"><c:out value="${item.cnsNo }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.cnsDate}">
					<li class="col2">
						<span class="tit">심의일자</span>
						<span class="txt"><c:out value="${item.cnsDate }"/></span>
					</li>
				</c:if>
				<%-- <c:if test="${not empty item.cnsDate}">
					<li class="col2">
						<span class="tit">심의일자</span>
						<fmt:parseDate value="${item.cnsDate}" var="cnsDate" pattern="yyyyMMdd"/>
						<span class="txt"><fmt:formatDate value="${cnsDate}" pattern="yyyy-MM-dd"/></span>
					</li>
				</c:if> --%>
				<c:if test="${not empty item.screenClssNm}">
					<li class="col2">
						<span class="tit">화면종류</span>
						<span class="txt"><c:out value="${item.screenClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.colorClssNm}">
					<li class="col2">
						<span class="tit">색채</span>
						<span class="txt"><c:out value="${item.colorClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.runtime}">
					<li class="col2">
						<span class="tit">상영시간</span>
						<span class="txt"><c:out value="${item.runtime }"/>분</span>
					</li>
				</c:if>
				<c:if test="${not empty item.vRmethodNm}">
					<li class="col2">
						<span class="tit">녹화방식</span>
						<span class="txt"><c:out value="${item.vRmethodNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.ntscClssNm}">
					<li class="col2">
						<span class="tit">NTSC</span>
						<span class="txt"><c:out value="${item.ntscClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.posClssNm}">
					<li class="col2">
						<span class="tit">보관위치</span>
						<span class="txt"><c:out value="${item.posClssNm }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.addtionalImg}">
					<li class="col2">
						<span class="tit">부가영상</span>
						<span class="txt"><c:out value="${item.addtionalImg }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.supplement}">
					<li class="col2">
						<span class="tit">부록</span>
						<span class="txt"><c:out value="${item.supplement }"/></span>
					</li>
				</c:if>
				<c:if test="${not empty item.contents}">
					<li class="col2">
						<span class="tit">내용</span>
						<span class="txt"><c:out value="${item.contents }"/></span>
					</li>
				</c:if>
				</ul>
			</div>
			</c:forEach>
		</div>
		<!-- //테이프 -->
		</c:if>

		<c:if test="${not empty diskList }">
			<!-- 디스크 -->
			<div id="anchorMovieDisk" class="result-block mt2">
				<div class="result-block-tt type2">
					<h4>디스크 (<span class="em weighty"><c:out value="${fn:length(diskList)}"/></span>)</h4>
				</div>
				<c:forEach var="item" items="${diskList }" varStatus="status">
					<div class="mList13 image">
						<div class="mTitle5">
							<strong class="tit">
								<c:out value="${item.titles}"/>
								<c:if test="${not empty item.titleSub}">
									&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
								</c:if>
								<c:if test="${not empty item.titleEtc}">
									[<c:out value="${item.titleEtc}"/>]
								</c:if>
							</strong>
							<span class="gRt">관리번호 : <c:out value="${item.videoNo }"/></span>
						</div>
						<div class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath }"/>')"></span></div>
						<ul>
						<c:if test="${not empty item.devClssNm}">
							<li class="col2 mr1">
								<span class="tit">규격</span>
								<span class="txt"><c:out value="${item.devClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.compy}">
							<li class="col2 mr1">
								<span class="tit">제조사</span>
								<span class="txt"><c:out value="${item.compy }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.vSale}">
							<li class="col2">
								<span class="tit">판매원</span>
								<span class="txt"><c:out value="${item.vSale }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.nationalClssNm}">
							<li class="col2">
								<span class="tit">제작국가</span>
								<span class="txt"><c:out value="${item.nationalClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.vCnt}">
							<li class="col2">
								<span class="tit">수량</span>
								<span class="txt"><c:out value="${item.vCnt }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.prodYear}">
							<li class="col2">
								<span class="tit">제조년도</span>
								<span class="txt"><c:out value="${item.prodYear }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.cnsNo}">
							<li class="col2">
								<span class="tit">심의번호</span>
								<span class="txt"><c:out value="${item.cnsNo }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.langClss}">
							<li class="col2">
								<span class="tit">언어</span>
								<span class="txt"><c:out value="${item.langClss }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.capClss}">
							<li class="col2">
								<span class="tit">자막</span>
								<span class="txt"><c:out value="${item.capClss }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.vTapebun}">
							<li class="col2">
								<span class="tit">매체분량</span>
								<span class="txt"><c:out value="${item.vTapebun }"/>분</span>
							</li>
						</c:if>
						<c:if test="${not empty item.barcode}">
							<li class="col2">
								<span class="tit">바코드</span>
								<span class="txt"><c:out value="${item.barcode }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.levelClssNm}">
							<li class="col2">
								<span class="tit">관람기준</span>
								<span class="txt"><c:out value="${item.levelClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.cnsNo}">
							<li class="col2">
								<span class="tit">심의번호</span>
								<span class="txt"><c:out value="${item.cnsNo }"/></span>
							</li>
						</c:if>
						<li class="col2">
								<span class="tit">심의일자</span>
								<span class="txt"><c:out value="${item.cnsDate }"/></span>
						</li>
						<%-- <c:if test="${not empty item.cnsDate}">
							<li class="col2">
								<span class="tit">심의일자</span>
								<fmt:parseDate value="${item.cnsDate}" var="cnsDate" pattern="yyyyMMdd"/>
								<span class="txt"><fmt:formatDate value="${cnsDate}" pattern="yyyy-MM-dd"/></span>
							</li>
						</c:if> --%>
						<c:if test="${not empty item.screenClssNm}">
							<li class="col2">
								<span class="tit">화면종류</span>
								<span class="txt"><c:out value="${item.screenClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.colorClssNm}">
							<li class="col2">
								<span class="tit">색채</span>
								<span class="txt"><c:out value="${item.colorClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.runtime}">
							<li class="col2">
								<span class="tit">상영시간</span>
								<span class="txt"><c:out value="${item.runtime }"/>분</span>
							</li>
						</c:if>
						<c:if test="${not empty item.vRmethodNm}">
							<li class="col2">
								<span class="tit">녹화방식</span>
								<span class="txt"><c:out value="${item.vRmethodNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.ntscClssNm}">
							<li class="col2">
								<span class="tit">NTSC</span>
								<span class="txt"><c:out value="${item.ntscClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.posClssNm}">
							<li class="col2">
								<span class="tit">보관위치</span>
								<span class="txt"><c:out value="${item.posClssNm }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.addtionalImg}">
							<li class="col2">
								<span class="tit">부가영상</span>
								<span class="txt"><c:out value="${item.addtionalImg }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.supplement}">
							<li class="col2">
								<span class="tit">부록</span>
								<span class="txt"><c:out value="${item.supplement }"/></span>
							</li>
						</c:if>
						<c:if test="${not empty item.contents}">
							<li class="col2">
								<span class="tit">내용</span>
								<span class="txt"><c:out value="${item.contents }"/></span>
							</li>
						</c:if>
					</ul>
				</div>
			</c:forEach>
			</div>
			<!-- //디스크 -->
		</c:if>

		<c:if test="${not empty multiList.resultList}">
			<!-- 동영상 -->
			<div id="anchorMovieMovie" class="result-block mt2">
				<div class="result-block-tt type2">
					<h4>동영상 (<span class="em weighty"><c:out value="${multiList.totalCount }"/></span>)</h4>
				</div>
				<!-- list -->
				<div class="mImage7 type2">
					<ul>
						<c:forEach var="item" items="${multiList.resultList }" varStatus="status">
							<li class="pt0">
								<a href="javascript:fcnPlay('${item.multorNm}');" ><%-- TODO - VOD 플레이어 --%>
									<span class="timeline-box">
										<span class="mImg1"><span style="background-image: url('<c:out value="${item.mulImgPath }"/>')"></span></span>
										<span class="timeline">
											<span class="timeline-musicvideo"><c:out value="${item.mscreenClssNm }"/></span>
											<span><c:out value="${item.playTime }"/></span>
										</span>
										<span class="play"><i class="ico-play"></i></span>
									</span>
									<span class="text">
										<span class="title"><c:out value="${item.mulTitle }"/>
											<c:if test="${not empty item.titleSub}">
												&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
											</c:if>
											<c:if test="${not empty item.titleEtc}">
												[<c:out value="${item.titleEtc}"/>]
											</c:if>
										</span>
									</span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="paging-area line mt1">
					<!-- pagination -->
					<div class="pagination medium">
							${paging}
					</div>
					<!-- //pagination -->
				</div>
				<!--//list -->
			</div>
			<!-- //동영상 -->
		</c:if>

		<c:if test="${not empty vodList}">
		<!-- vod -->
		<div id="anchorMovieVod" class="mView3 mt1">
			<div class="result-block-tt type2">
				<h4>VOD (<span class="em weighty"><c:out value="${fn:length(vodList)}"/></span>)</h4>

			</div>
			<c:forEach var="item" items="${vodList}" varStatus="status">
			<div class="list">
				<div class="timeline-box">
					<a href="javascript:fcnVodPlayer('${item.movieId}','${item.movieSeq}','${item.multorNm}');" >
						<span class="mImg1"><span style="background-image: url('/resources/vod/thumb/${item.movieId}${item.movieSeq}_w.jpg')"></span></span>
						<span class="timeline">
							<span class="timeline-vod">VOD</span>
							<span><c:out value="${item.playTime}"/></span>
						</span>
						<span class="play purple"><i class="ico-play"></i></span>
					</a>
				</div>
				<div class="text">
					<div class="tit">
						<span class="ti">
							<c:out value="${item.mulTitle }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</span>
						<c:if test="${item.useClss eq '1'}">
							<span class="bt">kmdb VOD</span>
						</c:if>
						<c:if test="${item.useClss eq '2'}">
							<span class="bt red">영상도서관 VOD</span>
						</c:if>
					</div>
					<dl>
					<c:if test="${not empty item.playTime}">
						<dt>상영시간</dt>
						<dd><c:out value="${item.playTime}"/></dd>
					</c:if>
					<c:if test="${not empty item.colorClssNm}">
						<dt>색채</dt>
						<dd><c:out value="${item.colorClssNm}"/></dd>
					</c:if>
					<c:if test="${not empty item.hSize}">
						<dt>프레임크기</dt>
						<dd><c:out value="${item.vSize}"/>x<c:out value="${item.hSize}"/></dd>
					</c:if>
					<c:if test="${not empty item.price}">
						<dt>관람료</dt>
						<dd><c:out value="${item.price}"/>원</dd>
					</c:if>
					</dl>
					<div class="sns">
						<c:if test="${not empty item.naverUrl}">
							<a href="<c:url value='${item.naverUrl }'/>" class="naver">NAVER</a>
						</c:if>
						<c:if test="${not empty item.naverUrl}">
							<a href="<c:url value='${item.youtubeUrl }'/>" class="youtube">YOUTUBE</a>
						</c:if>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		<!-- //vod -->
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

	function fcnPlay(multerNm){
		window.open("http://flash.koreafilm.or.kr:8080/kofa2/play_trailer.html?file=trailer/"+multerNm, 'KMDB 짧은 동영상 보기', 'toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=yes,width=900,height=600, top=30,left=100');
	}
</script>