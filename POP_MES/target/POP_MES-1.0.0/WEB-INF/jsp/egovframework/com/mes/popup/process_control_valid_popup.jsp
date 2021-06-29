<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/com/mes/include.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<script>
		var soName = '';
		$(function() {
			$("[name='mtrlName']").keydown(function(key) {
				if (key.keyCode == 13) {
					checkValidProdCode();		
				}
			});
		});

		function creationComplete(_soName) {
			soName = _soName;
		}
		
		function checkValidProdCode() {
			var mtrlName = $("[name='mtrlName']").val();
			if(mtrlName == '') { 
				alert("자재 코드를 입력하세요.");
				return false;
			}
			
			$.post('/mes/pop/popup/data/selectCheckProdValidItem.do', {
				soName: soName,
				mtrlName: mtrlName
			}, function(data) {
				if(data.result == true) {
					$("#soNameRslt").text(soName);
					$("#mtrlNameRslt").text(mtrlName);
					
					if(data.item > 0) {
						$("#result").text("정상");	
					} else {
						$("#result").text("오투입");
						alert("자재가 오투입되었습니다!");
					}
				} else {
					alert("데이터 조회 중에 오류가 발생하였습니다.");	
				}
			}).fail(function() {
				alert("데이터 조회 중에 오류가 발생하였습니다.");
			});
		}
		</script>
	</head>
	
	<body>

	</body>
</html>