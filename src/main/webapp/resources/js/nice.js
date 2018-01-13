/* nice 안심 인증 */
function fnCheckPerson(formId) {
	var popFlag = true;

	if (formId != undefined) {
		if ($('#' + formId).valid() == false) {
			$("#" + formId).validate().focusInvalid();

			popFlag = false;
		}
	}

	if (popFlag) {
		var frm = document.niceForm;
		isOpen = window.open('', 'authNice', 'width=400px,height=500px;');
		frm.target = "authNice";
		frm.action = "/nice/person";
		frm.submit();
	}
}

/* nice ipin 인증 */
function fnCheckIpin(formId) {
	var popFlag = true;

	if (formId != undefined) {
		if ($('#' + formId).valid() == false) {
			$("#" + formId).validate().focusInvalid();

			popFlag = false;
		}
	}


	if (popFlag) {
		var frm = document.niceForm;
		isOpen = window.open('', 'authNice', 'width=400px,height=500px;');
		frm.target = "authNice";
		frm.action = "/nice/iPin";
		frm.submit();
	}

}