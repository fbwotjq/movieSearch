<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:choose>
	 	<c:when test ="${paramMap.searchType == 'P' }">
		  	<div class="result-block-tt type2 mb2">
				<h4>포스터 (<span class="em weighty"><c:out value="${ownListCount.postercnt }"/></span>)</h4>
			</div>
			<div class="result-block-tt noline pb1">
				<h4>포스터 파일 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
			</div>
	 	</c:when>
		<c:otherwise>
			<div class="result-block-tt type2 mb1">
				<h4>스틸 (<span class="em weighty"><c:out value="${ownListCount.stilcnt }"/></span>)</h4>
			</div>
			<div class="result-block-tt noline pb1">
				<h4>스틸 파일 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
			</div>
		</c:otherwise>
	</c:choose>
	<!-- list -->
	<div class="mList8 type3">
		<ul>
		<c:forEach var="item" items="${pageListVo.resultList  }" varStatus="status">
			<c:set var="num" value="${(8 * paramMap._page) + status.index -8}"/>
			<li>
				<c:choose>
	 				<c:when test ="${paramMap.searchType == 'P' }">
		  				<a href="#dataHashImageDetail<c:out value="${num}"/>" class="jsBtnImage">
				 	</c:when>
					<c:otherwise>
						<a href="#dataHashStillDetail<c:out value="${num}"/>" class="jsBtnImage2">
					</c:otherwise>
				</c:choose>
					<span class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath }"/>')"></span></span>
					<span class="text">
						<span class="txt <c:if test ='${paramMap.searchType eq "P" }'>row2</c:if>"/>
							<c:out value="${item.mainTitle}"/>
							 <c:if test ='${paramMap.searchType eq "P" }'>
								<c:if test="${not empty item.titleSub}">
									&nbsp;:&nbsp;<c:out value="${item.titleSub}"/>
								</c:if>
								<c:if test="${not empty item.titleEtc}">
									[<c:out value="${item.titleEtc}"/>]
								</c:if>
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