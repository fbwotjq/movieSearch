<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="contents">
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var paramJson = JSON.stringify(${paramJson});

        try {
        	var handle = window.open("","CertificationWindow");
        	handle.callbackCheckIpinResult(paramJson);
        }catch (e) {
            console.log(e);
        }

        try {
            self.close();
        }catch (e) {
        }
    });

</script>