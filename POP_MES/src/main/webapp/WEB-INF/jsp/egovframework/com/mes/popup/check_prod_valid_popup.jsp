<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/egovframework/com/mes/include.jsp" %>
		<style>
			.data-pop-current-line { background: #f8e1b5 !important; }
		</style>
		<script>
			var soName = '';
			var prodName = '';
			var lineCode = '';
			var dataWindow = null;
			var prodLineItemQty = new Object();
			
			$(function() {
				$("[name='mtrlCode']").keydown(function(key) {
					if (key.keyCode == 13) {
						checkValidProdCode();		
					}
				});
				
				dataWindow = new tui.Grid({
				    el: $('#dgMain')[0],
				    scrollX: true,
				    scrollY: true,
				    bodyHeight: 200,
				    columns: [
					    {
					    	header: '라인'
					    	, name: 'WORKLINE'
					    	, align: 'center'
					    	, resizable: true
					    	, sortable: true
					    	, formatter: function(props) { return TuiGridUtility.selectOptionFormatter(parent.prodLineList, props); }
					    },
					    {
					    	header: '자재명'
					    	, name: 'MTRLNAME'
					    	, align: 'center'
					    	, resizable: true
					    	, sortable: true
					    	, formatter: function(props) {
					    		var value = props.value;
					    		return value == null ? '자재 정보 없음' : value;
					    	}
					    },
					    {
					    	header: '공정자재재고'
					    	, name: 'STOCKQTY'
					    	, align: 'center'
					    	, resizable: true
					    	, sortable: true
					    },
					    {
					    	header: ' '
					    	, name: 'LINECHECK'
					    	, align: 'center'
					    	, width: 50
					    	, renderer: {
					    		type: lineCheckboxRenderer
					    	}
					    }
					]
				});
			});
			
			function creationComplete(obj) {
				soName = obj.soName;
				prodName = obj.prodName;
				lineCode = obj.lineCode;
				$("[name='mtrlCode']").focus();
			}
			
			function checkValidProdCode() {
				var mtrlCode = $("[name='mtrlCode']").val();
				if(mtrlCode == '') { 
					alert("자재 코드를 입력하세요.");
					return false;
				}
				
				// 오투입 체크 확인
				$.post('/mes/pop/popup/data/selectCheckProdValidItem.do', {
					soName: soName,
					mtrlCode: mtrlCode
				}, function(data) {
					if(data.result == true) {
						$("#soNameRslt").text(prodName);
						$("#mtrlNameRslt").text(mtrlCode);
						
						if(data.item > 0) {
							$("#result").text("정상");	
						} else {
							$("#result").text("오투입");
							alert("자재가 오투입되었습니다!");
						}
					}else if(data.result == false && data.errMsg != null) {
						alert(data.errMsg);
					}	else {
						alert("데이터 조회 중에 오류가 발생하였습니다.");	
					}
				}).fail(function() {
					alert("데이터 조회 중에 오류가 발생하였습니다.");
				});
				
				
				if($("[name='prodStockYn']").is(":checked")) { 
					searchMain({mtrlCode: mtrlCode, lineCode: lineCode}); 
				}
			}
			/*
			아래 해당 라인에 fuction으로 데이터 값 불러올 수 있게 추가한 부분
			테스트 예정 수정 에정
			*/
			function searchMain(obj) {
				dataWindow.clear();
				
				$.post('/mes/pop/popup/data/selectMtrlItemOnLine.do', obj, function(data) {
					if(data.result == true && data.item != null) {
						if(data.item.length > 0) {
							dataWindow.resetData(data.item);
							dataWindow.focusAt(0, 0, true);
							
							var dataList = dataWindow.getData();
							$.each(dataList, function(i, iv) {
								prodLineItemQty[iv.WORKLINE] = iv.STOCKQTY;
								if(iv.WORKLINE == lineCode) {
									dataWindow.addRowClassName(iv.rowKey, "data-pop-current-line");
								}
							});
							
						}
					} else {
						alert("데이터 조회 중에 오류가 발생하였습니다.");	
					}
				}).fail(function() {
					alert("데이터 조회 중에 오류가 발생하였습니다.");
				});;
			}
		
			function lineCheckboxRenderer(props) {
				var el = document.createElement('input');
				var rowKey = props.rowKey;
				
				el.type = 'checkbox';
				el.className = 'data-move-line-check';
				el.value = props.grid.getRow(rowKey).WORKLINE;
				el.onchange = function() {
					var workLine = props.grid.getRow(rowKey).WORKLINE;				
					props.grid.setValue(rowKey, props.columnInfo.name, el.checked ? 'Y' : 'N', false);
					if(el.checked) { plusProdItemWhenChecked(workLine); } 
					else { minusProdItemWhenChecked(workLine); }
				}
				
				if(props.value == null) { 
					props.grid.setValue(props.rowKey, props.columnInfo.name, 'N', true); 
				}
				
				if(props.grid.getRow(props.rowKey).WORKLINE == lineCode || props.grid.getRow(props.rowKey).STOCKQTY == 0) { 
					el.style.display = 'none'; 
				}
				
			    this.getElement = function() {
			    	return el;
				};

			  	this.render = function(props) {
			  		el.checked = props.value == 'Y' ? true : false;
				};
					
				this.render(props);
			}
			
	
			function plusProdItemWhenChecked(workLine) {
				var dataList = dataWindow.getData();
				
				$.each(dataList, function(i, iv) {
					var stockQty = dataWindow.getRow(iv.rowKey).STOCKQTY;
					if(iv.WORKLINE == lineCode) {
						dataWindow.setValue(iv.rowKey, 'STOCKQTY', stockQty + prodLineItemQty[workLine], false);
					} else if (iv.WORKLINE == workLine) { 
						dataWindow.setValue(iv.rowKey, 'STOCKQTY', stockQty - prodLineItemQty[workLine], false);
					}
				});
			}
			
			function minusProdItemWhenChecked(workLine) {
				var dataList = dataWindow.getData();
				
				$.each(dataList, function(i, iv) {
					var stockQty = dataWindow.getRow(iv.rowKey).STOCKQTY;
						
					if(iv.WORKLINE == lineCode) {
						dataWindow.setValue(iv.rowKey, 'STOCKQTY', stockQty - prodLineItemQty[workLine], false);
					} else if(iv.WORKLINE == workLine) { 
						dataWindow.setValue(iv.rowKey, 'STOCKQTY', stockQty + prodLineItemQty[workLine], false);
					}
				});
			}
			
			function saveAction() {
				var mtrlCode = $("[name='mtrlCode']").val();
				var dataList = dataWindow.getData();
				var moveLineList = new Array(); //옮겨질 대상
				var stockQty = 0;
				
				if(!$("[name='prodStockYn']").is(":checked") || $(".data-move-line-check:checked").length <= 0) {
					alert('사용할 공정자재가 없습니다.');
					return false;
				}
				
				$(".data-move-line-check:checked").each(function(i, iv) {
					moveLineList.push($(iv).val());
				});
				
				$.each(dataList, function(i, iv) {
				    if(iv.WORKLINE == lineCode) { stockQty = iv.STOCKQTY; }
				});
				
				$.post('/mes/pop/popup/data/updateMoveLineProdItemQty.do', {
					mtrlCode: mtrlCode,
					prodCode: soName,
					seqNo: 1,
					moveLineList: moveLineList,
					workLine: lineCode,
					stockQty: stockQty
				}, function(data) {
					if(data.result == true) {
						alert('공정 자재가 정상적으로 이동되었습니다.');
						searchMain({mtrlCode: mtrlCode, lineCode: lineCode});
					} else {
						alert("공정 자재 이동 중에 오류가 발생하였습니다.");	
					}
				}).fail(function() {
					alert("공정 자재 이동 중에 오류가 발생하였습니다.");
				});
			}
			
			function closePopup() {
				parent.checkProdValidItemPopup.dialog("close");
			}
		</script>
	</head>
	<body>
		<div>
			<div>
				<strong>[오투입 체크]</strong><br>
				<label><input type="checkbox" name="prodStockYn">공정재고 사용</input></label>
				<input type="text" name="mtrlCode" /> 
				<input type="button" onclick="checkValidProdCode();" value="자재코드 확인" class="btn" />
				<table>
					<tr>
						<th class="ver" width="180px;">품명 </th>
						<td> <span id="soNameRslt" style="width:90%;" ></span></td>
					</tr>
					<tr>
						<th>자재명</th>
						<td><span id="mtrlNameRslt"></span></td>
					</tr>
					<tr>
						<th>결과</th>
						<td><span id="result" class="result_txt"></td>
					</tr>
				</table>
					
			</div><br/>
			<div>
				<strong>[공정재고 확인]</strong>
				<div id="dgMain"></div>
				<div class="pop_btns">
					<input type="button" value="확인" onclick="saveAction();" class="btn">
					<input type="button" value="취소" onclick="closePopup();" class="btn">
				</div>
			</div>
		</div>
				
	</body>
</html>