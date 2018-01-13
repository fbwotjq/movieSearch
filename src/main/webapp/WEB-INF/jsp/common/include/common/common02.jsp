<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var = "myMenuCnt" value="${menuIndex}"/>
<c:set var = "myMenuId" value="${menuList[myMenuCnt].cPmenuId}"/>
<c:set var = "myMenuTitle" value="${menuList[myMenuCnt].cPmenuTitle}"/>
<c:set var = "myMenuLevel" value="${menuList[myMenuCnt].levelNum}"/>
<c:set var = "parentMenuId" value="${menuList[myMenuCnt].cParentId}"/>
<c:set var = "parentMenuCnt" value="0"/>
<c:set var = "parentMenuTitle" value=""/>

<c:forEach var="menuListVar" items="${menuList}" varStatus="i">
<c:if test="${menuListVar.cPmenuId eq parentMenuId}">
	<c:set var = "parentMenuCnt" value="${i.index}"/>
	<c:set var = "parentMenuTitle" value="${menuListVar.cPmenuTitle}"/>
</c:if>
</c:forEach>

<div class="submenu-depth2">
	<h2><a href="#"><span>${parentMenuTitle}</span><i class="ico-updown ico-down"></i></a></h2>
	<div class="submenu-depth-list submenu-depth2-list">
		<ul>
			<c:forEach var="menuListVar2" items="${menuList}" varStatus="j">


				<c:if test="${menuListVar2.cParentId eq menuList[parentMenuCnt].cParentId}">
					<fmt:formatNumber value="${menuListVar2.cPmenuOrder }" type="number" var="cPmenuOrder" />
					<c:if test="${!(menuListVar2.levelNum eq '1' && cPmenuOrder > 50)}">
						<c:choose>
							<c:when test="${menuListVar2.cPmenuId eq  parentMenuId}">
								<li class="selected"><a href="#">${menuListVar2.cPmenuTitle}</a></li>
							</c:when>
							<c:otherwise>

                                        <c:if test="${menuListVar2.leafYn ne 'Y' }">
                                        <li><a href="javascript:menuMove('${menuListVar2.cPagePath}','${j.index}');">${menuListVar2.cPmenuTitle}</a></li>
                                        </c:if>

                                        <c:if test="${menuListVar2.leafYn eq 'Y' }">
                                        <li><a href="javascript:menuMove('${menuListVar2.cPagePath}','${j.index + 1}');">${menuListVar2.cPmenuTitle}</a></li>
                                        </c:if>


							</c:otherwise>
						</c:choose>
					</c:if>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>

<div class="submenu-depth3">

	<h3 class="submenu-depth3-title"><a href="#"><span>${myMenuTitle}</span><i class="ico-updown ico-down"></i></a></h3>

	<div class="submenu-depth-list submenu-depth3-list">
		<ul>
			<c:forEach var="menuListVar3" items="${menuList}" varStatus="k">
			<c:if test="${menuListVar3.cParentId eq parentMenuId}">
			<c:if test="${menuListVar3.cPmenuId eq  myMenuId}">
			<li class="selected"><a href="#">${menuListVar3.cPmenuTitle}</a></li>
			</c:if>
			<c:if test="${menuListVar3.cPmenuId ne  myMenuId}">

                                        <c:if test="${menuListVar3.leafYn ne 'Y' }">
                                        <li><a href="javascript:menuMove('${menuListVar3.cPagePath}','${k.index}');">${menuListVar3.cPmenuTitle}</a></li>
                                        </c:if>

                                        <c:if test="${menuListVar3.leafYn eq 'Y' }">
                                        <li><a href="javascript:menuMove('${menuListVar3.cPagePath}','${k.index + 1}');">${menuListVar3.cPmenuTitle}</a></li>
                                        </c:if>




			</c:if>
			</c:if>
			</c:forEach>
		</ul>
	</div>
</div>