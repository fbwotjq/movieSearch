<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- profile -->
<div class="mProfile">
    <div class="mImg1">
        <span style="background-image: url('<c:out value="${personInfo.headImgVo.imgPath }" default="/resources/images/common/noimage.gif"/>')"></span>
    </div>
    <div class="text">
        <div class="nam">
            <div class="na1"><c:out value="${personInfo.kornm }"/></div>
            <div class="na2"><c:out value="${personInfo.engnm }"/> / <c:out value="${personInfo.chinm }"/></div>
        </div>
        <div class="desc">
            <dl>
            <c:if test="${not empty personInfo.birthInfo }">
	            <dt>출생&middot;사망</dt>
	            <dd><c:out value="${personInfo.birthInfo }"/></dd>
            </c:if>

            <c:if test="${not empty personInfo.specFieldListString }">
	            <dt>대표분야</dt>
	            <dd><c:out value="${personInfo.specFieldListString }"/></dd>
            </c:if>

            <c:if test="${not empty personInfo.debutInfo }">
	            <dt>데뷔작품</dt>
	            <dd><c:out value="${personInfo.debutInfo }"/></dd>
            </c:if>

            <c:if test="${not empty personInfo.actYearListString }">
	            <dt>활동년대</dt>
	            <dd><c:out value="${personInfo.actYearListString }"/></dd>
            </c:if>
            </dl>
        </div>
    </div>
</div>
<!-- //profile -->

<!-- slide tab -->
<div class="mMenu1 type2">
    <!-- depth1 -->
    <div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
        <a href="#db-tab-menu4">소장자료</a>
        <a href="#db-tab-menu4_2" onclick="fcnPersonDetail('<c:out value="${personInfo.personId }"/>');" class="selected">기본정보</a>
    </div>
    <!-- //depth1 -->
    <!-- depth2 for 소장자료 -->
    <div class="owl-carousel dep2" id="db-tab-menu4" style="display:none;">
        <span class="ti"><strong>영상자료</strong>(10)</span>
        <a href="###">필름(99+)</a>
        <a href="###">D시네마(99+)</a>
        <a href="###">테이프(99+)</a>
        <a href="###">디스크(99+)</a>
        <a href="###">동영상(99+)</a>
        <a href="###">VOD(+99)</a>
        <span class="ti"><strong>이미지</strong>(10)</span>
        <a href="###">포스터(99+)</a>
        <a href="###">스틸(99+)</a>
        <span class="ti"><strong>문헌자료</strong>(10)</span>
        <a href="###">시나리오/콘티(2)</a>
        <a href="###">전단(2)</a>
        <a href="###">도서(2)</a>
        <a href="###">논문(2)</a>
        <a href="###">심의서류(2)</a>
        <a href="###">보도자료(2)</a>
        <a href="###">기타자료(2)</a>
        <span class="ti"><strong>기타</strong>(10)</span>
        <a href="###">OST(99+)</a>
        <a href="###">박물류(99+)</a>
    </div>
    <!-- depth2 for 기본정보 -->
    <div class="owl-carousel dep2" id="db-tab-menu4_2">
        <span class="ti"><strong>영상자료</strong>(10)</span>
        <a href="###">필름(99+)</a>
        <a href="###">D시네마(99+)</a>
        <a href="###">테이프(99+)</a>
        <a href="###">디스크(99+)</a>
        <a href="###">동영상(99+)</a>
        <a href="###">VOD(+99)</a>
        <span class="ti"><strong>이미지</strong>(10)</span>
        <a href="###">포스터(99+)</a>
        <a href="###">스틸(99+)</a>
        <span class="ti"><strong>문헌자료</strong>(10)</span>
        <a href="###">시나리오/콘티(2)</a>
        <a href="###">전단(2)</a>
        <a href="###">도서(2)</a>
        <a href="###">논문(2)</a>
        <a href="###">심의서류(2)</a>
        <a href="###">보도자료(2)</a>
        <a href="###">기타자료(2)</a>
        <span class="ti"><strong>기타</strong>(10)</span>
        <a href="###">OST(99+)</a>
        <a href="###">박물류(99+)</a>
    </div>
    <!-- //depth2 -->
</div>
<!-- //slide tab -->


<script type="text/javascript">
function fcnPersonDetail(pPersonId) {
	document.location.href = "/db/per/" + pPersonId;
}
</script>