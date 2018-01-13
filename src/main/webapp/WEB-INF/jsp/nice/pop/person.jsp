<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="contents">

	<form id="form1" name="form1" method="post">
		<input type="hidden" name="m" value="checkplusSerivce"> <!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="${paramMap.sEncData }"> <!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

		<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="${paramMap.param_r1 }"/>
		<input type="hidden" name="param_r2" value="${paramMap.param_r2 }"/>
		<input type="hidden" name="param_r3" value="${paramMap.param_r3}"/>
	</form>
</div>

<script type="text/javascript">
    window.name ="Parent_window";

    $(document).ready(function() {
    	document.form1.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
    	document.form1.submit();
    });

</script>