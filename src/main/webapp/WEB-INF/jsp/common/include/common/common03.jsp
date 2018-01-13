<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var = "myMenuCnt" value="${menuIndex}"/>
<c:set var = "parentMenuId" value="${menuList[myMenuCnt].cParentId}"/>
<c:set var = "parentMenuCnt" value="0"/>
<c:forEach var="menuList03L1" items="${menuList}" varStatus="i03l1">
<c:if test="${menuList03L1.cPmenuId eq parentMenuId}">
	<c:set var = "parentMenuCnt" value="${i03l1.index}"/>
</c:if>
</c:forEach>

<ul>
	<li class="ico-home"><a href="#">홈</a></li>
	<c:forEach var="menuList03L2" items="${menuList}" varStatus="i03l2">
		<c:if test="${menuList03L2.cPmenuId eq menuList[parentMenuCnt].cParentId}">
			<c:if test="${menuList03L2.leafYn ne 'Y' }">
			<li><a href="javascript:menuMove('<c:url value="${menuList03L2.cPagePath}"/>','${i03l2.index}');">${menuList03L2.cPmenuTitle}</a></li>
			</c:if>
			<c:if test="${menuList03L2.leafYn eq 'Y' }">
			<li><a href="javascript:menuMove('<c:url value="${menuList03L2.cPagePath}"/>','${i03l2.index+1}');">${menuList03L2.cPmenuTitle}</a></li>
			</c:if>
		</c:if>
		<c:if test="${menuList03L2.cPmenuId eq menuList[myMenuCnt].cParentId}">
			<c:if test="${menuList03L2.leafYn ne 'Y' }">
			<li><a href="javascript:menuMove('<c:url value="${menuList03L2.cPagePath}"/>','${i03l2.index}');">${menuList03L2.cPmenuTitle}</a></li>
			</c:if>
			<c:if test="${menuList03L2.leafYn eq 'Y' }">
			<li><a href="javascript:menuMove('<c:url value="${menuList03L2.cPagePath}"/>','${i03l2.index+1}');">${menuList03L2.cPmenuTitle}</a></li>
			</c:if>
		</c:if>
		<c:if test="${menuList03L2.cPmenuId eq menuList[myMenuCnt].cPmenuId}">
			<li><a href="javascript:menuMove('${menuList03L2.cPagePath}','${i03l2.index}');">${menuList03L2.cPmenuTitle}</a></li>
		</c:if>
	</c:forEach>
</ul>