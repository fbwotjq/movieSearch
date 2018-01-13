<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
    <div class="breadcrumb">
        <ul>
            <li class="ico-home"><a href="<c:out value='/main'/>">홈</a></li>
            <li><a href="<c:out value='/login'/>">로그인</a></li>
            <li class="located"><a href="<c:out value='/member/findId'/>">아이디 찾기</a></li>
        </ul>
    </div>
    <div class="container">
        <div class="top-area">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
            <h2>아이디 찾기</h2>
        </div>
        <div class="forgetten-p">
            <p>
                이메일 인증<span>아래정보를 입력해주세요 </span>
            </p>
        </div>
        <form id="form1" name="form1" method="post">
            <sec:csrfInput/>
            <input type="hidden" id="findType" name="findType" value="EMAIL">
            <fieldset class="fieldset">
                <legend>이메일 인증영역</legend>
                <section>
                    <div class="area">
                        <div class="field">
                            <div class="label">
                                <label for="userName">이름</label>
                            </div>
                            <div class="insert">
                                <div class="insert-multi with-radio">
                                    <div class="box">
                                        <input type="text" id="userName" name="userName">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="field">
                            <div class="label">
                                <label for="mailId">이메일</label>
                            </div>
                            <div class="insert">
                                <div class="insert-multi with-email">
                                    <div class="box">
                                        <input type="text" id="mailId" name="mailId" placeholder="이메일">
                                    </div>
                                    <div class="box at-box">@</div>
                                    <div class="box select-box">
                                        <select id="selMailDomain" name="selMailDomain" class="select-tric">
                                            <option value="">직접입력</option>
                                            <option value="naver.com">naver.com</option>
                                            <option value="gmail.com">gmail.com</option>
                                            <option value="hanmail.net">hanmail.net</option>
                                            <option value="nate.com">nate.com</option>
                                        </select>
                                    </div>
                                </div>
                                <input type="text" id="mailDomain" name="mailDomain" placeholder="이메일 도메인">
                            </div>
                        </div>
                        <input class="btn large weighty" type="submit" value="확인">
                    </div>
                </section>
            </fieldset>
        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        //design
        $("#body").addClass("login");
        $("#wrap").addClass("confirm-mail");

        $("#selMailDomain").bind("change", function() {
            var mailDomain = $("#selMailDomain option:selected").val();

            if (mailDomain.isNull() == true) {
                $("#mailDomain").focus();
            }else {
                $("#mailDomain").val(mailDomain);
            }
        });


        $("#form1").validate({
            submitHandler: function(form) {
                formSubmit("form1", "<c:url value='/member/findId/result'/>");
            }
            ,rules: {
                userName: { required: true }
               ,mailId: { required: true }
               ,mailDomain: { required: true }
            }
            ,messages: {
                userName: { required: "이름을 입력하세요." }
               ,mailId: { required: "메일 아이디를 입력하세요." }
               ,mailDomain: { required: "메일 도메인을 입력하세요." }
            }
        });
    });
</script>