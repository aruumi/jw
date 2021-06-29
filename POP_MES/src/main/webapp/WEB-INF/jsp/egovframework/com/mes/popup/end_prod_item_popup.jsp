<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/egovframework/com/mes/include.jsp" %>
		
		<script>
			var prodBadCodeList = new Array();
			var GLOBAL_PARAMS = new Object(); 
			
			function creationComplete(obj) {
				
				console.log(obj);
				GLOBAL_PARAMS = obj;
				
				selectMesBadCodeList();
				$("[name='inspQty']").val(obj.inspQty);
				$("[name='implQty']").val(obj.inspQty);
			}
			
			function selectMesBadCodeList() {
				var obj = new Object();
				obj.cdNo = 'BADCODE';

				$.post('/mes/pop/data/selectMesCommonCodeList.do', obj, function(data) {
					if(data.result == true) {
						for(var i=0;i<data.item.length;i++) {
							prodBadCodeList.push({text: data.item[i].itm_nm, value: data.item[i].itm_cd});
						}
						
						ComboUtility.appendComboData($("[name='badCode']"), data.item, 'itm_nm', 'itm_cd', false);
					} else {
						alert("데이터 조회 중에 오류가 발생하였습니다.");	
					}
				}).fail(function() {
					alert("데이터 조회 중에 오류가 발생하였습니다.");
				});
			}
			
			function saveAction() {
				if(!checkValidQty()) {
					alert("검사, 불량, 양품 수량의 개수가 맞지 않습니다. 확인해주세요.");
					return false;
				}
				
				
				var obj = {
					changeState: 'END', 
					prodLineCd: GLOBAL_PARAMS.prodLineCd,
					workOrderNo: GLOBAL_PARAMS.workOrderNo,
					soName: GLOBAL_PARAMS.soName,
					prodEmpNo: GLOBAL_PARAMS.prodEmpNo,
					woProdCode: GLOBAL_PARAMS.woProdCode,
					bomCheckYn : GLOBAL_PARAMS.bomCheckYn,
					inspQty: $("[name='inspQty']").val(),
					implQty: $("[name='implQty']").val(),
					badQty: $("[name='badQty']").val(),
					badCode: $("[name='badCode']").val()
				};
				
				parent.changeProdWorkItem(obj);
				parent.endProdItemPopup.dialog("close");
			}
			
			function checkValidQty() {
				var inspQty = $("[name='inspQty']").val();
				var badQty = $("[name='badQty']").val();
				var implQty = $("[name='implQty']").val();
				
				if((Number(inspQty) - Number(badQty)) == Number(implQty)) {
					return true;	
				}
				
				return false;
			}
			
			$(function() {
				$(".number_only").on("keyup", function() {
				    $(this).val($(this).val().replace(/[^0-9]/g,""));
				});

				$("[name='inspQty']").on("change", function() {
					var inspQty = $("[name='inspQty']").val();
					var badQty = $("[name='badQty']").val();
					var implQty = $("[name='implQty']").val();
					
					if(isNaN(inspQty)) {
						alert("올바른 숫자가 아닙니다.");
						return false;
					} 
					
					if(Number(inspQty) < Number(badQty)) {
						$("[name='badQty']").val(inspQty);
					} 
					
					$("[name='inspQty']").val(Number(inspQty));
					$("[name='badQty']").trigger("change");
				});
				
				$("[name='badQty']").on("change", function() {
					var badQty = $("[name='badQty']").val();
					var inspQty = $("[name='inspQty']").val();
				
					if(isNaN(badQty)) {
						alert("올바른 숫자가 아닙니다.");
						return false;
					} else if(Number(badQty) > Number(inspQty)) {
						alert("불량 수량이 검사 수량 보다 클 수 없습니다.");
						$("[name='badQty']").val(inspQty);
						$("[name='implQty']").val(0);
						return false;
					} 
					
					$("[name='badQty']").val(Number(badQty));
					$("[name='implQty']").val(inspQty - badQty);
				});
			});
		</script>
	</head>
	<body>
		<div>
			<table>
				<tr>
					<th class="ver" width="150px;"><span>불량 코드</span></th>
					<td class="left"><select name="badCode"></select></td>
				</tr><tr>
					<th><span>검사 수량</span></th>
					<td class="left"><input type="number" class="number_only" name="inspQty" value="0" /></td>
				</tr><tr>
					<th>불량 수량</th>
					<td class="left"><input type="number" class="number_only" name="badQty" value="0" /></td>
				</tr><tr>
					<th>양품 수량</th>
					<td class="left"><input type="number" class="number_only" name="implQty" value="0" readOnly="readOnly"/></td>
				</tr>
			</table>
			<div class="pop_btns">
				<input type="button" value="저장" onclick="saveAction();" class="btn"/>
			</div>
		</div>
	</body>
</html>