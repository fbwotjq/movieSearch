<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/member.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="#">홈</a></li>
			<li class="located"><a href="#">회원가입</a></li>
		</ul>
	</div>
	<div class="container foreigner">
		<div class="top-area">
			<div class="prev-page">
				<a href="#"><i class="ico-prev"></i><span>이전</span></a>
			</div>
			<h2>회원가입</h2>
		</div>
		<div class="regi-menu">
			<ul>
				<li class="selected"><a href="MB0401.html"><span>Step1</span><span>약관동의</span></a></li>
				<li><a href="MB0402.html"><span>Step2</span><span>정보입력</span></a></li>
				<li><a href="MB0403.html"><span>Step3</span><span>가입신청완료</span></a></li>
			</ul>
		</div>
		<form>
			<fieldset>
				<legend>인증 선택 영역</legend>
				<div class="parents-agree foreigner-agree">
					<div class="area">
						<div class="box-fold-list">
							<div class="accordion-wrap on">
								<div class="accordion-header">
									<a href="javascript:void(0);" class="accordion-title collapse-handle"><span>외국인 회원가입 담당자 승인 단계 필요<span class="em weighty">(필수)</span></span> <i class="ico-handle"></i></a>
									<div class="agree-box">
										<label><input type="checkbox" name="" id=""> <span class="label">법정대리임을 확인합니다.</span></label>
									</div>
								</div>
								<div class="accordion-content">
									<p>
										재외동포(외국인)을 통해 가입신청 하신 경우, 신분확인이 가능한 서류 사본 1건(신분증, 운전 면허증, 여권사본, 외국인등록증 등)을 팩스(fax 02-3153-2080) 또는 운영자메일(<a href="mailto:kofa@koreafilm.or.kr">kofa@koreafilm.or.kr</a>)로 보내주셔야 담당자 확인 후가입처리가 완료 됩니다.
									</p>
									<ul>
										<li>※서류를 보내실 땐 가입 신청 시 입력하신 아이디와 이름을 꼭 적어 주세요.</li>
										<li>※승인을 통해 처리 됨으로 며칠이 소요 될 수 있습니다.</li>
										<li>※정확한 정보 입력하지 않으면 반려 될 수 있습니다.</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="agreeterm">
					<div class="agreeterm-agree">
						<div class="selector-wrap">
							<div class="asset">
								<label><div class="checker">
										<span><input type="checkbox" name="" id=""></span>
									</div> <span class="label">한국영상자료원/KMDb회원약관, 개인정보 수집 및 이용 안내에 모두 동의합니다.</span></label>
							</div>
						</div>
					</div>
					<div class="agreeterm-terms">
						<h3>한국영상자료원/KMDb회원약관</h3>
						<div class="agreeterm-terms-box mCustomScrollbar">
							<div class="term-content" data-mcs-theme="dark">
								<h4>제 1장 총칙</h4>
								<dl>
									<dt class="first">제 1 조 [목적]</dt>
									<dd>본 약관은 한국영상자료원(이하 "자료원")의 기관 홈페이지와 KMDb한국영화데이터베이스서비스(이하 "KMDb")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</dd>

									<dt>제 2 조 [약관의 명시와 개정]</dt>
									<dd>1. 당 사이트는 이 약관의 내용과 주소지, 관리자의 성명, 개인정보보호 담당자의 성명, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 당 사이트의 초기 서비스화면(전면)에 게시합니다.</dd>
									<dd>2. 당 사이트는 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진및정보보호이용등에관한법률, 방문판매등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</dd>
									<dd>3. 당 사이트가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 당 사이트의 초기화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다.</dd>
									<dd>4. 당 사이트는 귀하가 본 약관 내용에 동의하는 것을 조건으로 귀하에게 서비스를 제공할 것이며, 귀하가 본 약관의 내용에 동의하는 경우, 당 사이트의 서비스 제공 행위 및 귀하의 서비스 사용 행위에는 본 약관이 우선적으로 적용될 것입니다.</dd>
									<dd>5. 이 약관에 동의하는 것은 정기적으로 웹을 방문하여 약관의 변경사항을 확인하는 것에 동의함을 의미합니다. 변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 당 사이트에서 책임지지 않습니다.</dd>
									<dd>6. 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.</dd>
									<dd>7. 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.</dd>

									<dt>제 3 조 [용어의 정의]</dt>
									<dd>
										본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
										<ul>
											<li>1. 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 받는 자.</li>
											<li>2. 이용계약 : 서비스 이용과 관련하여 당 사이트와 이용자간에 체결하는 계약을 말합니다.</li>
											<li>3. 가 입 : 당 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위</li>
											<li>4. 회 원 : 당 사이트에 회원가입에 필요한 개인 정보를 제공하여 회원 등록을 한 자로서, 당 사이트의 정보 및 서비스를 이용할 수 있는 자</li>
											<li>5. 이용자아이디(ID) : 이용고객의 식별과 이용자가 서비스 이용을 위하여 이용자가 선정하고 당 사이트가 부여하는 문자와 숫자의 조합을 말합니다.</li>
											<li>6. 비밀번호(PW) : 이용자가 등록회원과 동일인인지 신원을 확인하고 통신상의 자신의 개인정보보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합</li>
											<li>7. 탈퇴(해지) : 회원이 이용계약을 종료시키는 행위</li>
											<li>8. 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도약관 및 이용규정에서 정의합니다.</li>
										</ul>
									</dd>
								</dl>

								<h4>제 2 장 이용계약의 성립 및 해지</h4>
								<dl>
									<dt>제 4조 [이용 계약의 성립]</dt>
									<dd>1. 이용계약은 이용자가 본 이용약관 내용에 대한 동의와 이용신청에 대하여 당 사이트의 이용승낙으로 성립합니다.</dd>
									<dd>2. 본 이용약관에 대한 동의는 이용신청 당시 해당 당 사이트의 '동의' 버튼을 누름으로써 의사표시를 합니다.</dd>

									<dt>제 5 조 [회원가입 및 탈퇴]</dt>
									<dd>1. 회원가입은 신청자가 온라인으로 당 사이트에서 제공하는 소정의 가입신청 양식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립됩니다.</dd>
									<dd>
										2. 당 사이트는 다음 각 호에 해당하는 회원가입에 대하여는 가입을 취소할 수 있습니다.
										<ul>
											<li>1) 실명이 아니거나 다른 사람의 명의를 사용하여 신청하였을 때</li>
											<li>2) 회원가입 신청서의 내용을 허위로 기재하였거나 신청하였을 때</li>
											<li>3) 사회의 안녕 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때</li>
											<li>4) 다른 사람의 당 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때</li>
											<li>5) 당 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우</li>
											<li>6) 기타 당 사이트가 정한 회원가입요건이 미비 되었을 때</li>
										</ul>
									</dd>
									<dd>
										3. 당 사이트는 다음 각 항에 해당하는 경우 그 사유가 해소될 때까지 이용계약 성립을 유보할 수 있습니다.
										<ul>
											<li>1) 서비스 관련 제반 용량이 부족한 경우</li>
											<li>2) 기술상 장애 사유가 있는 경우</li>
										</ul>
									</dd>
									<dd>
										4. 당 사이트가 제공하는 서비스는 아래와 같으며, 그 변경될 서비스의 내용을 이용자에게 공지하고 아래에서 정한 서비스를 변경하여 제공할 수 있습니다.
										<ul>
											<li>1) 당 사이트가 자체 개발하거나 다른 기관 및 단체와의 협의 등을 통해 제공하는 일체의 서비스</li>
										</ul>
									</dd>
									<dd>5. 회원은 등록사항에 변경이 있는 경우, 즉시 회원정보 수정 등 기타 방법으로 당 사이트에 대하여 그 변경사항을 알려야 합니다.</dd>
									<dd>6. 회원가입이후 당 사이트에서 제공하는 서비스를 제공받을 의사가 없는 등의 사유가 있을 경우에는 언제든지 회원탈퇴(해지)를 할 수 있습니다.</dd>

									<dt>제 6 조 [이용자ID 부여 및 변경 등]</dt>
									<dd>1. 당 사이트는 이용고객에 대하여 약관에 정하는 바에 따라 이용자 ID를 부여합니다.</dd>
									<dd>2. 이용자ID는 원칙적으로 변경이 불가하며 부득이한 사유로 인하여 변경 하고자 하는 경우에는 해당 ID를 해지하고 재가입해야 합니다. (확인필요)</dd>
									<dd>
										3. 이용자ID는 다음 각 호에 해당하는 경우에는 이용고객 또는 회사의 요청으로 변경할 수 있습니다.
										<ul>
											<li>1) 이용자ID가 이용자의 전화번호 또는 주민등록번호 등으로 등록되어 사생활침해가 우려되는 경우</li>
											<li>2) 타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우</li>
											<li>3) 기타 합리적인 사유가 있는 경우</li>
										</ul>
									</dd>
									<dd>4. 서비스 이용자ID 및 비밀번호의 관리책임은 이용자에게 있습니다. 이를 소홀히 관리하여 발생하는 서비스 이용상의 손해 또는 제3자에 의한 부정이용 등에 대한 책임은 이용자에게 있으며 당 사이트는 그에 대한 책임을 일절 지지 않습니다.</dd>
									<dd>5 . 기타 이용자 개인정보 관리 및 변경 등에 관한 사항은 당 사이트가 정하는 바에 의합니다.</dd>

									<dt>제 7 조 [회원정보 사용에 대한 동의]</dt>
									<dd>1. 귀하의 개인정보에 대해서는 당 사이트의 개인정보 보호정책이 적용됩니다.</dd>
									<dd>
										2. 당 사이트의 회원 정보는 다음과 같이 수집, 사용, 관리, 보호됩니다.
										<ul>
											<li>1) 개인정보의 수집 : 당 사이트는 귀하의 당 사이트 서비스 가입시 귀하가 제공하는 정보를 통하여 귀하의 정보를 수집합니다.</li>
											<li>2) 개인정보의 사용 : 당 사이트는 당 사이트 서비스 제공과 관련해서 수집된 귀하의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다. 단, 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 귀하가 당 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그러하지 않습니다.</li>
											<li>3) 개인정보의 관리 : 귀하는 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 귀하의 개인정보를 수정/삭제할 수 있습니다. 수신되는 정보 중 불필요하다고 생각되는 부분도 변경/조정할 수 있습니다.</li>
											<li>4) 개인정보의 보호 : 귀하의 개인정보는 오직 귀하만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 귀하의 ID와 비밀번호에 의해 관리되고 있습니다. 따라서 타인에게 귀하의 ID와 비밀번호를 알려주어서는 아니되며, 작업 종료시에는 반드시 로그아웃 하고, 웹 브라우저의 창을 닫아야 합니다.(이는 타인과 컴퓨터를 공유하는 인터넷 카페나 도서관 같은 공공장소에서 컴퓨터를 사용하는 경우에 귀하의 정보보호를 위하여 필요한 사항입니다)</li>
										</ul>
									</dd>
									<dd>3. 귀하가 당 사이트에 본 약관에 따라 이용신청을 하는 것은 당 사이트가 본 약관에 따라 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주됩니다.</dd>

									<dt>제 8 조 [사용자의 정보 보안]</dt>
									<dd>1. 귀하가 당 사이트 서비스 가입 절차를 완료하는 순간부터 귀하는 입력한 정보의 비밀을 유지할 책임이 있으며, ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 귀하에게 있습니다.</dd>
									<dd>2. ID와 비밀번호에 관한 모든 관리의 책임은 귀하에게 있으며, 귀하의 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 당 사이트에 신고하여야 합니다. 신고를 하지 않음으로 인해 발생하는 모든 책임은 회원 본인에게 있습니다.</dd>
									<dd>3. 이용자는 당 사이트 서비스의 사용 종료시 마다 정확히 로그아웃(Log-out)해야 하며, 로그아웃하지 아니하여 제3자가 귀하에 관한 정보를 도용하는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 당 사이트는 책임을 부담하지 아니합니다.</dd>
								</dl>

								<h4>제 3 장 서비스의 이용</h4>
								<dl>
									<dt>제 9 조 [서비스 이용시간]</dt>
									<dd>1. 서비스 이용시간은 당 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.</dd>
									<dd>2. 제1항의 이용시간 중 정기점검 등의 필요로 인하여 당 사이트가 정한 날 또는 시간은 예외로 합니다.</dd>

									<dt>제 10 조 [서비스의 중지 및 중지에 대한 공지]</dt>
									<dd>1. 귀하는 당 사이트 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 당 사이트의 관리 범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 당 사이트는 관련 책임을 부담하지 아니합니다.</dd>
									<dd>2. 당 사이트가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일 전에 홈페이지에 서비스 중지사유 및 일시를 공지한 후 서비스를 중지할 수 있으며, 이 기간 동안 귀하가 공지내용을 인지하지 못한 데 대하여 당 사이트는 책임을 부담하지 아니합니다. 부득이한 사정이 있을 경우 위 사전 공지기간은 감축되거나 생략될 수 있습니다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 당 사이트는 책임을 부담하지 아니합니다.</dd>
									<dd>3. 당 사이트의 사정으로 서비스를 영구적으로 중단하여야 할 경우에는 제 2 항에 의거합니다. 다만, 이 경우 사전 공지기간은 1개월로 합니다.</dd>
									<dd>4. 당 사이트는 사전 공지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 귀하 또는 제3자에게 어떠한 책임도 부담하지 아니합니다.</dd>
									<dd>5. 당 사이트는 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 당 사이트가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.</dd>
									<dd>6. 당 사이트는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다. 다만 이 경우 그 사유 및 기간 등을 이용자에게 사전 또는 사후에 공지합니다.</dd>
									<dd>7. 당 사이트는 당 사이트가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의·과실없는 디스크장애, 시스템다운 등) 에 사전통지가 불가능하며 타인(PC통신회사, 기간통신사업자 등)의 고의·과실로 인한 시스템중단 등의 경우에는 통지하지 않습니다.</dd>
									<dd>8. 당 사이트는 서비스를 특정범위로 분할하여 각 범위별로 이용가능시간을 별도로 지정할 수 있습니다. 다만 이 경우 그 내용을 공지합니다.</dd>
									<dd>9. 당 사이트는 귀하가 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지하거나 귀하의 동의없이 이용계약을 해지할 수 있습니다. 이 경우 당 사이트는 위 이용자의 접속을 금지할 수 있습니다.</dd>

									<dt>제 11 조 [정보 제공 및 홍보물 게재]</dt>
									<dd>1. 당 사이트는 서비스를 운영함에 있어서 각종 정보를 홈페이지에 게재하는 방법, 전자우편이나 서신우편 발송 등으로 귀하에게 제공할 수 있습니다.</dd>
									<dd>2. 당 사이트는 서비스에 적절하다고 판단되거나 공익성이 있는 홍보물을 게재할 수 있습니다.</dd>

									<dt>제 12 조 [당 사이트 게시물의 관리·운영]</dt>
									<dd>1. 귀하가 게시한 게시물의 내용에 대한 권리는 귀하에게 있습니다.</dd>
									<dd>
										2. 당 사이트는 게시된 내용을 사전 통지 없이 편집, 이동할 수 있는 권리를 보유하며, 다음의 경우 사전 통지 없이 삭제할 수 있습니다.
										<ul>
											<li>1) 본 서비스 약관에 위배되거나 상용 또는 불법, 음란, 저속하다고 판단되는 게시물을 게시한 경우</li>
											<li>2) 다른 회원 또는 제 3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우</li>
											<li>3) 공공질서 및 미풍양속에 위반되는 내용인 경우</li>
											<li>4) 범죄적 행위에 결부된다고 인정되는 내용일 경우</li>
											<li>5) 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
											<li>6) 기타 관계 법령에 위배되는 경우</li>
										</ul>
									</dd>
									<dd>3. 귀하의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 귀하가 부담하여야 합니다.</dd>

									<dt>제 13 조 [서비스 이용제한]</dt>
									<dd>1. 귀하가 제공하는 정보의 내용이 허위인 것으로 판명되거나, 허위가 있다고 의심할 만한 합리적인 사유가 발생할 경우 당 사이트는 귀하의 본 서비스 사용을 일부 또는 전부 중지할 수 있으며, 이로 인해 발생하는 불이익에 대해 책임을 부담하지 아니합니다.</dd>
									<dd>2. 당 사이트는 귀하가 본 약관 제15조(회원의 의무)등 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있습니다. 이 경우 당 사이트는 귀하의 접속을 금지할 수 있습니다.</dd>
								</dl>

								<h4>제 4 장 의무 및 책임</h4>
								<dl>
									<dt>제 14 조 [당 사이트의 의무]</dt>
									<dd>1. 당 사이트는 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 지속적·안정적으로 서비스를 제공하기 위해 노력할 의무가 있습니다.</dd>
									<dd>2. 당 사이트는 회원의 개인 신상 정보를 본인의 승낙 없이 타인에게 누설, 배포하지 않습니다. 다만, 전기통신관련법령 등 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그러하지 아니합니다.</dd>
									<dd>3. 당 사이트는 이용자가 안전하게 당 사이트서비스를 이용할 수 있도록 이용자의 개인정보 (신용정보 포함) 보호를 위한 보안시스템을 갖추어야 합니다.</dd>
									<dd>4. 당 사이트는 이용자의 귀책사유로 인한 서비스 이용 장애에 대하여 책임을 지지 않습니다.</dd>

									<dt>제 15 조 [회원의 의무]</dt>
									<dd>1. 회원 가입시에 요구되는 정보는 정확하게 기입하여야 합니다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 ID 및 비밀번호를 제3자가 이용하게 해서는 안됩니다.</dd>
									<dd>2. 회원은 당 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.</dd>
									<dd>3. 회원은 당 사이트 서비스를 이용하여 얻은 정보를 당 사이트의 사전승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없습니다.</dd>
									<dd>
										4. 회원은 당 사이트 서비스 이용과 관련하여 다음 각 호의 행위를 하여서는 안됩니다.
										<ul>
											<li>1) 다른 회원의 비밀번호와 ID를 도용하여 부정 사용하는 행위</li>
											<li>2) 저속, 음란, 모욕적, 위협적이거나 타인의 Privacy를 침해할 수 있는 내용을 전송, 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
											<li>3) 서비스를 통하여 전송된 내용의 출처를 위장하는 행위</li>
											<li>4) 법률, 계약에 의해 이용할 수 없는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
											<li>5) 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
											<li>6) 당 사이트의 승인을 받지 아니한 광고, 판촉물, 스팸메일, 행운의 편지, 피라미드 조직 기타 다른 형태의 권유를 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
											<li>7) 다른 사용자의 개인정보를 수집 또는 저장하는 행위</li>
											<li>8) 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위</li>
											<li>9) 선량한 풍속, 기타 사회질서를 해하는 행위</li>
											<li>10) 타인의 명예를 훼손하거나 모욕하는 행위</li>
											<li>11) 타인의 지적재산권 등의 권리를 침해하는 행위</li>
											<li>12) 해킹행위 또는 컴퓨터바이러스의 유포행위</li>
											<li>13) 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위</li>
											<li>14) 서비스의 안전적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위</li>
											<li>15) 당 사이트에 게시된 정보의 변경.</li>
											<li>16) 기타 전기통신사업법 제53조 제1항과 전기통신사업법 시행령 16조(불온통신)에 위배되는 행위</li>
										</ul>
									</dd>
								</dl>

								<h4>제 5 장 기 타</h4>
								<dl>
									<dt>제 16 조 [당 사이트의 소유권]</dt>
									<dd>1. 당 사이트가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는 당 사이트에 소유권이 있습니다.</dd>
									<dd>2. 귀하는 당 사이트가 명시적으로 승인한 경우를 제외하고는 전항의 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권 설정 행위, 상업적 이용 행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</dd>

									<dt>제 17 조 [양도금지]</dt>
									<dd>회원이 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.</dd>

									<dt>제 18 조 [손해배상]</dt>
									<dd>당 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 당 사이트가 고의로 행한 범죄행위를 제외하고는 이에 대하여 책임을 부담하지 아니합니다.</dd>

									<dt>제 19 조 [면책조항]</dt>
									<dd>1. 당 사이트는 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제됩니다.</dd>
									<dd>2. 당 사이트는 기간통신 사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제됩니다.</dd>
									<dd>3. 당 사이트는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제됩니다.</dd>
									<dd>4. 당 사이트는 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않습니다.</dd>
									<dd>5. 당 사이트는 서비스에 표출된 어떠한 의견이나 정보에 대해 확신이나 대표할 의무가 없으며 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않습니다. 당 사이트는 어떠한 경우라도 귀하가 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다.</dd>
									<dd>6. 당 사이트는 회원간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 부담하지 아니하고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.</dd>
									<dd>7. 당 사이트는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도 등 내용에 관하여는 책임을 지지 않습니다.</dd>
									<dd>8. 당 사이트는 서비스 이용과 관련하여 귀하에게 발생한 손해 중 귀하의 고의, 과실에 의한 손해에 대하여 책임을 부담하지 아니합니다.</dd>
									<dd>9 . 당 사이트는 당 사이트가 제공한 서비스가 아닌 가입자 또는 기타 유관기관이 제공하는 서비스의 내용상의 정확성, 완전성 및 질에 대하여 보장하지 않습니다. 따라서 당 사이트는 귀하가 위 내용을 이용함으로 인하여 입게 된 모든 종류의 손실이나 손해에 대하여 책임을 부담하지 아니합니다. 또한 당 사이트는 이용자가 서비스를 이용하며 타 이용자로 인해 입게 되는 정신적 피해에 대하여 보상할 책임을 지지 않습니다.</dd>

									<dt>제 20 조 [관할법원]</dt>
									<dd>본 서비스 이용과 관련하여 발생한 분쟁에 대해 소송이 제기될 경우 서울지방법원 본원을 전속적 관할 법원으로 합니다.</dd>

									<dt>부 칙</dt>
									<dd>1. (시행일) 본 약관은 2006년 2월 1일부터 시행됩니다.</dd>
								</dl>
							</div>
						</div>
						<div class="selector-wrap horizontal">
							<div class="asset">
								<label><div class="radio">
										<span><input type="radio" name="radio1" id=""></span>
									</div> <span class="label">동의합니다.</span></label>
							</div>
							<div class="asset">
								<label><div class="radio">
										<span><input type="radio" name="radio1" id=""></span>
									</div> <span class="label">동의하지 않습니다.</span></label>
							</div>
						</div>
					</div>
					<div class="agreeterm-terms member-priacy">
						<h3>개인정보 수집 및 이용 안내</h3>
						<div class="agreeterm-terms-box mCustomScrollbar">
							<div class="term-content" data-mcs-theme="dark">
								<dl>
									<dt>1.개인정보의 수집 및 이용 목적</dt>
									<dd>가. 서비스 이용에 따른 본인식별 및 실명인증, 가입의사 확인, 연령제한 서비스(VOD) 이용</dd>
									<dd>나. 기관정보 안내를 위한 뉴스레터 발송 정보 확보</dd>
									<dd>다. 유료정보 이용에 대한 요금결제</dd>
									<dd>라. 접속빈도 파악, 회원의 서비스 이용에 대한 통계 집계, 이벤트 참여 기회 제공</dd>
								</dl>

								<dl>
									<dt>2.수집하는 개인정보의 항목</dt>
									<dd>
										가. 회원가입 과정에서 아래와 같은 정보가 수집됩니다.
										<ul>
											<li>1. 필수항목 : 이름, 생년월일, 아이디, 비밀번호, 이메일, 메일링 수신여부</li>
											<li>2. 선택항목 : 연락처(전화번호, 휴대폰 번호) 중 하나 이상 입력</li>
										</ul>
									</dd>
									<dd>
										나. 서비스 이용과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
										<ul>
											<li>1. 쿠키, 방문 일시, 서비스 이용 기록</li>
										</ul>
									</dd>
									<dd>
										다. 유료 서비스 이용 과정에서 아래와 같은 결제 정보들이 수집될 수 있습니다.
										<ul>
											<li>1. 신용카드 결제 시 : 카드사명, 카드번호 등</li>
											<li>2. 휴대전화 결제 시 : 이동전화번호, 통신사, 결제승인번호 등</li>
											<li>3. 계좌이체 시 : 은행명, 계좌번호 등</li>
										</ul>
									</dd>
								</dl>

								<dl>
									<dt>3.개인정보의 보유 및 이용기간</dt>
									<dd>가. 홈페이지 회원 가입 및 관리 : 2년</dd>
									<dd>
										나. 다만, 전자상거래에서의 소비자보호에 관한 법률 등 타법률에 의해 보존할 필요가 있는 경우에는 일정기간 보존합니다.
										<ul>
											<li>1. 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률</li>
											<li>2. 보존 기간 : 5년</li>
											<li>3. 관계 법령 위반에 따른 수사·조사 등이 진행중인 경우에는 해당 수사·조사 종료시까지</li>
										</ul>
									</dd>
								</dl>

								<dl>
									<dt>4. 동의 거부 권리 사실 및 불이익 내용</dt>
									<dd>가. 홈페이지 회원가입에 본인의 개인정보 수집 및 이용을 원치 않으실 경우 본 동의를 거절하실 수 있습니다. 동의를 거절하실 경우에는 홈페이지 글쓰기, VOD 영화감상(연령제한확인)등 이 제한됨을 알려드립니다.</dd>
								</dl>
							</div>
						</div>
						<div class="selector-wrap horizontal">
							<div class="asset">
								<label><div class="radio">
										<span><input type="radio" name="radio2" id=""></span>
									</div> <span class="label">동의합니다.</span></label>
							</div>
							<div class="asset">
								<label><div class="radio">
										<span><input type="radio" name="radio2" id=""></span>
									</div> <span class="label">동의하지 않습니다.</span></label>
							</div>
						</div>
					</div>
					<div class="btn-next btn-group large">
						<button class="btn large weighty" disabled="">다음</button>
					</div>
				</div>

			</fieldset>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		//$("#wrap").addClass("findid");

		$(".term-content").mCustomScrollbar();
	});
</script>