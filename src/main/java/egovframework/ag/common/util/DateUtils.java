/******************************************************************************
 * Jwork Framework 2.0
 ******************************************************************************
 * 1.클래스   명 : DateUtil.java
 * 2.클래스 개요 : 날짜와 관련된 다양한 유틸리티 클래스
 * 3.관련 테이블 : 관련 테이블 없음
 * 4.관련 클래스 : 관련 클래스 없음
 * 5.관련 페이지 : 관련 페이지 없음
 * 6.작   성  자 : 김택균
 * 7.작 성 일 자 : 2003. 12. 23.
 * 8.수 정 일 자 :
 *      . <날짜> ; <수정 내용> (<개발자명>)
 *      . <날짜> ; <수정 내용> (<개발자명>)
 * @author 김택균
 * @version 1.0 12/12/03
 ******************************************************************************/

package egovframework.ag.common.util;
 
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 일자, 시간과 관련된 다수의 기능
 * <p>
 * 일자패턴 사용시의 문법
 * 
 * <pre>
 * 	 Symbol   Meaning                 Presentation        Example
 * 	 ------   -------                 ------------        -------
 * 	 G        era designator          (Text)              AD
 * 	 y        year                    (Number)            1996
 * 	 M        month in year           (Text &amp; Number)     July &amp; 07
 * 	 d        day in month            (Number)            10
 * 	 h        hour in am/pm (1&tilde;12)    (Number)            12
 * 	 H        hour in day (0&tilde;23)      (Number)            0
 * 	 m        minute in hour          (Number)            30
 * 	 s        second in minute        (Number)            55
 * 	 S        millisecond             (Number)            978
 * 	 E        day in week             (Text)              Tuesday
 * 	 D        day in year             (Number)            189
 * 	 F        day of week in month    (Number)            2 (2nd Wed in July)
 * 	 w        week in year            (Number)            27
 * 	 W        week in month           (Number)            2
 * 	 a        am/pm marker            (Text)              PM
 * 	 k        hour in day (1&tilde;24)      (Number)            24
 * 	 K        hour in am/pm (0&tilde;11)    (Number)            0
 * 	 z        time zone               (Text)              Pacific Standard Time
 * 	 '        escape for text         (Delimiter)
 * 	 ''       single quote            (Literal)           '
 * 
 *   [예시]
 * 	 Format Pattern                         Result
 * 	 --------------                         -------
 * 	 &quot;yyyyMMdd&quot;                        -&gt;&gt;  19960710
 * 	 &quot;yyyy-MM-dd&quot;                      -&gt;&gt;  1996-07-10
 * 	 &quot;HHmmss&quot;                          -&gt;&gt;  210856
 * 	 &quot;HH:mm:ss&quot;                        -&gt;&gt;  21:08:56
 * 	 &quot;hh:mm:ss&quot;                        -&gt;&gt;  09:08:56
 * 	 &quot;yyyy.MM.dd hh:mm:ss&quot;             -&gt;&gt;  1996.07.10 15:08:56
 * 	 &quot;EEE, MMM d, ''yy&quot;                -&gt;&gt;  Wed, July 10, '96
 * 	 &quot;h:mm a&quot;                          -&gt;&gt;  12:08 PM
 * 	 &quot;hh 'o''clock' a, zzzz&quot;           -&gt;&gt;  12 o'clock PM, Pacific Daylight Time
 * 	 &quot;K:mm a, z&quot;                       -&gt;&gt;  0:00 PM, PST
 * 	 &quot;yyyyy.MMMMM.dd GGG hh:mm aaa&quot;    -&gt;&gt;  1996.July.10 AD 12:08 PM
 * 
 * </pre>
 * 
 * 기타 자세한 것은 <a
 * href="http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html">SimpleDateFormat</a>
 * Class API Document 를 참조할것
 */

public class DateUtils {
	
	private final static Logger logger = LogManager.getLogger();
	public static long big1ConverDt = 201110312400L;
	public static long bigEvtEndDt = 201111302400L;
	private static Calendar calendar = Calendar.getInstance();
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS", Locale.KOREA);
		
	static {
		dateFormat.setTimeZone(TimeZone.getTimeZone("GMT+09:00"));
	}
	
	/**
	 * 문자열의 값이 일자값인지 검증
	 * 
	 * @param textDate
	 *            일자값을 가진 8자리 문자열 예) '20010806'
	 * @return 일자값이면 true, 아니면 false
	 */
	public static boolean isDate(String textDate) {
		try {
			dateCheck(textDate);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 내부적인 Date Value Check용 임
	 * 
	 * @param textDate
	 */
	private static void dateCheck(String textDate) throws Exception {
		if (textDate.length() != 8)
			throw new Exception("[" + textDate + "] is not date value");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date dt = null;

		try {
			sdf.setLenient(false);
			dt = sdf.parse(textDate);
			
			logger.debug("dt === " + dt.toString());
		} catch (Exception e) {
			throw new Exception("[" + textDate + "] is not date value");
		}
		return;
	}

	/**
	 * 일자값을 가진 8자리 문자열로 Calendar 객체를 생성
	 * 
	 * @param textDate
	 *            일자값을 가진 8자리 문자열 예) '20010806'
	 *            일자값을 가진 10자리 문자열 예) '2001080601'
	 * @return Calendar 객체
	 */
	public static Calendar getCalendar(String textDate) throws Exception {
		int year = 0;
		int month = 0;
		int date = 0;
		int hour = 0;
		int minute = 0;
		int second = 0;
		if(textDate.indexOf("-")>-1 || textDate.indexOf(".")>-1){
			year = Integer.parseInt(textDate.substring(0, 4));
			month = Integer.parseInt(textDate.substring(5, 7));
			date = Integer.parseInt(textDate.substring(8, 10));
			if (textDate.length() >= 13) {
				hour = Integer.parseInt(textDate.substring(11, 13));
			}
			if (textDate.length() >= 16) {
				minute = Integer.parseInt(textDate.substring(14, 16));
			}
			if (textDate.length() >= 19) {
				second = Integer.parseInt(textDate.substring(17, 19));
			}
		}else{
			year = Integer.parseInt(textDate.substring(0, 4));
			month = Integer.parseInt(textDate.substring(4, 6));
			date = Integer.parseInt(textDate.substring(6, 8));
			if (textDate.length() >= 10) {
				hour = Integer.parseInt(textDate.substring(8, 10));
			}
			if (textDate.length() >= 12) {
				minute = Integer.parseInt(textDate.substring(10, 12));
			}
			if (textDate.length() >= 14) {
				second = Integer.parseInt(textDate.substring(12, 14));
			}
		}
		
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
		cal.set(year, month - 1, date, hour, minute, second);

		return cal;
	}

	/**
	 * 일자값을 가진 8자리 문자열로 Date 객체를 생성
	 * 
	 * @param textDate
	 *            일자값을 가진 8자리 문자열 예) '20010806'
	 * @return Date 객체
	 */
	public static Date getDate(String textDate) throws Exception {
		return getCalendar(textDate).getTime();
	}

	/**
	 * 일자값을 가진 8자리 문자열로 Date 객체를 생성
	 * 
	 * @param textDate
	 *            일자값을 가진 8자리 문자열 예) '2001-08-06 01:25:24'
	 * @return Date 객체
	 */
	public static Date getDateFormat(String textDate) throws Exception {
		return getCalendar(textDate).getTime();
	}

	/**
	 * 주어진 Date 객체를 이용하여 주어진 패턴 날짜형의 문자열을 구함.
	 * 
	 * @param date
	 *            원하는 일자의 Date 객체
	 * @param pattern
	 *            원하는 일자 패턴
	 * @return 주어진 패턴의 일자
	 */
	public static String getDateString(Date date, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(date);
	}

	/**
	 * 주어진 Date 객체를 이용하여 기본날짜형('yyyyMMdd')의 문자열을 구함.
	 * 
	 * @param date
	 *            원하는 일자의 Date 객체
	 * @return 주어진 패턴의 일자
	 */
	public static String getDateString(Date date) throws Exception {
		return getDateString(date, "yyyyMMdd");
	}

	/**
	 * 주어진 일자를 이용하여 주어진 패턴 날짜형의 문자열을 구함.
	 * 
	 * @param textDate
	 *            일자값을 가진 8자리 문자열 예) '20010806'
	 * @param pattern
	 *            원하는 일자 패턴
	 * @return 주어진 패턴의 일자
	 */
	public static String getDateString(String textDate, String pattern) throws Exception {
		String date = null;
		if (textDate != null && !textDate.equals("")) {
			date = getDateString(getDate(textDate), pattern);
		} else {
			date = "";
		}
		return date;
	}

	/**
	 * 주어진 패턴 날짜형 시스템일자를 구함
	 * 
	 * @param pattern
	 *            원하는 일자 패턴
	 * @return 시스템 일자
	 */
	public static String getSysDate(String pattern) {
		return getDateString(new Date(), pattern);
	}

	/**
	 * 기본패턴('yyyyMMdd') 날짜형 시스템일자를 구함
	 * 
	 * @param pattern
	 *            원하는 일자 패턴
	 * @return 기본형('yyyyMMdd')의 시스템 일자
	 */
	public static String getSysDate() {
		return getSysDate("yyyyMMdd");
	}

	/**
	 * 기본패턴('HHmmss') 날짜형 시스템시간을 구함
	 * 
	 * @param pattern
	 *            원하는 일자 패턴
	 * @return 기본형('HHmmss')의 시스템 시간
	 */
	public static String getTime() {
		return getSysDate("HHmmss");
	}

	/**
	 * 지정한 분리자를 이용한 시스템일자를 구함
	 * 
	 * @param delmt
	 *            원하는 분리자 문자 예) ':', '/' ...
	 * @return 분리자가 삽입된 시스템 시간
	 */
	public static String getTime(char delmt) {
		return getSysDate("HH" + delmt + "mm" + delmt + "ss");
	}

	/**
	 * 지정된 일자로 부터 일정기간 이후의 일자를 구함
	 * 
	 * @param fromDate
	 *            시작일자
	 * @param termDays
	 *            원하는 기간
	 * @return 일정기간 이후의 일자 ('yyyyMMdd')
	 */
	public static String getDateAdd(String fromDate, int termDays) throws Exception {
		Calendar cal = getCalendar(fromDate);
		cal.add(Calendar.DATE, termDays);
		return getDateString(cal.getTime(), "yyyyMMdd");
	}

	/**
	 * 시작일로부터 종료일까지의 일수를 구함
	 * 
	 * @param fromDate
	 *            시작일자
	 * @param toDate
	 *            종료일자
	 * @param both
	 *            양편넣기 여부
	 * @return 시작일자로 부터 종료일까지의 일수
	 */
	public static int getDiffDays(Date fromDate, Date toDate, boolean both) {
		long diffDays = toDate.getTime() - fromDate.getTime();
		long days = diffDays / (24 * 60 * 60 * 1000);
		if (both) {
			if (days >= 0)
				days += 1;
			else
				days -= 1;
		}
		return Long.valueOf(days).intValue();
	}

	/**
	 * 시작일로부터 종료일까지의 일수를 한편넣기로 계산함.
	 * 
	 * @param fromDate
	 *            시작일자
	 * @param toDate
	 *            종료일자
	 * @return 시작일자로 부터 종료일까지의 일수
	 */
	public static int getDiffDays(Date fromDate, Date toDate) {
		return getDiffDays(fromDate, toDate, false);
	}

	/**
	 * 시작일로부터 종료일까지의 일수를 구함
	 * 
	 * @param fromDate
	 *            시작일자
	 * @param toDate
	 *            종료일자
	 * @param both
	 *            양편넣기 여부
	 * @return 시작일자로 부터 종료일까지의 일수
	 */
	public static int getDiffDays(String fromDate, String toDate, boolean both) throws Exception {
		return getDiffDays(getDate(fromDate), getDate(toDate), both);
	}

	/**
	 * 시작일로부터 종료일까지의 일수를 한편넣기로 계산함.
	 * 
	 * @param fromDate
	 *            시작일자
	 * @param toDate
	 *            종료일자
	 * @return 시작일자로 부터 종료일까지의 일수
	 */
	public static int getDiffDays(String fromDate, String toDate) throws Exception {
		return getDiffDays(getDate(fromDate), getDate(toDate), false);
	}

	public static final Date convertStringToDate(String aMask, String strDate) throws ParseException {
		SimpleDateFormat df = null;
		Date date = null;
		df = new SimpleDateFormat(aMask);

		try {
			date = df.parse(strDate);
		} catch (ParseException pe) {
			throw new ParseException(pe.getMessage(), pe.getErrorOffset());
		}
		return (date);
	}
	
	/**
	 * 한국시간의 현재날짜를 format적용
	 * @param pattern
	 * @return
	 * @throws Exception
	 */
	public static String getTodayString(String pattern) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat(pattern, Locale.KOREA);
		df.setTimeZone(TimeZone.getTimeZone("GMT+09:00"));
		return df.format(new Date());
	}
	
	// time, thread info of console log
	public static String getLogTimeText() {
		StringBuffer sb = new StringBuffer("");
		try {
			calendar.setTimeInMillis(System.currentTimeMillis());
			sb.append("[LOG INFO] [");
			sb.append(Thread.currentThread().getId());
			sb.append("] [");
			sb.append(dateFormat.format(calendar.getTime()));
			sb.append("]  ");
		}catch(Exception e) {
				logger.error("error");
		}
		return sb.toString();
	}

  	public static GregorianCalendar getGregorianCalendar(String yyyymmdd){
  		// yyyymmdd = "2010-05-04";
  		//logger.debug("yyyymmdd === " + yyyymmdd);
		int yyyy	= Integer.parseInt(yyyymmdd.substring(0,4));
		int mm	= Integer.parseInt(yyyymmdd.substring(5,7));
		int dd	= Integer.parseInt(yyyymmdd.substring(8));
		GregorianCalendar calendar = new GregorianCalendar(yyyy, mm -1, dd, 0, 0, 0);
		return calendar;
	}

	public static long getDifferDays(String startDate, String endDate){
		GregorianCalendar StartDate = getGregorianCalendar(startDate);
		GregorianCalendar EndDate = getGregorianCalendar(endDate);
		long differ = (EndDate.getTime().getTime() - StartDate.getTime().getTime()) / 86400000;
		return differ;
	}

	public static String getCulDays(String basicDate, long differ){
		GregorianCalendar BasicDate = getGregorianCalendar(basicDate);
		long culDate	= BasicDate.getTime().getTime() + (differ*24*60*60*1000);
		SimpleDateFormat fomdate = new SimpleDateFormat("yyyy-MM-dd");
		String culDay	= fomdate.format(new Date(culDate)).toString();
		return culDay;
	}

  	// 마지막 날짜 구하기
	public static String getLastDateForMonth(String yyyymmdd){
  		String yyyy	= yyyymmdd.substring(0,4);
  		String mm	= yyyymmdd.substring(5,7);

		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(yyyy), Integer.parseInt(mm) -1, 1);
		int maxDays = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		String lastDate = yyyy + "-" + mm + "-" + maxDays;

		return lastDate;
	}
	
	// 현재주가 현재월에 몇째주에 해당되는지 계산한다.
	public static int getWeekOfMonth(Calendar cal){
		Locale LOCALE_COUNTRY = Locale.KOREA;
		Calendar calendar = cal;
		
		if(calendar==null){
			calendar = Calendar.getInstance(LOCALE_COUNTRY);
		}
		int week_of_month = calendar.get(Calendar.WEEK_OF_MONTH);
		
		return week_of_month;
	}
	
	/**
    *
    * @param i
    * @return
    */
   public static String getDayOfWeek(int i)
   {
       return new String[]{ "일", "월", "화", "수", "목", "금", "토" }[i];
   }

   public static String getDayOfWeekEng(int i)
   {
       return new String[]{ "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" }[i];
   }
   /**
    * 년월에 해당하는 달력을 출력
    * @param year
    * @param month
    * @param day
    * @return
 * @throws Exception 
    */
   public static String[][] getTable(int year, int month) throws Exception
   {
       Calendar cal = Calendar.getInstance();
       cal.set(year, month - 1, 1);

       int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
       int firstDay = cal.get(Calendar.DAY_OF_WEEK);
       
       cal.set(year, month - 1, lastDay);
       int weekcount = getWeekOfMonth(cal);
       
       String temp[][] = new String[weekcount][7];
       int daycount = 1;
       
       for (int i = 0; i < weekcount; i++)
       {
           for (int j = 0; j < 7; j++)
           {
               if (firstDay - 1 > 0 || daycount > lastDay)
               {
                   temp[i][j] = "";
                   firstDay--;
                   continue;
               }
               else
               {
                   temp[i][j] = String.valueOf( daycount );
               }
               daycount++;
           }
       }
      
       return temp;
   }

	/*
	 * 시차 계산
	 */
   public static String getTimeParallax(Integer cityTime) throws Exception {
		String timeParallax = null;
		
		try{
			
			if(cityTime!=null){
				long orderTime = (cityTime*60000);				
				long currentTime = System.currentTimeMillis();
				
				Calendar calendar = Calendar.getInstance();
				Date formatTime = new Date(currentTime + (orderTime));
				calendar.setTime(formatTime);
				
				timeParallax = getDateString(calendar.getTime(), "HH : mm"); 
						//calendar.get(Calendar.HOUR_OF_DAY) + " : " + calendar.get(Calendar.MINUTE);
			}
			
		} catch (Exception e) {
			logger.debug("Exception getTimeParallax === " + e);
		}
		
		return timeParallax;
	}
	
}
