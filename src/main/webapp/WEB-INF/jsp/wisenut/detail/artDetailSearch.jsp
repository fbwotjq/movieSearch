<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<!-- ### wisenut search JavaScript ### -->
<script src="/resources/js/wisenut/search.js"></script>

<!-- ### 본문 ::: 작품 ### -->
<form id="searchForm" name="searchForm" method="post">
    <input type="text" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="text" id="tabName" name="tabName" value="<c:out value='${tabName}'/>"/>

<div id="contents">
    <div class="breadcrumb">
        <ul>
            <li class="ico-home"><a href="#">홈</a></li>
            <li><a href="#">DB</a></li>
            <li class="located"><a href="#">작품DB</a></li>
        </ul>
    </div>
    <div class="container">
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
                <h3 class="submenu-depth3-title"><a href="#"><span>작품DB</span><i class="ico-updown ico-down"></i></a></h3>
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
        <form>
            <section id="fieldset">

                <!-- module -->
                <div class="mDBSearch1">
                    <dl>
                        <dt class="check"><label for="labelNationDiv">국가구분</label></dt>
                        <dd class="check">
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">전체</span></label>
                            </div>
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">국내영화</span></label>
                            </div>
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">해외영화</span></label>
                            </div>
                        </dd>
                        <dt class="check mt1"><label for="labelType">유형</label></dt>
                        <dd class="check mt1">
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">전체</span></label>
                            </div>
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">극영화</span></label>
                            </div>
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">에니메이션</span></label>
                            </div>
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">다큐멘터리</span></label>
                            </div>
                            <div class="asset">
                                <label><input type="checkbox" name="" id=""> <span class="label">기타</span></label>
                            </div>
                        </dd>
                        <dt><label for="labelName">영화명</label></dt>
                        <dd class="name">
                            <div class="col1"><input type="text" id="labelName" title="성명" placeholder="직접입력"></div>
                            <div class="col2 select-box">
                                <select name="" id="" class="select-tric">
                                    <option value="">AND</option>
                                    <option value="">OR</option>
                                </select>
                            </div>
                        </dd>
                        <dt><label for="labelActor">영화인</label></dt>
                        <!-- 영화인 -->
                        <dd class="person">
                            <!-- lst -->
                            <div class="lst">
                                <div class="col1"><input type="text" id="labelActor" title="성명" placeholder="직접입력"></div>
                                <div class="col2">
                                    <div class="co1 select-box">
                                        <select name="" id="" class="select-tric">
                                            <option value="">감독</option>
                                            <option value="">출연(성우)</option>
                                            <option value="">원작/각본/각색</option>
                                            <option value="">스텝(전체)</option>
                                        </select>
                                    </div>
                                    <div class="co2 select-box">
                                        <select name="" id="" class="select-tric">
                                            <option value="">AND</option>
                                            <option value="">OR</option>
                                        </select>
                                    </div>
                                    <div class="co3">
                                        <a href="###" class="iAdd">영화인 추가</a>
                                    </div>
                                </div>
                            </div>
                            <!-- lst -->
                            <!-- lst -->
                            <div class="lst">
                                <div class="col1"><input type="text" id="labelActor" title="성명" placeholder="직접입력"></div>
                                <div class="col2">
                                    <div class="co1 select-box">
                                        <select name="" id="" class="select-tric">
                                            <option value="">감독</option>
                                            <option value="">출연(성우)</option>
                                            <option value="">원작/각본/각색</option>
                                            <option value="">스텝(전체)</option>
                                        </select>
                                    </div>
                                    <div class="co2 select-box">
                                        <select name="" id="" class="select-tric">
                                            <option value="">AND</option>
                                            <option value="">OR</option>
                                        </select>
                                    </div>
                                    <div class="co3">
                                        <a href="###" class="iMinus">영화인 삭제</a>
                                    </div>
                                </div>
                            </div>
                            <!-- lst -->
                            <!-- lst for clone -->
                            <div class="lst clone" style="display:none;">
                                <div class="col1"><input type="text" id="labelActor" title="성명" placeholder="직접입력"></div>
                                <div class="col2">
                                    <div class="co1 select-box">
                                        <select name="" id="" class="select-tric">
                                            <option value="">감독</option>
                                            <option value="">출연(성우)</option>
                                            <option value="">원작/각본/각색</option>
                                            <option value="">스텝(전체)</option>
                                        </select>
                                    </div>
                                    <div class="co2 select-box">
                                        <select name="" id="" class="select-tric">
                                            <option value="">AND</option>
                                            <option value="">OR</option>
                                        </select>
                                    </div>
                                    <div class="co3">
                                        <a href="###" class="iMinus">영화인 삭제</a>
                                    </div>
                                </div>
                            </div>
                            <!-- lst for clone -->
                        </dd>
                        <!-- //영화인 -->
                        <dt><label for="labelCompany">제작사/투자배급사</label></dt>
                        <dd>
                            <input type="text" id="labelCompany" title="필모그래피" placeholder="직접입력">
                        </dd>
                        <dt><label for="labelKeyword">키워드/줄거리</label></dt>
                        <dd>
                            <input type="text" id="labelKeyword" title="필모그래피" placeholder="직접입력">
                        </dd>
                        <dt><label for="labelLocation">로케이션</label></dt>
                        <dd>
                            <input type="text" id="labelLocation" title="필모그래피" placeholder="직접입력">
                        </dd>
                        <dt><label for="labelYear">제작년도</label></dt>
                        <dd class="date">
                            <div class="col">
                                <span class="c1"><input type="text" id="labelYear" title="생년월일" placeholder="범위 직접입력"></span>
                                <span class="c2">년</span>
                            </div>
                            <div class="bar">~</div>
                            <div class="col">
                                <span class="c1"><input type="text" title="생년월일" placeholder="범위 직접입력"></span>
                                <span class="c2">년</span>
                            </div>
                        </dd>
                        <dt><label for="labelDate">영화개봉일</label></dt>
                        <dd class="date">
                            <div class="col"><input type="text" class="iCalendar jsBtnCalendar" title="생년월일" placeholder="8자리 입력"></div>
                            <div class="bar">~</div>
                            <div class="col"><input type="text" class="iCalendar jsBtnCalendar" title="생년월일" placeholder="8자리 입력"></div>
                        </dd>
                        <dt><label for="labelNation">제작국가</label></dt>
                        <dd class="select">
                            <input type="text" id="labelNation" title="제작국가" placeholder="국가선택">
                            <input class="btn large" type="button" value="검색">
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

    });
</script>