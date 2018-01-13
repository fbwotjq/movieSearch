$.fnAjax = function(pOptions) {
	var defaultOptions = {
		showMessage : true,
		async : true,
		params : ""
	};

	$.extend(defaultOptions, defaultOptions, pOptions);
	var options = defaultOptions;

	if (options.url == undefined) {
		showLog("SUBMIT URL IS UNDEFINED ");
		return;
	}

	if (options.async == true && options.callback == undefined) {
		showLog("CALLBACK IS UNDEFINED ");
		return;
	}

	$.ajaxSetup({
		beforeSend : function(xhr) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			xhr.setRequestHeader(header, token);
		},
		error : function(xhr, status, err) {
			$('#wrap').spin(false);
			if (xhr.status == 401) {
				if (options.showMessage == true) {
					showAlert("인증기간이 만료되었습니다.");
				}

				return false;
			} else if (xhr.status == 403) {
				if (options.showMessage == true) {
					showAlert("요청 페이지가 존재하지 않습니다.");
				}

				return false;
			} else {
				if (options.showMessage == true) {
					showAlert("예외가 발생했습니다. 관리자에게 문의하세요.");
				}

				return false;
			}
		}
	});

	var response = "";
	$('#wrap').spin();
	if (options.async) {
		$.ajax({
			type : "POST",
			url : options.url,
			data : options.params,
			dataType : 'json',
			async : options.async,
			success : function(data) {
				$('#wrap').spin(false);
				if (options.callback != "") {
					try {
						window[options.callback](data);
					} catch (e) {
						showLog(e);
					}
				}
			}
		});
	} else {
		$.ajax({
			type : "POST",
			url : options.url,
			data : options.params,
			dataType : 'json',
			async : options.async,
			success : function(data) {
				$('#wrap').spin(false);
				response = data;
			}
		});
	}

	return response;
};
