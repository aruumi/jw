var DateUtility = new Object();

// 날짜 객체를 날짜 문자열로 변경
DateUtility.getDateFromDateString = function(date) {
    var _date = String(date);
    var sYear = _date.substring(0,4);
    var sMonth = _date.substring(4,6);
    var sDate = _date.substring(6,8);
    var sHour = _date.substring(8,10);
    var sMinute = _date.substring(10,12);
    var sSecond = _date.substring(12,14);

    return new Date(Number(sYear), Number(sMonth)-1, Number(sDate), Number(sHour), Number(sMinute), Number(sSecond));
}

// 날짜 문자열을 날짜 객체로 변경
DateUtility.getDateStringFromDate = function(date) {
    var sYear = date.getFullYear();
    var sMonth = date.getMonth() + 1;
    var sDate = date.getDate();
    var sHour = date.getHours();
    var sMinute = date.getMinutes();
    var sSecond = date.getSeconds();
    
    sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
    sDate  = sDate > 9 ? sDate : "0" + sDate;
    sHour  = sHour > 9 ? sHour : "0" + sHour;
    sMinute  = sMinute > 9 ? sMinute : "0" + sMinute;
    sSecond  = sSecond > 9 ? sSecond : "0" + sSecond;
    
    return sYear + sMonth + sDate + sHour + sMinute + sSecond;
}

//날짜 문자열을 날짜 객체로 변경
DateUtility.changeFormat = function(date) {
	if(date == null || date == '') { return ''; }
	var _date = String(date);
    var sYear = _date.substring(0,4);
    var sMonth = _date.substring(4,6);
    var sDate = _date.substring(6,8);
    var sHour = _date.substring(8,10);
    var sMinute = _date.substring(10,12);
    var sSecond = _date.substring(12,14);
	   
    if(_date.length > 8) {
//    	return sYear + '년 ' + sMonth + '월 ' + sDate + '일 ' + sHour + '시 ' + sMinute + '분 ' + sSecond + '초';
    	return sMonth + '월 ' + sDate + '일 ' + sHour + '시 ' + sMinute + '분 ' + sSecond + '초';
    }
    
//    return sYear + '년 ' + sMonth + '월 ' + sDate + '일 ';
    return sMonth + '월 ' + sDate + '일 ';
};
