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
        <input type="hidden" id="searchType" name="searchType" value=""/>
        <input type="hidden" id="ownCategory" name="ownCategory" value="<c:url value='${paramMap.ownCategory}'/>"/>
        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">
        <input type="hidden" id="_page" name="_page" value=""/>
        <input type="hidden" id="typeClss" name="typeClss" value="2"/>
        <section id="fieldset">

        <%@ include file="/WEB-INF/jsp/db/kor/movieProfile.jsp"%>

        <div class="mTitle4">
			<strong class="tit">이미지 <span>(<c:out value="${ownListCount.itotal }"/>)</span></strong>
		</div>


		<!-- 포스터 파일 -->
		<div id="anchorImagePoster" class="result-block pt1" >
			<div class="result-block-tt type2 mb2">
				<h4>포스터 (<span class="em weighty"><c:out value="${ownListCount.postercnt }"/></span>)</h4>
			</div>
			<div class="result-block-tt noline pb1">
				<h4>포스터 파일 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
			</div>
			<!-- list -->
			<div class="mList8 type3">
				<ul>
				<c:forEach var="item" items="${pageListVo.resultList  }" varStatus="status">
					<li>
						<a href="#dataHashImageDetail${status.index}" class="jsBtnImage">
							<span class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath }"/>')"></span></span>
							<span class="text">
								<span class="txt row2">
									<c:out value="${item.mainTitle}"/>
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
			<!--//list -->
			<div class="paging-area line">
				<!-- pagination -->
				<div class="pagination medium">
					${paging}
				</div>
				<!-- //pagination -->
			</div>

		</div>
		<!-- //포스터 파일 -->


		<!-- 포스터인쇄물 -->
		<c:if test="${not empty posterPrintList}">
			<div class="result-block mt1">
				<div class="result-block-tt noline pb1">
					<h4>포스터 인쇄물 (<span class="em weighty">${fn:length(posterPrintList)}</span>)</h4>
				</div>
				<c:forEach var="item" items="${posterPrintList  }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.mainTitle }"/>
							<c:if test="${not empty item.titleSub}">
								&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
							</c:if>
							<c:if test="${not empty item.titleEtc}">
								[<c:out value="${item.titleEtc}"/>]
							</c:if>
						</strong>
						<c:if test="${not empty item.relDataNo}">
							<span class="gRt">관리번호: <c:out value="${item.relDataNo}"/></span>
						</c:if>
					</div>
					<div class="mList13">
						<ul>
							<c:if test="${not empty item.nationClssNm}">
								<li class="col2">
									<span class="tit">발행국</span>
									<span class="txt"><c:out value="${item.nationClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.nationalClssNm}">
								<li class="col2">
									<span class="tit">국가구분</span>
									<span class="txt"><c:out value="${item.nationalClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.producer}">
								<li class="col2">
									<span class="tit">배급</span>
									<span class="txt"><c:out value="${item.producer}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.colorClssNm}">
								<li class="col2">
									<span class="tit">색채</span>
									<span class="txt"><c:out value="${item.colorClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.postYear}">
								<li class="col2">
									<span class="tit">개봉일</span>
									<span class="txt"><c:out value="${item.postYear}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.copyText}">
								<li class="col2">
									<span class="tit">홍보카피</span>
									<span class="txt"><c:out value="${item.copyText}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.langClss}">
								<li class="col2">
									<span class="tit">언어</span>
									<span class="txt"><c:out value="${item.langClss}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.personInfo}">
								<li class="col2">
									<span class="tit">인물</span>
									<span class="txt"<c:out value="${item.personInfo}"/></span>
								</li>
							</c:if>
						</ul>
						<c:if test="${not empty item.typeClss or not empty item.imgHsize or not empty item.posClssNm }">
							<div class="list2">
								<strong class="tit">소장자료</strong>
								<div class="lst">
									<c:if test="${not empty item.typeClss}">
										<div class="ls">
											<span class="ti">형태</span>
											<span class="tx"><c:out value="${item.typeClssNm}"/></span>
										</div>
									</c:if>
									<c:if test="${not empty item.imgVsize}">
										<div class="ls">
											<span class="ti">크기</span>
											<span class="tx"><c:out value="${item.imgVsize}"/> X <c:out value="${item.imgHsize}"/></span>
										</div>
									</c:if>
									<c:if test="${not empty item.posClssNm}">
										<div class="ls">
											<span class="ti">보관위치</span>
											<span class="tx"><c:out value="${item.posClssNm}"/></span>
										</div>
									</c:if>
								</div>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<!-- //포스터인쇄물 -->

		<!-- 스틸 파일 -->
		<c:if test="${not empty pageListVo2.resultList}">
			<div id="anchorImageStill" class="result-block mt1">
				<div class="result-block-tt type2 mb1">
					<h4>스틸 (<span class="em weighty"><c:out value="${ownListCount.stilcnt }"/></span>)</h4>
				</div>
				<div class="result-block-tt noline pb1">
					<h4>스틸 파일 (<span class="em weighty"><c:out value="${pageListVo2.totalCount }"/></span>)</h4>
				</div>
				<!-- list -->
				<div class="mList8 type3" >
					<ul>
						<c:forEach var="item" items="${pageListVo2.resultList  }" varStatus="status">
							<li>
								<a href="#dataHashStillDetail${status.index}" class="jsBtnImage2">
									<span class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath }"/>')"></span></span>
									<span class="text"><em class="tit"></em>
										<span class="txt">
											<c:out value="${item.mainTitle}"/>
										</span>
									</span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!--//list -->
				<div class="paging-area line">
					<!-- pagination -->
					<div class="pagination medium">
						${paging2}
					</div>
					<!-- //pagination -->
				</div>
			</div>
		</c:if>
		<!-- //스틸 파일 -->

		<!-- 스틸 인쇄물 -->
		<c:if test="${not empty stillPrintList}">
			<div class="result-block mt1">
				<div class="result-block-tt noline pb1">
					<h4>스틸 인쇄물 (<span class="em weighty">${fn:length(stillPrintList)}</span>)</h4>
				</div>
				<c:forEach var="item" items="${stillPrintList  }" varStatus="status">
					<div class="mTitle5">
						<strong class="tit">
							<c:out value="${item.mainTitle }"/>
						</strong>
						<c:if test="${not empty item.stillNo}">
							<span class="gRt">관리번호: <c:out value="${item.stillNo}"/></span>
						</c:if>
					</div>
					<div class="mList13">
						<ul>
							<c:if test="${not empty item.typeClssNm}">
								<li class="col2">
									<span class="tit">구분</span>
									<span class="txt"><c:out value="${item.typeClssNm}"/></span>
								</li>
							</c:if>
							<c:if test="${not empty item.contensDclssNm}">
								<li class="col2">
									<span class="tit">내용상세</span>
									<span class="txt"><c:out value="${item.contensDclssNm}"/>장면사진</span>
								</li>
							</c:if>
							<c:if test="${not empty item.personInfo}">
								<li class="clear">
									<span class="tit">인물</span>
									<span class="txt"><c:out value="${item.personInfo}"/></span>
								</li>
							</c:if>
						</ul>
						<div class="list2">
							<strong class="tit">소장자료</strong>
							<div class="gCol2">
								<!-- lst -->
								<c:if test="${not empty item.kindClssNm or not empty item.hsize or not empty item.fileSize}">
									<div class="lst">
										<c:if test="${not empty item.kindClssNm}">
											<div class="ls">
												<span class="ti">형태</span>
												<span class="tx"><c:out value="${item.kindClssNm}"/></span>
											</div>
										</c:if>
										<c:if test="${not empty item.hsize}">
											<div class="ls">
												<span class="ti">크기</span>
												<span class="tx"><c:out value="${item.vSize}"/>x<c:out value="${item.hSize}"/>px</span>
											</div>
										</c:if>
										<c:if test="${not empty item.fileSize}">
											<div class="ls">
												<span class="ti">용량</span>
												<span class="tx"><c:out value="${item.fileSizeNm}"/></span>
											</div>
										</c:if>
									</div>
								</c:if>
								<!-- //lst -->
								<!-- lst -->
								<c:if test="${not empty item.dpValue or not empty item.colDepth or not empty item.posClss}">
									<div class="lst">
										<c:if test="${not empty item.dpValue}">
											<div class="ls">
												<span class="ti">해상도</span>
												<span class="tx"><c:out value="${item.dpValue}"/></span>
											</div>
										</c:if>
										<c:if test="${not empty item.colDepth}">
											<div class="ls">
												<span class="ti">색심도</span>
												<span class="tx"><c:out value="${item.colDepth}"/></span>
											</div>
										</c:if>
										<c:if test="${not empty item.posClss}">
											<div class="ls">
												<span class="ti">보관위치</span>
												<span class="tx"><c:out value="${item.posClssNm}"/></span>
											</div>
										</c:if>
									</div>
								</c:if>
								<!-- //lst -->
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<!-- //스틸 인쇄물 -->

        </section>
        </form>
    </div>
</div>


<!-- 이미지갤러리popup -->
	<div id="jsImage" class="mLayer1" style="display:none;">
		<div class="modalBg"></div>
		<div class="layerBg">
			<div class="cont top">
				<div class="title">
					<h3><c:out value="${detailInfo.info.title}"/> <em id="em_count"></em></h3>
				</div>
				<a href="###" class="b-close" title="닫기"">닫기</a>
			</div>

			<!-- swiper -->
			<div class="mVImage1">
				<div class="cont">
					<div class="owl-carousel owl-theme" id="db-image-view1">
						<!-- item -->
						<c:forEach var="item" items="${galleryPosterList }" varStatus="status">
							<div class="item" data-hash="dataHashImageDetail${status.index }">
								<span><img src="<c:out value='${item.imgPath }'/>" alt=""></span>
								<!-- text -->
								<div class="text">
									<div class="mTitle5">
										<a href="###" class="iBig">큰 이미지 보기</a>
										<strong class="tit"><c:out value="${item.mainTitle }"/></strong>
										<c:if test="${not empty item.relDataNo}">
											<span class="gRt">관리번호: <c:out value="${item.relDataNo}"/></span>
										</c:if>
									</div>
									<div class="mList13">
										<ul>
										<c:if test="${not empty item.personNm}">
											<li class="col2">
												<span class="tit">인물</span>
												<span class="txt"><c:out value="${item.personNm }"/></span>
											</li>
										</c:if>
										<c:if test="${not empty item.producer}">
											<li class="col2">
												<span class="tit">배급</span>
												<span class="txt"><c:out value="${item.producer }"/></span>
											</li>
										</c:if>
										<c:if test="${not empty item.adDesign}">
											<li class="col2">
												<span class="tit">디자인</span>
												<span class="txt"><c:out value="${item.adDesign }"/></span>
											</li>
										</c:if>
										<c:if test="${not empty item.postYear}">
											<li class="col2">
												<span class="tit">개봉일</span>
												<span class="txt"><fmt:formatDate value="${releaseDate}" pattern="yyyy-MM-dd"/></span>
											</li>
										</c:if>
										<c:if test="${not empty item.langClss}">
											<li class="col2">
												<span class="tit">언어</span>
												<span class="txt"><c:out value="${item.langClss }"/></span>
											</li>
										</c:if>
										<c:if test="${not empty item.nationalClssNm}">
											<li class="col2">
												<span class="tit">국가구분</span>
												<span class="txt"><c:out value="${item.nationalClssNm }"/></span>
											</li>
										</c:if>
										</ul>
										<div class="list2">
											<strong class="tit">소장자료</strong>
											<div class="gCol2">
												<div class="lst">
													<c:if test="${not empty item.typeClssNm}">
														<div class="ls">
															<span class="ti">형태</span>
															<span class="tx"><span class="txt"><c:out value="${item.typeClssNm }"/></span>
														</div>
													</c:if>
													<c:if test="${not empty item.imgHsize}">
														<div class="ls">
															<span class="ti">크기</span>
															<span class="tx"><c:out value="${item.imgVsize }"/>x<c:out value="${item.imgHsize }"/>px</span>
														</div>
													</c:if>
													<c:if test="${not empty item.dpValue}">
														<div class="ls">
															<span class="ti">해상도</span>
															<span class="tx"><c:out value="${item.dpValue }"/>dpi</span>
														</div>
													</c:if>
													<c:if test="${not empty item.colDepth}">
														<div class="ls">
															<span class="ti">색심도</span>
															<span class="tx"><c:out value="${item.colDepth }"/></span>
														</div>
													</c:if>
													<c:if test="${not empty item.posClssNm}">
														<div class="ls">
															<span class="ti">보관위치</span>
															<span class="tx"><c:out value="${item.posClssNm }"/>-</span>
														</div>
													</c:if>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- //text -->
							</div>
						</c:forEach>
						<!-- //item -->

					</div>
				</div>
			</div>
			<!-- //swiper -->
		</div>
	</div>



<!-- 스틸이미지갤러리popup -->
	<div id="jsImage2" class="mLayer1" style="display:none;">
		<div class="modalBg"></div>
		<div class="layerBg">
			<div class="cont top">
				<div class="title">
					<h3><c:out value="${detailInfo.info.title}"/> <em id="em_count2"></em></h3>
				</div>
				<a href="###" class="b-close" title="닫기"">닫기</a>
			</div>

			<!-- swiper -->
			<div class="mVImage2">
				<div class="cont">
					<div class="owl-carousel owl-theme" id="db-image-view2">
					<c:forEach var="item" items="${galleryStillList }" varStatus="status">
						<!-- item -->
						<div class="item" data-hash="dataHashStillDetail${status.index }">
							<div class="img"><img src="<c:out value='${item.imgPath }'/>" alt=""></div>
							<!-- text -->
							<div class="text">
								<div class="mTitle5">
									<a href="###" class="iBig">큰 이미지 보기</a>
									<strong class="tit"><c:out value="${item.mainTitle }"/></strong>
									<c:if test="${not empty item.stillNo}">
										<span class="gRt">관리번호: <c:out value="${item.stillNo}"/></span>
									</c:if>
								</div>
								<div class="mList13">
									<ul>
									<c:if test="${not empty item.typeClssNm}">
										<li class="col2">
											<span class="tit">구분</span>
											<span class="txt"><c:out value="${item.typeClssNm }"/></span>
										</li>
									</c:if>
									<c:if test="${not empty item.personInfo}">
										<li class="col2">
											<span class="tit">인물</span>
											<span class="txt"><c:out value="${item.personInfo }"/></span>
										</li>
									</c:if>
										<li class="col2">
											<span class="tit">디자인</span>
											<span class="txt">&nbsp;</span>
										</li>
										<li class="col2">
											<span class="tit">개봉일</span>
											<span class="txt"><fmt:formatDate value="${releaseDate}" pattern="yyyy-MM-dd"/></span>
										</li>
									<c:if test="${not empty item.langClss}">
										<li class="col2">
											<span class="tit">언어</span>
											<span class="txt"><c:out value="${item.langClss }"/></span>
										</li>
									</c:if>
									<c:if test="${not empty item.keywords}">
										<li class="col2">
											<span class="tit">내용</span>
											<span class="txt"><c:out value="${item.keywords }"/></span>
										</li>
									</c:if>
									<c:if test="${not empty item.contensDclssNm}">
										<li class="col2">
											<span class="tit">내용상세</span>
											<span class="txt"><c:out value="${item.contensDclssNm }"/></span>
										</li>
									</c:if>
									</ul>
									<div class="list2">
										<strong class="tit">소장자료</strong>
										<div class="gCol2">
											<div class="lst">
												<c:if test="${not empty item.kindClssNm}">
													<div class="ls">
														<span class="ti">형태</span>
														<span class="tx"><c:out value="${item.kindClssNm }"/></span>
													</div>
												</c:if>
												<c:if test="${not empty item.fileSizeNm}">
													<div class="ls">
														<span class="ti">크기</span>
														<span class="tx"><c:out value="${item.fileSizeNm }"/></span>
													</div>
												</c:if>
												<c:if test="${not empty item.dpValue}">
													<div class="ls">
														<span class="ti">해상도</span>
														<span class="tx"><c:out value="${item.dpValue }"/>dpi</span>
													</div>
												</c:if>
												<c:if test="${not empty item.colDepth}">
													<div class="ls">
														<span class="ti">색심도</span>
														<span class="tx"><c:out value="${item.colDepth }"/></span>
													</div>
												</c:if>
												<c:if test="${not empty item.posClssNm}">
													<div class="ls">
														<span class="ti">보관위치</span>
														<span class="tx"><c:out value="${item.posClssNm }"/></span>
													</div>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- //text -->
						</div>
						<!-- //item -->
					</c:forEach>

					</div>
				</div>
			</div>
			<!-- //swiper -->
		</div>
	</div>

<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
	/* 	var dbImageView1 = $('#db-image-view1');
		$dbImageView1.owlCarousel({
			loop:false,
			dots:false,
			nav: true,
			margin:1,
			items:1,
			startPosition: 'URLHash',
			onChanged :callback
		});
		$('.b-close').bind('click', function(e) {
			$("body").removeClass("overflowHidden")
		});

		$('.jsBtnImage').bind('click', function(e) {
			BPOPUP =  $('#jsImage').bPopup({
				positionStyle: 'fixed'
			});
			$("body").addClass("overflowHidden")
			$("#jsImage .layerBg").height( $(window).height() );
		});
		$dbImageView1.on('changed.owl.carousel',function(event){
			$(".mVImage1 .owl-theme .owl-nav .owl-prev, .mVImage1 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage1 .img").eq(event.item.index).height()/2)-17);
			$(window).on("load resize", function(){
				setTimeout( function(){
					$(".mVImage1 .owl-theme .owl-nav .owl-prev, .mVImage1 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage1 .img").eq(event.item.index).height()/2)-17);
				},1000);
			});
		});

		var dbImageView2 = $('#db-image-view2');
		$dbImageView2.owlCarousel({
			loop:false,
			dots:false,
			nav: true,
			margin:1,
			items:1,
			startPosition: 'URLHash',
			onChanged :callback
		});
		$('.jsBtnImage2').bind('click', function(e) {
			BPOPUP =  $('#jsImage2').bPopup({
				positionStyle: 'fixed'
			});
			$("body").addClass("overflowHidden")
			$("#jsImage2 .layerBg").height( $(window).height() );
		});
		$dbImageView2.on('changed.owl.carousel',function(event){
			$(".mVImage2 .owl-theme .owl-nav .owl-prev, .mVImage1 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage2 .img").eq(event.item.index).height()/2)-17);
			$(window).on("load resize", function(){
				setTimeout( function(){
					$(".mVImage2 .owl-theme .owl-nav .owl-prev, .mVImage1 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage2 .img").eq(event.item.index).height()/2)-17);
				},1000);
			});
		});
		 */
		var $dbImageView1 = $('#db-image-view1');
		$dbImageView1.owlCarousel({
			loop:false,
			dots:false,
			nav: true,
			margin:1,
			items:1,
			startPosition: 'URLHash',
			onChanged :callback
		});
		$('.b-close').bind('click', function(e) {
			$("body").removeClass("overflowHidden")
		});
		$('.jsBtnImage').bind('click', function(e) {
			BPOPUP =  $('#jsImage').bPopup({
				positionStyle: 'fixed'
			});
			$("body").addClass("overflowHidden")
			$("#jsImage .layerBg").height( $(window).height() );
		});
		$dbImageView1.on('changed.owl.carousel',function(event){
			$(".mVImage1 .owl-theme .owl-nav .owl-prev, .mVImage1 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage1 .img").eq(event.item.index).height()/2)-17);
			$(window).on("load resize", function(){
				setTimeout( function(){
					$(".mVImage1 .owl-theme .owl-nav .owl-prev, .mVImage1 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage1 .img").eq(event.item.index).height()/2)-17);
				},1000);
			});
		});

		var $dbImageView2 = $('#db-image-view2');
		$dbImageView2.owlCarousel({
			loop:false,
			dots:false,
			nav: true,
			margin:1,
			items:1,
			startPosition: 'URLHash',
			onChanged :callback
		});
		$('.b-close').bind('click', function(e) {
			$("body").removeClass("overflowHidden")
		});
		$('.jsBtnImage2').bind('click', function(e) {
			BPOPUP =  $('#jsImage2').bPopup({
				positionStyle: 'fixed'
			});
			$("body").addClass("overflowHidden")
			$("#jsImage2 .layerBg").height( $(window).height() );
		});
		$dbImageView2.on('changed.owl.carousel',function(event){
			$(".mVImage2 .owl-theme .owl-nav .owl-prev, .mVImage2 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage2 .img").eq(event.item.index).height()/2)-17);
			$(window).on("load resize", function(){
				setTimeout( function(){
					$(".mVImage2 .owl-theme .owl-nav .owl-prev, .mVImage2 .owl-theme .owl-nav .owl-next").css("top", ($(".mVImage2 .img").eq(event.item.index).height()/2)-17);
				},1000);
			});
		});

	});

	function callback(event) {
		var items     = event.item.count;     // Number of items
	    var item      = event.item.index;
	    $("#em_count").text("("+(item+1)+"/"+items+")");
	    $("#em_count2").text("("+(item+1)+"/"+items+")");

	}


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

	function fncGoPage_P(page_){
		$('#searchType').val("P");
		$('#_page').val(page_);

		$.ajax({
		    url: "<c:url value='${paramMap._list_path}'/>/listpage",
			type: 'POST',
			dataType: 'html',
			beforeSend : function(xhr) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				xhr.setRequestHeader(header, token);
			},
			data: $("#form1").serialize(),
			success: function(data) {

	      		$("#anchorImagePoster").html(data);
	        }
		});

	}

	function fncGoPage_S(page_){
		$('#searchType').val("S");
		$('#_page').val(page_);
		$.ajax({
		    url: "<c:url value='${paramMap._list_path}'/>/listpage",
			type: 'POST',
			dataType: 'html',
			beforeSend : function(xhr) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				xhr.setRequestHeader(header, token);
			},
			data: $("#form1").serialize(),
			success: function(data) {
				$('#wrap').spin(false);
	      		$("#anchorImageStill").html(data);
	        }
		});
	}
</script>