$(document).ready(function() {
	try {
		$.validator.setDefaults({
			errorElement : 'span'
		    ,errorClass : 'em warning comment-line'
		    ,highlight: function(element, errorClass) {
		    	$(element).removeClass(errorClass);
		    	if($(element).get(0).tagName === "SELECT"){
		    		$(element).parent().parent().removeClass(errorClass);
				}

		    }
			,errorPlacement : function(error, element) {
				try {
					var attrName = element.attr("name");
					var obj = $("#error-" + attrName);
					var id = obj.prop("id");

					if (id != undefined && id != '') {
						error.insertAfter("#error-" + attrName);
					}else {
						error.insertAfter(element);
					}

					if($(element).get(0).tagName === "SELECT"){
						error.insertAfter(element.parent().parent());
					}
				}catch (e) {
					showLog(e);
				}

			}
		});
	}catch (err) {

	}
});

function setCopyProtection(pFlag) {
	if (pFlag == "Y") {
		$(window.document).on("contextmenu", function(event){return false;});   //우클릭방지
	    $(window.document).on("selectstart", function(event){return false;});   //더블클릭을 통한 선택방지
	    $(window.document).on("dragstart"   , function(event){return false;});  //드래그
	}
}

/** kmdb common function * */
/* alert 창 */
function showAlert(pMsg) {
	alert(pMsg);
}

/* confirm 창 */
function showConfirm(pMsg) {
	return confirm(pMsg);
}

/* console.log */
function showLog(param) {
	//console.log(param);
}

/* form submit 처리 */
function formSubmit(pFormId, pAction, pMethod, pTarget) {
	var obj = $("#" + pFormId);

	if (pMethod != undefined && pMethod.isNull() == false) {
		$(obj).prop("method", pMethod);
	} else {
		$(obj).prop("method", "post");
	}

	if (pAction != undefined && pAction.isNull() == false) {
		$(obj).prop("action", pAction);
	}

	if (pTarget != undefined && pTarget.isNull() == false) {
		$(obj).prop("target", pTarget);
	}else {
		$(obj).prop("target", "_self");
	}

	$(obj)[0].submit();
}

function fnHistoryBack() {
	history.back();
}


//아이디 유효성 체크
function fnIsValidId(str){
  var patten = new Array();
  var msg = new Array();
  var p;
  var ret_msg = new Array();

  patten["not_eng_num"] =/^[a-zA-Z0-9]+$/g;  //a-z와 0-9 이외의 문자가 있는지 확인
  msg["not_eng_num"] = "영문/숫자만 사용가능합니다.";
  patten["len"] = /^\w{6,15}$/;	// 문자열 길이
  msg["len"] = "6~15자리로 사용가능합니다.";
  //patten["only_num"] = /[a-zA-Z]/;// 숫자만
  //msg["only_num"] = "영문 대/소문자/숫자의 혼용으로 사용가능합니다(숫자만으로는 사용불가).";
  //patten["only_alpha"] = /[0-9]/; // 영문만
  //msg["only_alpha"] = "영문 대/소문자/숫자의 혼용으로 사용가능합니다(영문 대/소문자만으로 사용불가).";

	 var retVal = checkSpace( str );
	 if( retVal ) {
		 //alert("아이디는 빈 공간 없이 연속된 영문 대/소문자와 숫자만 사용할 수 있습니다.");
		 //return false;
		 return "0|아이디는 빈 공간 없이 연속된 영문 대/소문자와 숫자만 사용할 수 있습니다.";
	 }

	// 패턴 체크
	var i=0;
	for (x in patten)
	{
		p = eval(patten[x]);
		if(!p.test(str))
		{
			ret_msg[i] = msg[x];
			i++;
		}
	}

	if(i>0) {
		//alert("6~15자리의 영문 대소문자,숫자 혼용으로 사용가능합니다.");
		//return false;
		return "0|6~15자리의 영문 대소문자,숫자만 사용 가능합니다."
	}else {
		return "1| ";
	}

}

// 동일ID 체크 포함함
function fnIsValidPasswd(str, chk_id) {

	var patten = new Array();
	var msg = new Array();
	var p;
	var ret_msg = new Array();

	patten["not_eng_num"] = /^[a-zA-Z0-9\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\＼\]\^\_\`\{\|\}\~]{8,20}$/;
	msg["not_eng_num"] = "영문 대/소문자, 숫자, 특수문자의 8~20자리로 사용가능합니다.";
	patten["only_num"] = /[a-zA-Z\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\＼\]\^\_\`\{\|\}\~]/;// 숫자만
	msg["only_num"] = "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3종류 이상 혼용하셔야 합니다(숫자만으로는 사용불가).";
	patten["only_alpha"] = /[0-9\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\＼\]\^\_\`\{\|\}\~]/; // 영문만
	msg["only_alpha"] = "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3종류 이상 혼용하셔야 합니다(영문 대/소문자만으로 사용불가).";
	patten["only_special"] = /[a-zA-Z0-9]/; // 특수문자만
	msg["only_special"] = "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3종류 이상 혼용하셔야 합니다(특수문자만으로 사용불가).";
	patten["same_4"] = /.{4,}/; // 반복문자 4개는 안됨
	msg["same_4"] = "동일한 문자를 4번 이상 사용하실 수 없습니다.";

	patten["except_num"] = /[0-9]/;
	msg["except_num"] = "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3종류 이상 혼용하셔야 합니다(영문 대/소문자, 숫자만으로는 사용불가).";
	patten["except_alpha"] = /[a-zA-Z]/;
	msg["except_alpha"] = "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3종류 이상 혼용하셔야 합니다(숫자, 특수문자만으로 사용불가).";
	patten["except_special"] = /[\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\＼\]\^\_\`\{\|\}\~]/;
	msg["except_special"] = "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 3종류 이상 혼용하셔야 합니다(영문 대/소문자, 숫자만으로 사용불가).";

	var retVal = checkSpace(str);
	if (retVal) {
		//alert("비밀번호는 빈 공간 없이 연속된 영문 대/소문자와 숫자, 특수문자만 사용할 수 있습니다.");
		//return false;
		return "0|비밀번호는 빈 공간 없이 연속된 영문 대/소문자와 숫자, 특수문자만 사용할 수 있습니다.";
	}

	if (!contCheck(str, 4))
		return "0|동일한 문자를 4번 이상 사용하실 수 없습니다.";
	if (checkStrCount(str, 4)) {
		//alert('연속된 숫자나 문자를 4번 이상 사용하실 수 없습니다.');
		//return;
		return "0|연속된 숫자나 문자를 4번 이상 사용하실 수 없습니다.";
	}

	// ID랑 4개 이상 같으면 오류
	if (chk_id.length >= 4) {
		for (var i = 3; i < chk_id.length; i++) {
			if (str.indexOf(chk_id.substring(i - 3, i + 1)) != -1) {
				//alert('ID와 동일한 4자리수 이상 동일한 비밀번호를 사용하실 수 없습니다');
				//return false;
				return "0|ID와 동일한 4자리수 이상 동일한 비밀번호를 사용하실 수 없습니다."
			}
		}
	}

	// 패턴 체크
	var i = 0;
	for (x in patten) {
		p = eval(patten[x]);
		if (!p.test(str)) {
			ret_msg[i] = msg[x];
			i++;
			break;
		}
	}

	if (i > 0) {
		//alert(ret_msg.join('\n'));
		//return false;
		return "0|" + ret_msg.join('\n');
	} else
		//return true;
		return "1| ";
}

function checkSpace(str) {
	if (str.search(/\s/) != -1) {
		return true;
	} else {
		return false;
	}
}

// 동일문자가 이어지면 체크
function contCheck(str, num) {
	var i;
	var cnt = 0;
	for (i = 1; i < str.length; i++) {
		if (str.substring(i - 1, i) == str.substring(i, i + 1)) {
			cnt++;
		} else {
			cnt = 0;
		}
		if (cnt >= num - 1) {
			return false;
		}
	}

	return true;
}

function checkStrCount(value, cnt) {
	var result = false;
	var checkStr = ""; // 같은 반복문자 체크(예: aaaa)
	var checkAsc = ""; // 연속된 오름차순 숫자 혹은 문자(예: abcde)
	var checkDesc = ""; // 연속된 내림차순 숫자 혹은 문자(예: edcba)

	for (var z = 1; z < cnt; z++) {
		checkStr += "value.charAt(i) == value.charAt(i + " + z + ")";
		checkAsc += "(value.charCodeAt(i) + " + z
				+ ") == value.charCodeAt(i + " + z + ")";
		checkDesc += "(value.charCodeAt(i) - " + z
				+ ") == value.charCodeAt(i + " + z + ")";
		if (z < cnt - 1) {
			checkStr += " && ";
			checkAsc += " && ";
			checkDesc += " && ";
		}
	}

	for (var i = 0; i < value.length - 3; i++) {
		if (eval(checkStr) || eval(checkAsc) || eval(checkDesc)) {
			result = true;
		}
	}

	return result;
}

/**
 * input text 필드 empty 체크
 *
 * @param pObjId
 * @param pMsg
 */
function fnEmptyCheck(pObjId, pMsg) {
	var objVal = $("#" + pObjId).val();

	if (objVal.isNull() == true) {
		$("#" + pObjId).focus();
		showAlert(pMsg);
		return false;
	} else {
		return true;
	}
}


/**
 * ajax call
 */
function AjaxCall(){
	this.showMessage = true;
	this.callback="";
    this.params="";
    this.submitUrl="";
    this.async = true;

    AjaxStart=function(_url,_data, _async, _callback){
        var dataset="";
        $.ajaxSetup({
            beforeSend: function(xhr) {
            	var token = $("meta[name='_csrf']").attr("content");
            	var header = $("meta[name='_csrf_header']").attr("content");
                xhr.setRequestHeader(header, token);
            },
            error: function(xhr, status, err) {
                if (xhr.status == 401) {
                	if (showMessage == true) {
                		alert("인증기간이 만료되었습니다.");
                	}

                    location.href="/login";
                    return false;
                } else if (xhr.status == 403) {
                	if (showMessage == true) {
                		alert("요청 페이지가 존재하지 않습니다.");
                	}

                    return false;
                } else {
                	if (showMessage == true) {
                		alert("예외가 발생했습니다. 관리자에게 문의하세요.");
                	}

                    return false;
                }
            }
        });

        if (_async) {
            $.ajax({
                type: "POST",
                url:_url,
                data:_data,
                dataType: 'json',
                async: _async,
                success: function(data) {
              	    if (_callback != "") {
              		    try {
              			   window[_callback](data);
              		    }catch(e) {
              		    	log(e);
              		    }
              	    }
                }
            });
        }else {
            $.ajax({
                type: "POST",
                url:_url,
                data:_data,
                dataType: 'json',
                async: _async,
                success: function(data) {
                	dataset = data;
                }
            });
        }

        return dataset;
    };

    this.submit=function(){
        return AjaxStart(this.submitUrl,this.params, this.async, this.callback);
    };
};


/** string prototype * */
String.prototype.isNull = function() {
	var str = this.trim();
	for (var i = 0; i < str.length; i++) {
		if ((str.charAt(i) != "\t") && (str.charAt(i) != "\n")
				&& (str.charAt(i) != "\r")) {
			return false;
		}
	}
	return true;
}

/**
 * 쿠키 읽기
 * @param name 키
 * @returns
 */
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

/**
 * 쿠키 쓰기
 * @param name  키
 * @param value 값
 * @param days 날짜
 */
function writeCookie(name,value,days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

/**
 * 쿠키 삭제
 * @param name
 */
function deleteCookie(name) {
    createCookie(name,"",-1);
}

function snsCon(g, msg, url, tag, img) {
	if (g=="tw") {
		pstTwitter(msg,url);
	} else if (g=="fb") {
		pstFaceBook(msg,url, tag, img);
	}
}

/*sns 연동 관련*/
function pstTwitter(msg,url) {
	var href = "http://twitter.com/home?status=" + encodeURIComponent(msg) + " " + encodeURIComponent(url);
	var a = window.open(href, 'twitter', 'width=466, height=356');
	if ( a ) {
		a.focus();
	}
}
function pstFaceBook(msg,url, tag, img) {
	var href="";
	href = "http://www.facebook.com/share.php?s=100&p[url]="+ encodeURIComponent(url)
               +"&p[images][0]="+ encodeURIComponent(img)
               +"&p[title]="+ encodeURIComponent(msg)
               +"&p[summary]="+encodeURIComponent(tag);

	var a = window.open(href, 'facebook', 'width=466, height=356');
	if ( a ) {
		a.focus();
	}
}

function fcnLogin(pFormId) {
	if (confirm("로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?") == false) {
		return;
	}

	formSubmit(pFormId, "/login/pre/process");
}

function fcnMovieDetail(pMovieId, pMovieSeq) {
	document.location.href = "/db/kor/detail/movie/" + pMovieId + "/" + pMovieSeq;
}

function fcnPersonDetail(pPersonId) {
	document.location.href = "/db/per/" + pPersonId;
}

function fcnMoviePlayer(pFileNm) {
	window.open('/vod/player/movie?fileNm='+pFileNm, 'moviePlayer');
}

function fcnVodPlayer(pMovieId, pMovieSeq, pFileNm, pMulId, pFileId) {

	$.ajax({
	    url: "/vod/player/check",
		type: 'POST',
		beforeSend : function(xhr) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			xhr.setRequestHeader(header, token);
		},
		data: {"movieId":pMovieId,"movieSeq":pMovieSeq,"mulId":pMulId},
		success: function(data) {
			console.dir(data);
			if(data.result == 'true'){
				if(data.vodPer == 'CT'){ //기업회원 VOD 바로감상가능
					window.open('/vod/player?movieId='+pMovieId+'&movieSeq='+pMovieSeq+'&fileNm='+pFileNm+'&mulId='+pMulId+'&fileId='+pFileId, 'vodPlayer');
				}else if (data.price > 0 && data.vodPer != "T") {//카트에 담고 결제 창 팝업
					fcnVodCartAndPay(data.movieId, data.movieSeq, data.mulId, data.fileId, data.price, data.mulTitle);
				}else {
					if (data.price > 0 && data.vodAdv == "T") {//선불제 회원인 경우
						if (confirm('선불 제회원 입니다. \n같은 영화일 경우 24시간이내 재감상이 가능합니다.\n영화를 관람하시겠습니까?')) {
							fcnVodChargeCheck(data.movieId, data.movieSeq, data.mulId, data.fileId, pFileNm, data.price, data.mulTitle);
						}
					}else{ //무료인 회원 바로 감상가능
						window.open('/vod/player?movieId='+pMovieId+'&movieSeq='+pMovieSeq+'&fileNm='+pFileNm+'&mulId='+pMulId+'&fileId='+pFileId, 'vodPlayer');
					}
				}
				return;
			}else{
				if(data.errorType == '01'){
					fcnLogin('form1');
				}else if(data.errorType == '02'){
					alert("12세 미만 관람불가(중학생가) 등급입니다.\n\n확인 후 관람하시기 바랍니다.");
				}else if(data.errorType == '03'){
					alert("15세 미만 관람불가(고등학생가) 등급입니다.\n\n확인 후 관람하시기 바랍니다.");
				}else if(data.errorType == '04'){
					alert("18세 미만(연소자) 관람불가 등급입니다.\n\n확인 후 관람하시기 바랍니다.");
				}else{
					alert("플레이어 재생 실패...");
				}
				return false;
			}
        }
	});
}

function fcnVodCartAndPay(pMovieId, pMovieSeq, pMulId, pFileId, price, movieTitle){
	$.ajax({
	    url: "/vod/add/cart",
		type: 'POST',
		beforeSend : function(xhr) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			xhr.setRequestHeader(header, token);
		},
		data: {"movieId":pMovieId,"movieSeq":pMovieSeq,"mulId":pMulId,"fileId":pFileId,"price":price,"movieTitle":movieTitle},
		success: function(data) {
			if(data.result == 'true'){
				//결제창 오픈
				win_ = window.open('/care/vod/pay/pop?movieId='+pMovieId+"&movieSeq="+pMovieSeq, 'KMDbPAY', 'width=500px,height=700px,resizable=yes');
				win_.focus();
			}else{
				alert("에러입니다. 관리자에게 문의 하세요");
				return false;
			}
        }
	});

	return;
}

function fcnVodChargeCheck(pMovieId, pMovieSeq, pMulId, pFileId, pFileNm, price, movieTitle){
	$.ajax({
	    url: "/vod/charge/check",
		type: 'POST',
		beforeSend : function(xhr) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			xhr.setRequestHeader(header, token);
		},
		data: {"movieId":pMovieId,"movieSeq":pMovieSeq,"mulId":pMulId,"fileId":pFileId,"price":price,"movieTitle":movieTitle},
		success: function(data) {
			console.dir(data);
			if(data.result == 'true'){
				alert(data.msg);
				window.open('/vod/player?movieId='+pMovieId+'&movieSeq='+pMovieSeq+'&fileNm='+pFileNm+'&pMulId='+pMulId, 'vodPlayer');
			}else{
				if(data.errorType == '01'){
					fcnLogin('form1');
				}else{
					alert(data.msg);
				}
				return false;
			}
        }
	});

	return;
}