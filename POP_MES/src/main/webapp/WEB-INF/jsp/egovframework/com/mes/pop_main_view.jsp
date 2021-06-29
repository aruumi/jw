<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/com/mes/include.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<style>
			.tui-grid-cell-current-row > td {
				background: #f8e1b5;
				-webkit-transition: background-color 250ms linear;
			    -ms-transition: background-color 250ms linear;
			    transition: background-color 250ms linear;
			}
		</style>
		<script src="/js/egovframework/com/mes/pop_main_view.js"></script>

		<script>
			$(function() {
				selectMesProdStatusList();
				selectMesWorkerList();
				selectMesProcessLineList();
				initDataWindow();
			});
		</script>
	</head>
	
	<body>
	
	<section class="pop">
		<div class="w_val">
			<div class="left"><h3><img src="/images/egovframework/com/mes/mes_logo.png"></h3></div>
			<div class="right">
				작업자 
				<select name="prodEmpNo" title="작업자" style="font-size:25px;" onchange="setProdEmpNo(this.value)"></select>
<!-- 				<input type="button" onclick="addProdItemAction();" value="작업 추가" class="pop_btn"> -->
			</div>
			
			<div class="pop_btns box" name="processLineCode"></div>
			
			<div class="grid_left">
				<!-- 그리드 -->
				<div id="dgMain"></div>
				<!-- 그리드 -->
			</div>
			
			<div class="grid_right">
				<!-- 그리드 결과화면 -->
				<div class="board_list"> 
					<table class="board_table">
						<tr>
							<th class="ver" style="font-size:25px;">계획 시작일</th>
							<td><input type="text" name="plan_start_dt" style="width:90%; font-size:25px;" readonly="readonly"></td>
						</tr>
						<tr>
							<th style="font-size:25px;">작업 시작일</th>
							<td><input type="text" name="prod_start_dt" style="width:90%; font-size:25px;" readonly="readonly"></td>
						</tr>
						<tr>
							<th style="font-size:25px;">작업 종료일</th>
							<td><input type="text" name="prod_end_dt" style="width:90%; font-size:25px;" readonly="readonly"></td>
						</tr>
						<tr>
							<th style="font-size:25px;">일시정지 일자</th>
							<td><input type="text" name="prod_pause_dt" style="width:90%; font-size:25px;" readonly="readonly"></td>
						</tr>
					</table>
				</div>
					<!-- 그리드 결과화면 -->			
			</div>

			<div class="pop_btns">
<!-- 				<input type="button" onclick="checkProdValidItemAction();" value="오투입 체크" class="pop_btn check"> -->
				<input type="button" onclick="startProdItemAction();" value="작업시작" class="pop_btn play">
				<input type="button" onclick="pauseProdItemAction();" value="일시중단" class="pop_btn pause">
				<input type="button" onclick="endProdItemAction();" value="작업완료" class="pop_btn end">
			</div>
		</div>
		<div class="footer"><h4>Copyright 2021 ⓒ 정원전자. All rights reserved. TEL : 055) 341 - 6618         </h4></div>
	</section>
	<div id="ProdEndItemPopup" style="display:none;">
		<iframe id="ProdEndItemFrame" src="/mes/pop/popup/prodEndItem.do" style="width:100%;height:95%;border:0"></iframe>         
	</div>	  
	<div id="ProdPauseItemPopup" style="display:none;">
		<iframe id="ProdPauseItemFrame" src="/mes/pop/popup/prodPauseItem.do" style="width:100%;height:95%;border:0"></iframe>         
	</div>	  
	<div id="CheckProdValidItemPopup" style="display:none;">
		<iframe id="CheckProdValidItemFrame" src="/mes/pop/popup/checkProdValidItem.do" style="width:100%;height:95%;border:0"></iframe>         
	</div>
	<div id="addProdItemPopup" style="display:none;">
		<iframe id="AddProdItemFrame" src="/mes/pop/popup/addProdItem.do" style="width:100%;height:95%;border:0"></iframe>         
	</div>
	</body>
</html>
