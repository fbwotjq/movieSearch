<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">
<head>
<script type="text/javascript" >

	<c:if test="${not empty returnMsg}" >
		alert("<c:out value="${returnMsg}"/>");
		self.close();
	</c:if>

</script>
</head>
</html>
