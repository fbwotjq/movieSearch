<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/etc.css">

<div id="contents">
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<div class="submenu-depth3">
						<h3 class="submenu-depth3-title">사이트맵</h3>
					</div>
				</div>
				<form>
					<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
					<section id="fieldset">

						<!-- module -->
						<div class="mSMap">
							<!-- DB -->
							<div class="con">
								<div class="title">
									<a href="/db/main" class="tit">DB</a>
								</div>
								<div class="list">
									<ul>
									<li><strong class="ti"><a href="###">통합검색</a></strong></li>
									<li>
										<strong class="ti"><a href="###">상세검색</a></strong>
										<div class="lst">
											<span class="ls"><a href="###">작품DB</a></span>
											<span class="ls"><a href="###">인명DB</a></span>
											<span class="ls"><a href="###">소장자료</a></span>
										</div>
									</li>
									<li><strong class="ti"><a href="/db/list">리스트</a></strong></li>
									<li><strong class="ti"><a href="/db/keyword">테마키워드</a></strong></li>
									<li><strong class="ti"><a href="/db/festival">영화제</a></strong></li>
									</ul>
								</div>
							</div>
							<!-- //DB -->

							<c:set var = "movieTextId" value=""/>
							<c:forEach var="sitemap_var" items="${menuList}" varStatus="sitemap_i" >
							<c:if test="${sitemap_var.leafYn eq 'Y' && sitemap_var.levelNum eq '1' && sitemap_var.cPmenuTitle eq '영화글' }">
							<c:set var = "movieTextId" value="${sitemap_var.cPmenuId}"/>
							</c:if>
							</c:forEach>


							<!-- 영화글 -->
							<div class="con">
								<div class="title">
									<a href="/story/main" class="tit">영화글</a>
								</div>
								<div class="list">
									<ul>
									<c:forEach var="sitemap_sub_var" items="${menuList}" varStatus="sitemap_sub_i" >
									<c:if test="${sitemap_sub_var.leafYn eq 'Y' && sitemap_sub_var.levelNum eq '2' && sitemap_sub_var.cParentId eq movieTextId }">
									<li>
										<strong class="ti"><a href="${sitemap_sub_var.cPagePath}">${sitemap_sub_var.cPmenuTitle}</a></strong>
										<div class="lst">
											<c:forEach var="sitemap_sub_var2" items="${menuList}" varStatus="sitemap_sub_i2" >
											<c:if test="${sitemap_sub_var2.cParentId eq sitemap_sub_var.cPmenuId }">
											<span class="ls"><a href="${sitemap_sub_var2.cPagePath}">${sitemap_sub_var2.cPmenuTitle}</a></span>
											</c:if>
											</c:forEach>
										</div>
									</li>
									</c:if>
									</c:forEach>
									<li><strong class="ti"><a href="/story/end">종료연재</a></strong></li>
									</ul>
									<ul>
									<li><strong class="ti"><a href="/story/webzine">영화천국</a></strong></li>
									<li><strong class="ti"><a href="/story/user">사용자 리뷰</a></strong></li>
									</ul>
								</div>
							</div>
							<!-- //영화글 -->

							<!-- VOD -->
							<div class="con">
								<div class="title">
									<a href="/vod/main" class="tit">VOD</a>
								</div>
								<div class="list">
									<ul>
									<li><strong class="ti"><a href="/vod/plan">기획전</a></strong></li>
									<li><strong class="ti"><a href="/vod/old/movie">고전영화</a></strong></li>
									</ul>
								</div>
							</div>
							<!-- //VOD -->

							<!-- 한국영화사료관 -->
							<div class="con">
								<div class="title">
									<a href="/history/main" class="tit">한국영화사료관</a>
								</div>
								<div class="list">
									<ul>
									<li><strong class="ti"><a href="/history/talk">구술채록문</a></strong></li>
									<li><strong class="ti"><a href="/history/book">도서</a></strong></li>
									<li><strong class="ti"><a href="/history/magazine">잡지</a></strong></li>
									<li><strong class="ti"><a href="/history/yearbook">연감/총서</a></strong></li>
									<li><strong class="ti"><a href="/history/document">공문서</a></strong></li>
									</ul>
									<ul>
									<li><strong class="ti"><a href="/history/contents">사료 콘텐츠</a></strong></li>
									<li><strong class="ti"><a href="/history/board">게시판</a></strong></li>
									<li><strong class="ti"><a href="###">서울의극장</a></strong></li>
									</ul>
								</div>
							</div>
							<!-- //한국영화사료관 -->

							<!-- 고객서비스 -->
							<div class="con">
								<div class="title">
									<a href="/care/kmdb" class="tit">고객서비스</a>
								</div>
								<div class="list">
									<ul>
									<li><strong class="ti"><a href="/care/kmdb">KMDb이용안내</a></strong></li>
									<li>
										<strong class="ti"><a href="/care/vod/guide">VOD이용안내</a></strong>
										<div class="lst">
											<span class="ls"><a href="/care/vod/guide">가이드</a></span>
											<span class="ls"><a href="/care/vod/pay">정기이용권</a></span>
											<span class="ls"><a href="/care/vod/license">기관라이센스</a></span>
										</div>
									</li>
									<li>
										<strong class="ti"><a href="/care/online/ask">온라인민원</a></strong>
										<div class="lst">
											<span class="ls"><a href="/care/online/ask">1:1문의</a></span>
											<span class="ls"><a href="/care/online/movieman">영화인정보등록</a></span>
											<span class="ls"><a href="/care/online/faq">FAQ</a></span>
										</div>
									</li>
									<li><strong class="ti"><a href="###">오픈API안내</a></strong></li>
									<li><strong class="ti"><a href="/notice">공지사항</a></strong></li>
									</ul>
								</div>
							</div>
							<!-- //고객서비스 -->
						</div>
						<!-- //module -->

					</section>
				</form>
			</div>
		</div>
<script type="text/javascript">
$(document).ready(function(){


});
</script>