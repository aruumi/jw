tui.Grid.setLanguage('ko');
			
var dataWindow = null;
var pauseProdItemPopup = null;
var endProdItemPopup = null;
var checkProdValidItemPopup = null;
var DATA_GRID_ELEMENT = '#dgMain';
var workEmpList = new Array();
var prodStatusCodeList = new Array();
var prodWorkerList = new Array();
var prodLineList = new Array();
var lineCode = null;

function setLineCode(lineCode) {
	this.lineCode = lineCode;
	
	searchAction();
}

var prodEmpNo = null;
function setProdEmpNo(prodEmpNo) {
	this.prodEmpNo = prodEmpNo;
	
	//searchAction();
}

function selectMesProdStatusList() {
	var obj = new Object();
	obj.cdNo = 'WORKSTATE';

	$.post('/mes/pop/data/selectMesCommonCodeList.do', obj, function(data) {
		if(data.result == true) {
			for(var i=0;i<data.item.length;i++) {
				prodStatusCodeList.push({text: data.item[i].itm_nm, value: data.item[i].itm_cd});
			}
		} else {
			alert("데이터 조회 중에 오류가 발생하였습니다.");	
		}
	}).fail(function() {
		alert("데이터 조회 중에 오류가 발생하였습니다.");
	});
}


function selectMesWorkerList() {
	var obj = new Object();
	
	$.post('/mes/pop/data/selectMesWorkerList.do', obj, function(data) {
		if(data.result == true) {
			for(var i=0;i<data.item.length;i++) {
				prodWorkerList.push({text: data.item[i].USERNAME, value: data.item[i].EMPNO});
			}
			ComboUtility.appendComboData($("[name='prodEmpNo']"), data.item, 'USERNAME', 'EMPNO', true);
		} else {
			alert("데이터 조회 중에 오류가 발생하였습니다.");	
		}
	}).fail(function() {
		alert("데이터 조회 중에 오류가 발생하였습니다.");
	});
}

function selectMesProcessLineList() {
	var obj = new Object();
	
	$.post('/mes/pop/data/selectMesProcessLineList.do', obj, function(data) {
		if(data.result == true) {
			for(var i=0;i<data.item.length;i++) {
				var lineName = data.item[i].LINENAME;
				var lineCode = data.item[i].LINECODE;
				prodLineList.push({text: lineName, value: lineCode});
				
				$("[name='processLineCode']").append($("<input>", {type: "button", class: "pop_btn", onclick: "setLineCode('" + lineCode + "')", value: lineName}));
			}
		} else {
			alert("데이터 조회 중에 오류가 발생하였습니다.");	
		}
	}).fail(function() {
		alert("데이터 조회 중에 오류가 발생하였습니다.");
	});;
}

function initDataWindow() {
	dataWindow = new tui.Grid({
	    el: $('#dgMain')[0],
	    scrollX: true,
	    scrollY: true,
	    bodyHeight: 350,
	    rowHeight: 40,
	    columns: [
			{
		    	  header: ' '
		    	, name: 'DATA_TYPE_ICON'
		    	, align: 'center'
		    	, width: 70
		    	, renderer: {
		    		type: TuiGridUtility.getImageRenderer,
		    		options: {
		    			getImageUrl: function(props) {
		    				var path = "/images/egovframework/com/mes/";
		    				var value = props.grid.getRow(props.rowKey).PRODSTATUS;
		    				if(value == 'WD') { return path + "pop_icon_play.png"; } // 작업중
		    				else if(value == 'WA') { return path + "pop_icon_pause.png"; } // 일시중지
		    				else if(value == 'WE') { return null; } // 작업대기
		    				else if(value == 'WC') { return null; } // 공정중단
		    				else if(value == 'WB') { return null; } // 불량
		    				else if(value == 'WX') { return path + "pop_icon_end.png"; } // 완료
		    				
		    				return null;
		    			}
		    		}
		    	}
			},
		    {
		    	header: '상태'
		    	, name: 'PRODSTATUS'
		    	, align: 'center'
				, width: 110
		    	, resizable: true
		    	, sortable: true
		    	, formatter: function(props) { return TuiGridUtility.selectOptionFormatter(prodStatusCodeList, props); }
		    },
		    {
		    	header: '라인'
		    	, name: 'PRODLINECD'
		    	, align: 'center'
				, width: 80
		    	, resizable: true
		    	, sortable: true
		    	, formatter: function(props) { return TuiGridUtility.selectOptionFormatter(prodLineList, props); }
		    },
//		    {
//		    	header: '수주번호' 
//		    	, name: 'SONO'
//		    	, align: 'center'
//				, width: 150
//		    	, resizable: true
//		    	, sortable: true
//		    	
//		    },
		    {
		    	header: '품명'
		    	, name: 'PRODNAME'
		    	, align: 'left'
		    	, resizable: true
		    	, sortable: true
		    },
		    {
		    	header: '수주수량'
		    	, name: 'SOQTY'
		    	, align: 'center'
				, width: 130
		    	, resizable: true
		    	, sortable: true
		    },
		    {
		    	header: '작업자'
		    	, name: 'PRODEMPNO'
		    	, align: 'center'
		    	, width: 150
		    	, resizable: true
		    	, sortable: true
		    	, formatter: function(props) { return TuiGridUtility.selectOptionFormatter(prodWorkerList, props); }
		    }
		]
	});
	
	dataWindow.on('click', function(event) {
		var rowKey = event.rowKey;
		if(rowKey == null) { return false; }
		
		var workOrderNo = event.instance.getRow(rowKey).WORKORDERNO;	
		searchItemDetail(workOrderNo);
		console.log(event);
	});
}

function searchAction() {
	var obj = new Object();
	obj.prodLineCd = lineCode;
	obj.prodEmpNo = prodEmpNo;
	
	searchMain(obj);
}

function searchMain(obj) {
	dataWindow.clear();
	
	$.post('/mes/pop/data/selectProdWorkOrderList.do', obj, function(data) {
		if(data.result == true && data.item != null) {
			if(data.item.length > 0) {
				dataWindow.resetData(data.item);
				dataWindow.focusAt(0, 0, true);
				searchItemDetail(data.item[0].WORKORDERNO);
			}
		} else {
			alert("데이터 조회 중에 오류가 발생하였습니다.");	
		}
	}).fail(function() {
		alert("데이터 조회 중에 오류가 발생하였습니다.");
	});;
}

function searchItemDetail(workOrderNo) {
	$.post('/mes/pop/data/selectProdWorkOrderItem.do', {
		workOrderNo: workOrderNo
	}, function(data) {
		if(data.result == true) {
			
			console.log(data.item);
			if(data.item == null) { return false; }
			
			if((typeof data.item.WODTTM) != 'undefined') {
				$("[name='plan_start_dt']").val(DateUtility.changeFormat(data.item.WODTTM));
			}else{
				$("[name='plan_start_dt']").val(null);	
			}
			if(typeof data.item.PRODSTARTDTTM != 'undefined') {
				$("[name='prod_start_dt']").val(DateUtility.changeFormat(data.item.PRODSTARTDTTM));
			}else{
				$("[name='prod_start_dt']").val(null);	
			}
			if(typeof data.item.PRODENDDTTM != 'undefined') {
				$("[name='prod_end_dt']").val(DateUtility.changeFormat(data.item.PRODENDDTTM));
			}else{
				$("[name='prod_end_dt']").val(null);	
			}
			if(typeof data.item.PRODSTPDTTM != 'undefined') {
				$("[name='prod_pause_dt']").val(DateUtility.changeFormat(data.item.PRODSTPDTTM));	
			}else{
				$("[name='prod_pause_dt']").val(null);	
			}
		} else {
			alert("데이터 조회 중에 오류가 발생하였습니다.");	
		}
	}).fail(function() {
		alert("데이터 조회 중에 오류가 발생하였습니다.");
	});
}

function changeProdWorkItem(obj) {
	if(!confirm("작업 상태를 변경하시겠습니까?")) { return false; }
	
	$.post('/mes/pop/data/changeProdWorkItem.do', obj, function(data) {
		if(data.result == true) {
			alert("정상 처리되었습니다.");
		} else {
			alert("데이터 처리 중 오류가 발생하였습니다.");	
		}
		searchAction();
	}).fail(function() {
		alert("데이터 조회 중에 오류가 발생하였습니다.");
	});;
	
}

/* 오투입 체크 */
function checkProdValidItemAction() {
	var rowKey = dataWindow.getFocusedCell().rowKey;
    var frame = document.getElementById('CheckProdValidItemFrame');
    
    if(rowKey == null) {
		alert('작업 항목을 선택하세요.');
		return false;
	}else if(dataWindow.getRow(rowKey)['PRODSTATUS'] != null){    
		alert('작업대기중만 오투입체크 가능합니다.');
		return false;
	}   

    checkProdValidItemPopup = PageUtility.createPopupInstance({
        el: $("#CheckProdValidItemPopup"), 
        frame: frame,
        reloadFrame: true,
        options: {title: '오투입 체크', width: 800, height: 650, position: { my: "right", at: "center", of: window } }, 
        onShow: function() {
            frame.onload = function() {
                var frameWindow = frame.contentWindow || frame.contentDocument;
                frameWindow.creationComplete({
                	soName: dataWindow.getRow(rowKey)['SONAME'],
                	prodName : dataWindow.getRow(rowKey)['PRODNAME'],
                	lineCode: lineCode
                });
            }
        }, 
        onClose: function() {} 
    }).dialog( "open" );
}

/* 작업 시작 */
function startProdItemAction() {
	var rowKey = dataWindow.getFocusedCell().rowKey;
	if(rowKey == null) {
		alert('작업 항목을 선택하세요.');
		return false;
	}	
	
	var result = dataWindow.findRows({
					PRODSTATUS : 'WD'
				});
	
	if(result.length > 0 ){
		alert('작업중인 생산이 있으므로 완료 후 작업시작하세요');
		return false;
	}
	
	changeProdWorkItem({changeState: 'START', workOrderNo: dataWindow.getRow(rowKey).WORKORDERNO,  prodLineCd: lineCode });
}

/* 일시 중단 */
function pauseProdItemAction() {
	var rowKey = dataWindow.getFocusedCell().rowKey;
	if(rowKey == null) {
		alert('작업 항목을 선택하세요.');
		return false;
	}	

	var frame = document.getElementById('ProdPauseItemFrame');
	var obj = new Object();
	obj.prodLineCd = lineCode; //dataWindow.getRow(rowKey).PRODLINECD;
	obj.workOrderNo = dataWindow.getRow(rowKey).WORKORDERNO;
	obj.soName = dataWindow.getRow(rowKey).SONAME;
	obj.prodEmpNo = dataWindow.getRow(rowKey).PRODEMPNO;
	obj.inspQty = dataWindow.getRow(rowKey).SOQTY;

	pauseProdItemPopup = PageUtility.createPopupInstance({
        el: $("#ProdPauseItemPopup"), 
        frame: frame,
        reloadFrame: true,
        options: {title: '일시 중단', width: 500, height: 400, position: { my: "center", at: "center", of: window } }, 
        onShow: function() {
            frame.onload = function() {
                var frameWindow2 = frame.contentWindow || frame.contentDocument;
                frameWindow2.creationComplete(obj);
            }
        }, 
        onClose: function() {} 
    }).dialog( "open" );
	
}

/* 작업 완료 */
function endProdItemAction() {
	var rowKey = dataWindow.getFocusedCell().rowKey;
	if(rowKey == null) {
		alert('작업 항목을 선택하세요.');
		return false;
	}	
	

	var frame = document.getElementById('ProdEndItemFrame');
	var obj = new Object();
	obj.prodLineCd = lineCode; //dataWindow.getRow(rowKey).PRODLINECD;
	obj.workOrderNo = dataWindow.getRow(rowKey).WORKORDERNO;
	obj.soName = dataWindow.getRow(rowKey).SONAME;
	obj.prodEmpNo = prodEmpNo; //dataWindow.getRow(rowKey).PRODEMPNO;
	obj.inspQty = dataWindow.getRow(rowKey).SOQTY;

	endProdItemPopup = PageUtility.createPopupInstance({
        el: $("#ProdEndItemPopup"), 
        frame: frame,
        reloadFrame: true,
        options: {title: '작업 완료', width: 500, height: 400, position: { my: "center", at: "center", of: window } }, 
        onShow: function() {
            frame.onload = function() {
                var frameWindow = frame.contentWindow || frame.contentDocument;
                frameWindow.creationComplete(obj);
            }
        }, 
        onClose: function() {} 
    }).dialog( "open" );
}
