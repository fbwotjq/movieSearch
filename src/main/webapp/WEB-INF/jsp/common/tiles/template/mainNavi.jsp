<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var = "myMenuId" value=""/>
<c:set var = "parentMenuId" value=""/>

<c:if test="${menuIndex ne null && menuIndex != '' }">
	<c:set var = "myMenuId" value="${menuList[menuIndex].cPmenuId}"/>
	<c:set var = "parentMenuId" value="${menuList[menuIndex].cParentId}"/>
</c:if>

<div class="main-navigation">
		<div class="main-navigation-wrap">
		<!-- <div class="nav-header">카테고리</div> -->
		<!-- <img class="arrow arrow-right" src="../../resources/images/common/ico-nav-left-m.png" alt=">"> -->
		<div class="gnb-wrap">
			<div class="gnb-inner">
				<ul class="gnb">


				<c:forEach var="menuListVar" items="${menuList}" varStatus="i" >
					<fmt:formatNumber value="${menuListVar.cPmenuOrder }" type="number" var="cPmenuOrder" />

					<c:if test="${menuListVar.cPmenuDepth eq '1' && cPmenuOrder < 60}">
					<li class="category category-1st">
						<div class="category-line">
							<a href="javascript:menuMove('<c:url value="${menuListVar.cPagePath}"/>','${i.index}');"><span>${menuListVar.cPmenuTitle}</span></a>
							<c:if test="${menuListVar.leafYn eq 'Y' }">
							<button type="button" class="btn more"><i class="ico"></i></button>
							</c:if>
						</div>

						<c:if test="${menuListVar.leafYn == 'Y' }">
						<div class="sub-category">
							<div class="category-top"><strong>${menuListVar.cPmenuTitle} 서브</strong><a href="javascript:void(0);" class="back"><img class="arrow arrow-right" src="../../resources/images/common/ico-nav-left-m.png" alt="back"></a></div>
							<ul class="category-list">
								<c:forEach var="menuListSubVar" items="${menuList}" varStatus="j">
								<c:if test="${menuListSubVar.cPmenuDepth eq '2' && menuListSubVar.cParentId eq menuListVar.cPmenuId }">
								<li class="category category-2nd">
									<div class='category-line <c:if test="${menuListSubVar.cPmenuId eq myMenuId || menuListSubVar.cPmenuId eq parentMenuId}">on</c:if>'>
										<c:if test="${menuListSubVar.leafYn ne 'Y' }">
										<a href="javascript:menuMove('<c:url value="${menuListSubVar.cPagePath}"/>','${j.index}');"><span>${menuListSubVar.cPmenuTitle}</span></a>
										</c:if>

										<c:if test="${menuListSubVar.leafYn eq 'Y' }">
										<a href="javascript:menuMove('<c:url value="${menuListSubVar.cPagePath}"/>','${j.index+1}');"><span>${menuListSubVar.cPmenuTitle}</span></a>
										<button type="button" class="btn more"><i class="ico"></i></button>
										</c:if>

									</div>
									<c:if test="${menuListSubVar.leafYn eq 'Y' }">
									<ul class="category-box">

										<c:forEach var="menuListLastVar" items="${menuList}" varStatus="k">
										<c:if test="${menuListLastVar.cPmenuDepth eq '3' && menuListLastVar.cParentId eq menuListSubVar.cPmenuId }">
										<li <c:if test="${menuListLastVar.cPmenuId eq myMenuId || menuListLastVar.cPmenuId eq parentMenuId}">class="on"</c:if> >
											<a href="javascript:menuMove('<c:url value="${menuListLastVar.cPagePath}"/>','${k.index}');"><span>${menuListLastVar.cPmenuTitle}</span></a>
										</li>
										<c:set var = "subFirstCnt" value="2"/>
										</c:if>
										</c:forEach>
									</ul>
									</c:if>
								</li>
								</c:if>
								</c:forEach>
							</ul>
						</div>
						</c:if>
					</li>
					</c:if>
				</c:forEach>
					<li class="category category-1st">
						<div class="category-line">
							<a href="https://www.koreafilm.or.kr/main" class="blank" onclick="window.open(this.href);return false;" target="_blank"><span>한국영상자료원</span></a> <!-- 외부링크 -->
						</div>
					</li>

				</ul>
				<div class="gnb-link">
					<ul>
						<sec:authorize access="isAnonymous()">
						<li><a href="/login">로그인</a></li>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
						<form id="naviLogoutForm" action="${pageContext.request.contextPath}/doLogout" method="post" style="display:none">
						    <sec:csrfInput />
						</form>
						<li><a href="javascript:$('naviLogoutForm').submit();">로그아웃</a></li>
						</sec:authorize>
						<li><a href="/mypage/movie">마이페이지</a></li>
						<li><a href="javascript:void(0);" class="bt__mainset">초기화면 설정</a></li>
					</ul>
				</div>

				<button class="btn main-navigation-close">GNB닫기</button>
			</div>
		</div>
	</div>
</div>
<div class="main-navigation-cover"></div>

<script type="text/javascript">

	function menuMove(cPagePath, listCnt){

		/* var $form = $("#menuform_");
		if($form.length < 1) {
			$form = $("<form/>").attr({id:"menuform_", action:cPagePath , method:'POST'});
			$(document.body).append($form);
		}
		$form.empty();

		// 정보 세팅
		$("<input></input>").attr({type:"hidden", name:"menuIndex", value:listCnt}).appendTo($form);
		$("<input></input>").attr({type:"hidden", name:"${_csrf.parameterName}", value:"${_csrf.token}"}).appendTo($form);

		$form.submit();
		*/


		if(cPagePath == "/info/api"){
			alert("오픈준비중 입니다.");
		}else{
			location.href = cPagePath+"?menuIndex="+listCnt
		}

	}

    $(document).ready(function() {

		var readCookie_ = readCookie("myKMDbMainSetup");
		//console.log("readCookie_ get : " + readCookie_);
		if(readCookie_ != null){
			$('#mainSet_'+readCookie_).prop('checked',true);
		}

		$(".bt__mainset").bind('click',function(e) {
    		 $('#mainSetup').bPopup({
				positionStyle: 'fixed',
  				transition: 'slideDown'
    	     });
 		});

    	 $("#mainSetupBtn").bind('click',function(e) {

    		 var readCookie_ = $("input:radio[name='mainSetRadio']:checked").val();
    		 //console.log("readCookie_ set : " + readCookie_);
    		 if(readCookie_){
    			 writeCookie("myKMDbMainSetup", readCookie_);
    		 }
    		 $("#mainSetup").bPopup().close();
 		});

    });
</script>