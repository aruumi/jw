<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>페이지를 찾을 수 없습니다.</title>
<link href="<c:url value='/css/egovframework/com/com.css' />" rel="stylesheet" type="text/css" />

<script language="javascript">
function fncGoAfterErrorPage(){
    history.back(-2);
}
</script>
</head>

<body>

<div style="width: 100%; margin: 100px auto;">
	<div style="border: 0px solid #666; padding: 20px;">

		<div class="boxType1" style="width: 500px;margin: 0 auto;">
			<div class="box">
				<div class="error">
					<p class="title">HTTP 404 Error</p>
					<p class="cont mb20">웹 페이지를 찾을 수 없습니다.<br /></p>
					<span class="btn_style1 blue"><a href="javascript:fncGoAfterErrorPage();">이전 페이지</a></span>
				</div>
			</div>
		</div>
		
	</div>
</div>

</body>
</html>
