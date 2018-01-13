<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- ### 달력 CSS 변경처리 ### -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<!-- ### wisenut search JavaScript ### -->
<script src="/resources/js/wisenut/search.js"></script>

<!-- ### 본문 ::: 영화인명 ### -->

<div id="contents">
    <div class="breadcrumb">
        <ul>
            <li class="ico-home"><a href="#">홈</a></li>
            <li><a href="#">DB</a></li>
            <li class="located"><a href="#">인명DB</a></li>
        </ul>
    </div>
    <div class="container">

        <!-- ### 상단의 큰 글자들 ### -->
        <div class="top-area">
            <div class="prev-page"><a href="#"><i class="ico-prev"></i><span>이전</span></a></div>
            <div class="submenu-depth2">
                <h2><a href="#"><span>상세검색</span><i class="ico-updown ico-down"></i></a></h2>
                <div class="submenu-depth-list submenu-depth2-list">
                    <ul>
                        <li><a href="#">기획연재</a></li>
                        <li><a href="#">리뷰</a></li>
                        <li><a href="#">칼럼</a></li>
                        <li class="selected"><a href="#">영화사</a></li>
                        <li><a href="#">종료연재</a></li>
                        <li><a href="#">회원 리뷰</a></li>
                    </ul>
                </div>
            </div>
            <div class="submenu-depth3">
                <h3 class="submenu-depth3-title"><a href="#"><span>인명DB</span><i class="ico-updown ico-down"></i></a></h3>
                <div class="submenu-depth-list submenu-depth3-list">
                    <ul>
                        <li class="selected"><a href="#">한국영화걸작선</a></li>
                        <li><a href="#">독립극영화</a></li>
                        <li><a href="#">다큐멘터리</a></li>
                        <li><a href="#">애니메이션</a></li>
                        <li><a href="#">종료연재</a></li>
                        <li><a href="#">실험영화</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- ### 상단의 큰 글자들 ### -->
    <form id="searchForm" name="searchForm" method="post">
        <input type="text" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="text" id="tabName" name="tabName" value="<c:out value='${tabName}'/>"/>

            <section id="fieldset">

            <!-- module -->
            <div class="mDBSearch1">
                <dl>
                    <dt><label for="labelName">성명</label></dt>
                    <dd class="name">
                        <div class="col1"><input type="text" id="labelName" title="성명" placeholder="직접입력"></div>
                        <div class="col2 select-box">
                            <select name="" id="" class="select-tric">
                                <option value="">AND</option>
                                <option value="">OR</option>
                            </select>
                        </div>

                    </dd>
                    <dt><label for="labelFilmography">필모그래피</label></dt>
                    <dd class="name">
                        <div class="col1"><input type="text" id="labelFilmography" title="필모그래피" placeholder="직접입력"></div>
                        <div class="col2 select-box">
                            <select name="" id="" class="select-tric">
                                <option value="">AND</option>
                                <option value="">OR</option>
                            </select>
                        </div>
                    </dd>
                    <dt><label for="labelBirth">생년월일</label></dt>
                    <dd class="date">
                        <div class="col"><input type="text" id="labelBirthFrom" class="iCalendar" title="생년월일" placeholder="8자리 입력"></div>
                        <div class="bar">~</div>
                        <div class="col"><input type="text" id="labelBirthTo" class="iCalendar" title="생년월일" placeholder="8자리 입력"></div>
                    </dd>
                </dl>
                <div class="mButton1">
                    <span class="lt"><a href="###" class="mBtn1 gray"><span class="iRewrite">다시입력</span></a></span>
                    <span class="rt"><a href="javascript:detailDoSearch('movieTab');" class="mBtn1 purple"><span class="iFind">검색</span></a></span>
                </div>
            </div>
            <!-- //module -->

        </section>
    </form>
    </div>
</div>

</form>

<script type="text/javascript">
    $(document).ready(function() {


        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            showMonthAfterYear: true,
            yearSuffix: '',
            maxDate: 0
        });

        $("#labelBirthFrom").datepicker();
        $("#labelBirthTo").datepicker();
    });

</script>