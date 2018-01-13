<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/archives.css">

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->

<div id="contents">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
            <div class="submenu-depth3">
                <h3 class="submenu-depth3-title">구술 사업소개</h3>
            </div>
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
            <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
            <section id="fieldset">
                <c:out value="${introInfo.contents }" escapeXml="false"/>
            </section>
        </form>
    </div>
</div>


<script type="text/javascript">
$(document).ready(function(){

});

</script>