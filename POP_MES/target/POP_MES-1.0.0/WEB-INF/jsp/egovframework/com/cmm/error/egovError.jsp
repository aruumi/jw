<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isErrorPage="true" import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>오류가 발생했습니다.</title>
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
		
		<div class="boxType1" style="width: 500px;">
			<div class="box">
				<div class="error">
					<p class="title">오류가 발생하였습니다.</p>
					<p class="cont mb20">관리자에게 문의하시기 바랍니다.<br /></p>
					<span class="btn_style1 blue"><a href="javascript:fncGoAfterErrorPage();">이전 페이지</a></span>
				</div>
			</div>
		</div>
		
	</div>
</div>
<%
exception.printStackTrace();
%>
</body>
</html>
