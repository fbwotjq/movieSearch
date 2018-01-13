<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer id="footer">
	<div class="footer-wrap">
		<div class="foot-logo mobile-dpnone">
			<a href="#"><img src="/resources/images/common/foot-logo01.png" alt="한국영화데이터베이스"></a> <a href="#"><img src="/resources/images/common/foot-logo02.png" alt="한국영상자료원"></a>
		</div>
		<div class="foot-menu">
			<ul>
				<li><a href="https://www.koreafilm.or.kr/privacy">개인정보처리방침</a></li>
				<li><a href="#">저작권정책</a></li>
				<li class="mobile-dpnone"><a href="/care/online/ask">1:1문의</a></li>
				<li class="mobile-dpnone"><a href="/care/online/movieman">영화인정보등록</a></li>
				<li class="mobile-dpnone"><a href="/care/online/ask?privateType=02">DB오류신고</a></li>
				<li class="mobile-dpnone"><a href="/sitemap">사이트맵</a></li>
			</ul>
		</div>
		<div class="foot-address">
			<p>서울시 마포구 월드컵북로 400 한국영상자료원 (우 03925)</p>
			<p class="tel">
				<span class="dot"><b>T.</b> 02-3153-2001</span> <span><b>F.</b> 02-3153-2080</span>
			</p>
			<p class="sns">
				<a href="https://www.facebook.com" class="sns-facebook">facebook</a> <a href="https://twitter.com/?lang=ko" class="sns-twitter">twitter</a>
			</p>
			<p class="copyright">
				<span>ⓒ 2006~2016 Korean Film Archive.</span><span> ALL Rights Reserved</span>
			</p>
		</div>
	</div>
</footer>
<div class="btntop">
	<button type="button" id="TopMove" title="상단으로">
		<span class="ico_totop">상단으로</span>
	</button>
</div>
<!-- 메인화면 설정 팝업(s) -->
<div class="popwrap poptype1" id="mainSetup">
	<h3 class="poptit1">초기화면 설정</h3>
	<div class="pop_container1">
		<form class="main_setarea">
			<fieldset>
				<legend>초기화면 설정</legend>
				<div class="asset">
					<label for="mainSet_main"><div class="radio"><span><input type="radio" name="mainSetRadio" id="mainSet_main" value="main" /></span></div> <span class="label">검색</span></label>
				</div>
				<div class="asset">
					<label for="mainSet_db"><div class="radio"><span><input type="radio" name="mainSetRadio" id="mainSet_db" value="db" /></span></div> <span class="label">DB</span></label>
				</div>
				<div class="asset">
					<label for="mainSet_story"><div class="radio"><span><input type="radio" name="mainSetRadio" id="mainSet_story" value="story" /></span></div> <span class="label">영화글</span></label>
				</div>
				<div class="asset">
					<label for="mainSet_vod"><div class="radio"><span><input type="radio" name="mainSetRadio" id="mainSet_vod" value="vod" /></span></div> <span class="label">VOD</span></label>
				</div>
				<div class="asset">
					<label for="mainSet_history"><div class="radio"><span><input type="radio" name="mainSetRadio" id="mainSet_history" value="history" /></span></div> <span class="label">한국영화사료관</span></label>
				</div>
				<div class="btn-group large">
					<button class="btn large weighty" id="mainSetupBtn" type="button">저장</button>
				</div>
			</fieldset>
		</form>
	</div>
	<div class="pop_setclose">
		<button type="button" class="b-close"><div class="ico">닫기</div></button>
	</div>
</div>
<!--// 메인화면 설정 팝업(e) -->