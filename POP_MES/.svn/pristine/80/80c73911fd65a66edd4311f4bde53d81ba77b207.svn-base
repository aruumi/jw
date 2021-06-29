package egovframework.com.utl.hbz;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	/**
	 * date1, date2 비교
	 * @param date1
	 * @param date2
	 * @param format
	 * @return dt1이 dt2보다 크면 large, 작으면 small, 같으면 equal
	 * @throws Exception
	 */
	public static String checkDateCompare(String date1,String date2,String format) throws Exception {
		Date dt1 = stringToDate(date1,format);
		Date dt2 = stringToDate(date2,format);
		
		if(dt1.compareTo(dt2) > 0) return "large";
		else if(dt1.compareTo(dt2) < 0) return "small";
		return "equal";
	}

	
	/**
	 * 날짜 범위 내에 있는 지 확인
	 * @param date
	 * @param date1
	 * @param date2
	 * @return date1 <= date <= date2 
	 * @throws Exception
	 * @since 2019-12-03
	 */
	public static boolean checkDateRange(String date, String date1,String date2,String format) throws Exception {
		
		Date dt = stringToDate(date,format);
		Date dt1 = stringToDate(date1,format);
		Date dt2 = stringToDate(date2,format);
		
		if(dt.compareTo(dt1) >= 0) {
			if(dt.compareTo(dt2) <= 0) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * String형을 Date형으로 변환 
	 * @param date
	 * @param format (ex. yyyy-MM-dd)
	 * @return dt
	 * @throws Exception
	 * @since 2019-12-03
	 */
	public static Date stringToDate(String date, String format) {
		Date dt = null;
		
		try {
			SimpleDateFormat fmt = new SimpleDateFormat(format);
			dt = fmt.parse(date);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dt;
	}
	
	/**
	 * Date형을 String형으로 변환
	 * @param date
	 * @param format (ex. yyyy-MM-dd)
	 * @return dt
	 * @throws Exception
	 * @since 2019-12-03
	 */
	public static String dateToString(Date date, String format) {
		String dt = null;
		
		try {
			SimpleDateFormat fmt = new SimpleDateFormat(format);
			dt = fmt.format(date);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dt;
	}
	
	/**
	 * 날짜 계산
	 * @param date (더할 날짜)
	 * @param to (대상 Calendar.MONTH...)
	 * @param number (더할 값 1)
	 * @param format (yyyy-MM-dd)
	 * @return 계산된 값
	 * @throws Exception
	 */
	public static String calcDate(String date, int to, int number, String format) throws Exception {
		Date dt = stringToDate(date,format);
         
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(to, number);
         
        return dateToString(cal.getTime(),format);
	}

	public static String getTodayDate(String format) {  
        return dateToString(new Date(),format);
    }  

}
