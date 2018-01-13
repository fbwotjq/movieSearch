package egovframework.ag.common.util;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//import com.nhncorp.lucy.security.xss.XssFilter;

public class StringUtils {

	public static final String EMPTY = ""; //$NON-NLS-1$
	public static final String NULL = "null"; //$NON-NLS-1$
	public static final char[] WORD_SEPARATORS = {'_', '-', '@', '$', '#', ' '};
	public static final int INDEX_NOT_FOUND = -1;
	public static final String ALLOWED_CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*'()";

	private StringUtils() {
	}

	public static String encode(long longValue, int radix){
		return Long.toString(longValue, radix);
	}

	public static long decode(String strValue, int radix){
		return Long.parseLong(strValue, radix);
	}

	public static String maxConvert36(String strValue){
		return encode(new BigDecimal(decode(strValue,36)).longValueExact(), 36);
	}

	/**
     * lpad 함수
     *
     * @param str   대상문자열, len 길이, addStr 대체문자
     * @return      문자열
     */
    public static String lpad(String str, int len, String addStr) {
        String result = str;
        int templen   = len - result.length();

        for (int i = 0; i < templen; i++){
              result = addStr + result;
        }

        return result;
    }

	/**
	 * <p>문자(char)가 단어 구분자('_', '-', '@', '$', '#', ' ')인지 판단한다.</p>
	 *
	 * @param c 문자(char)
	 * @return 단어 구분자이면 true, 아니면 false를 반환한다.
	 */
	public static boolean isWordSeparator(char c) {
		for (int i = 0; i < WORD_SEPARATORS.length; i++) {
			if (WORD_SEPARATORS[i] == c) {
				return true;
			}
		}
		return false;
	}

	/**
	 * <p>문자(char)가 단어 구분자(wordSeparators)인지 판단한다.</p>
	 * <p>단어 구분자가 <code>null</code>이면 false를 반환한다.</p>
	 *
	 * @param c 문자(char)
	 * @param wordSeparators 단어 구분자
	 * @return 단어 구분자이면 true, 아니면 false를 반환한다.
	 */
	public static boolean isWordSeparator(char c, char[] wordSeparators) {
		if (wordSeparators == null) {
			return false;
		}
		for (int i = 0; i < wordSeparators.length; i++) {
			if (wordSeparators[i] == c) {
				return true;
			}
		}
		return false;
	}

	/**
	 * <p>문자열(String)을 카멜표기법으로 표현한다.</p>
	 *
	 * <pre>
	 * StringUtils.camelString("ITEM_CODE", true)  = "ItemCode"
	 * StringUtils.camelString("ITEM_CODE", false) = "itemCode"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param firstCharacterUppercase 첫문자열을 대문자로 할지 여부
	 * @return 카멜표기법으로 표현환 문자열
	 */
	public static String camelString(String str, boolean firstCharacterUppercase) {
		if (str == null) {
			return null;
		}

		StringBuffer sb = new StringBuffer();

		boolean nextUpperCase = false;
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);

			if (isWordSeparator(c)) {
				if (sb.length() > 0) {
					nextUpperCase = true;
				}
			} else {
				if (nextUpperCase) {
					sb.append(Character.toUpperCase(c));
					nextUpperCase = false;
				} else {
					sb.append(Character.toLowerCase(c));
				}
			}
		}

		if (firstCharacterUppercase) {
			sb.setCharAt(0, Character.toUpperCase(sb.charAt(0)));
		}
		return sb.toString();
	}

	/**
	 * <p>입력 받은 문자를 반복숫자만큼 붙여서 만든다.</p>
	 *
	 * <pre>
	 * StringUtils.repeat(null, *)   = null
	 * StringUtils.repeat("", -1)    = ""
	 * StringUtils.repeat("", 2)     = ""
	 * StringUtils.repeat("han", -1) = ""
	 * StringUtils.repeat("han", 0)  = ""
	 * StringUtils.repeat("han", 2)  = "hanhan"
	 * </pre>
	 *
	 * @param str
	 * @param repeat 반복숫자
	 * @return
	 */
	public static String repeat(String str, int repeat) {
		if (str == null) {
			return null;
		}
		if (repeat < 1) {
			return EMPTY;
		}
		int inputLen = str.length();
		if (inputLen == 0 || repeat == 1) {
			return str;
		}
		int outputLen = inputLen * repeat;
		if (inputLen == 1) {
			char ch = str.charAt(0);
			char[] output = new char[outputLen];
			for (int i = 0; i < outputLen; i++) {
				output[i] = ch;
			}
			return new String(output);
		} else {
			StringBuilder output = new StringBuilder((int) Math.min((outputLen*110L)/100, Integer.MAX_VALUE));
			for (int i = 0; i < repeat; i++) {
				output.append(str);
			}
			return output.toString();
		}
	}

	// ----------------------------------------------------------------------
	// 공백/여백문자  검사, 제거, 치환
	// ----------------------------------------------------------------------

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한후, 공백("")이거나 <code>null</code>인 검사한다.</p>
	 *
	 * <pre>
	 * StringUtils.isBlank(null)    = true
	 * StringUtils.isBlank("")      = true
	 * StringUtils.isBlank("   ")   = true
	 * StringUtils.isBlank("han")   = false
	 * StringUtils.isBlank(" han ") = false
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static boolean isBlank(String str) {
		if (str == null) {
			return true;
		}
		int strLen = str.length();
		if (strLen > 0) {
			for (int i = 0; i < strLen; i++) {
				if (Character.isWhitespace(str.charAt(i)) == false) {
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한후, 공백("")이 아니거나 <code>null</code>이 아닌지 검사한다.</p>
	 *
	 * <pre>
	 * StringUtils.isNotBlank(null)    = false
	 * StringUtils.isNotBlank("")      = false
	 * StringUtils.isNotBlank("   ")   = false
	 * StringUtils.isNotBlank("han")   = true
	 * StringUtils.isNotBlank(" han ") = true
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static boolean isNotBlank(String str) {
		return !isBlank(str);
	}

	/**
	 * <p>문자열(String)이 공백("")이거나 <code>null</code>인 검사한다.</p>
	 *
	 * <pre>
	 * StringUtils.isEmpty(null)    = true
	 * StringUtils.isEmpty("")      = true
	 * StringUtils.isEmpty("   ")   = false
	 * StringUtils.isEmpty("han")   = false
	 * StringUtils.isEmpty(" han ") = false
	 * </pre>
	 *
	 *
	 * @param str 검사할 문자열
	 * @return
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0;
	}

	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}else {
			return isEmpty(obj.toString());
		}
	}

	public static String defaultString(Object obj, String str) {
		if (obj == null) {
			return str;
		}else {
			return obj.toString();
		}
	}

	/**
	 * <p>문자열(String)이 공백("")이 아니거나 <code>null</code>이 아닌지 검사한다.</p>
	 *
	 * <pre>
	 * StringUtils.isNotEmpty(null)    = false
	 * StringUtils.isNotEmpty("")      = false
	 * StringUtils.isNotEmpty("   ")   = true
	 * StringUtils.isNotEmpty("han")   = true
	 * StringUtils.isNotEmpty(" han ") = true
	 * </pre>
	 *
	 * @param str 검사할 문자열
	 * @return
	 */
	public static boolean isNotEmpty(String str) {
		return !isEmpty(str);
	}

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한다.</p>
	 *
	 * <pre>
	 * StringUtils.trim(null)    = null
	 * StringUtils.trim("")      = ""
	 * StringUtils.trim("   ")   = ""
	 * StringUtils.trim("han")   = "han"
	 * StringUtils.trim(" han ") = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String trim(String str) {
		return str == null ? null : str.trim();
	}

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한 후 공백("")이거나 <code>null</code>이면 <code>null</code>을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.trimToNull(null)    = null
	 * StringUtils.trimToNull("")      = null
	 * StringUtils.trimToNull("   ")   = null
	 * StringUtils.trimToNull("han")   = "han"
	 * StringUtils.trimToNull(" han ") = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String trimToNull(String str) {
		return isBlank(str) ? null : trim(str);
	}

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한 후 공백("")이거나 <code>null</code>이면 공백("")을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.trimToEmpty(null)    = ""
	 * StringUtils.trimToEmpty("")      = ""
	 * StringUtils.trimToEmpty("   ")   = ""
	 * StringUtils.trimToEmpty("han")   = "han"
	 * StringUtils.trimToEmpty(" han ") = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String trimToEmpty(String str) {
		return isBlank(str) ? EMPTY : trim(str);
	}

	/**
	 * <p>문자열(String)이 <code>null</code>이면 기본문자열을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.defaultIfNull(null, "")    = ""
	 * StringUtils.defaultIfNull("", "")      = ""
	 * StringUtils.defaultIfNull("   ", "")   = "   "
	 * StringUtils.defaultIfNull("han", "")   = "han"
	 * StringUtils.defaultIfNull(" han ", "") = " han "
	 * </pre>
	 *
	 * @param str 문자열
	 * @param defaultStr 기본문자열
	 * @return
	 */
	public static String defaultIfNull(String str, String defaultStr) {
		return str == null ? defaultStr : str;
	}

	/**
	 * <p>문자열(String)이 <code>null</code>이면 공백문자열을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.defaultIfNull(null)    = ""
	 * StringUtils.defaultIfNull("")      = ""
	 * StringUtils.defaultIfNull("   ")   = "   "
	 * StringUtils.defaultIfNull("han")   = "han"
	 * StringUtils.defaultIfNull(" han ") = " han "
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String defaultIfNull(String str) {
		return defaultIfNull(str, EMPTY);
	}

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한후, 공백("")이거나 <code>null</code>이면, 기본문자열을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.defaultIfBlank(null, "")    = ""
	 * StringUtils.defaultIfBlank("", "")      = ""
	 * StringUtils.defaultIfBlank("   ", "")   = ""
	 * StringUtils.defaultIfBlank("han", "")   = "han"
	 * StringUtils.defaultIfBlank(" han ", "") = " han "
	 * </pre>
	 *
	 * @param str 문자열
	 * @param defaultStr 기본문자열
	 * @return
	 */
	public static String defaultIfBlank(String str, String defaultStr) {
		return isBlank(str) ? defaultStr : str;
	}

	/**
	 * <p>문자열(String)의 좌우 여백문자(white space)를 제거한후, 공백("")이거나 <code>null</code>이면, 공백문자열을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.defaultIfBlank(null)    = ""
	 * StringUtils.defaultIfBlank("")      = ""
	 * StringUtils.defaultIfBlank("   ")   = ""
	 * StringUtils.defaultIfBlank("han")   = "han"
	 * StringUtils.defaultIfBlank(" han ") = " han "
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String defaultIfBlank(String str) {
		return defaultIfBlank(str, EMPTY);
	}


	// ----------------------------------------------------------------------
	// 문자열 비교
	// ----------------------------------------------------------------------
	/**
	 * <p>두 문자열(String)이 일치하면 <code>true</code>을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.equals(null, null)   = true
	 * StringUtils.equals(null, "")     = false
	 * StringUtils.equals("", null)     = false
	 * StringUtils.equals(null, "han")  = false
	 * StringUtils.equals("han", null)  = false
	 * StringUtils.equals("han", "han") = true
	 * StringUtils.equals("han", "HAN") = false
	 * </pre>
	 *
	 * @see java.lang.String#equals(Object)
	 * @param str1 첫번째 문자열
	 * @param str2 두번째 문자열
	 * @return 문자열(String)이 일치하면 <code>true</code>
	 */
	public static boolean equals(String str1, String str2) {
		return str1 == null ? str2 == null : str1.equals(str2);
	}

	/**
	 * <p>대소문자를 무시한, 두 문자열(String)이 일치하면 <code>true</code>을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.equalsIgnoreCase(null, null)   = true
	 * StringUtils.equalsIgnoreCase(null, "")     = false
	 * StringUtils.equalsIgnoreCase("", null)     = false
	 * StringUtils.equalsIgnoreCase(null, "han")  = false
	 * StringUtils.equalsIgnoreCase("han", null)  = false
	 * StringUtils.equalsIgnoreCase("han", "han") = true
	 * StringUtils.equalsIgnoreCase("han", "HAN") = true
	 * </pre>
	 *
	 * @see java.lang.String#equalsIgnoreCase(String)
	 * @param str1 첫번째 문자열
	 * @param str2 두번째 문자열
	 * @return 대소문자를 무시한 문자열(String)이 일치하면 <code>true</code>
	 */
	public static boolean equalsIgnoreCase(String str1, String str2) {
		return str1 == null ? str2 == null : str1.equalsIgnoreCase(str2);
	}

	/**
	 * <p>문자열이 접두사로 시작하는지를 판단한다.</p>
	 *
	 * <pre>
	 * StringUtils.startsWith(null, *)    = false
	 * StringUtils.startsWith(*, null)    = false
	 * StringUtils.startsWith("han", "h") = true
	 * StringUtils.startsWith("han", "a") = false
	 * </pre>
	 *
	 * @param str 문자열
	 * @param prefix 접두사
	 * @return
	 */
	public static boolean startsWith(String str, String prefix) {
		if (str == null || prefix == null) {
			return false;
		}
		return str.startsWith(prefix);
	}

	/**
	 * <p>문자열 offset 위치부터 접두사로 시작하는지를 판단한다.</p>
	 *
	 * <pre>
	 * StringUtils.startsWith(null, *, 0)    = false
	 * StringUtils.startsWith(*, null, 0)    = false
	 * StringUtils.startsWith("han", "h", 0) = true
	 * StringUtils.startsWith("han", "a", 0) = false
	 * StringUtils.startsWith("han", "a", 1) = true
	 * </pre>
	 *
	 * @param str 문자열
	 * @param prefix 접두사
	 * @param offset 비교 시작 위치
	 * @return
	 */
	public static boolean startsWith(String str, String prefix, int offset) {
		if (str == null || prefix == null) {
			return false;
		}
		return str.startsWith(prefix, offset);
	}

	/**
	 * <p>문자열이 접미사로 끝나는지를 판단한다.</p>
	 *
	 * <pre>
	 * StringUtils.endsWith(null, *)    = false
	 * StringUtils.endsWith(*, null)    = false
	 * StringUtils.endsWith("han", "h") = false
	 * StringUtils.endsWith("han", "n") = true
	 * </pre>
	 *
	 * @param str 문자열
	 * @param prefix 접두사
	 * @return
	 */
	public static boolean endsWith(String str, String suffix) {
		if (str == null || suffix == null) {
			return false;
		}
		return str.endsWith(suffix);
	}

	/**
	 * <p>문자열(String)에 검색문자열(String)이 포함되어 있는지 검사한다.</p>
	 *
	 * <pre>
	 * StringUtils.contains(null, *)    = false
	 * StringUtils.contains(*, null)    = false
	 * StringUtils.contains("han", "")  = true
	 * StringUtils.contains("han", "h") = true
	 * StringUtils.contains("han", "H") = false
	 * </pre>
	 *
	 * @see java.lang.String#indexOf(String)
	 * @param str 문자열
	 * @param searchStr 검색문자열
	 * @return 문자열(String)에 검색 문자열이 포함되어 있을때 <code>true</code>,
	 *  문자열(String)에 검색 문자열이 포함되어 있지 않을때나, 문자열 또는 검색문자열이 <code>null</code>일때 <code>false</code>
	 */
	public static boolean contains(String str, String searchStr) {
		if (str == null || searchStr == null) {
			return false;
		}
		return str.indexOf(searchStr) > INDEX_NOT_FOUND;
	}

	// ----------------------------------------------------------------------
	// 대/소문자 변환
	// ----------------------------------------------------------------------
	/**
	 * <p>문자열(String)을 대문자로 변환한다.</p>
	 *
	 * <pre>
	 * StringUtils.toUpperCase(null)  = null
	 * StringUtils.toUpperCase("han") = "HAN"
	 * StringUtils.toUpperCase("hAn") = "HAN"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return 대문자로 변환한 문자열
	 */
	public static String toUpperCase(String str) {
		if (str == null) {
			return null;
		}
		return str.toUpperCase();
	}

	/**
	 * <p>시작 인덱스부터 종료 인덱스까지 대문자로 변환한다.</p>
	 *
	 * <pre>
	 * StringUtils.toUpperCase(null, *, *)  = null
	 * StringUtils.toUpperCase("han", 0, 1) = "Han"
	 * StringUtils.toUpperCase("han", 0, 2) = "HAn"
	 * StringUtils.toUpperCase("han", 0, 3) = "HAN"
	 * </pre>
	 *
	 * @param str
	 * @param begin
	 * @param end
	 * @return
	 */
	public static String toUpperCase(String str, int begin, int end) {
		StringBuilder sb = null;
		String strReturn = null;
		int setBegin = begin;
		int setEnd = end;
		if (str != null) {
			sb = new StringBuilder();
			if (setBegin < 0) {
				setBegin = 0;
			}
			if (setEnd > str.length()) {
				setEnd = str.length();
			}
			if (setBegin > 0) {
				sb.append(str.substring(0, setBegin));
			}
			sb.append(str.substring(setBegin, setEnd).toUpperCase());
			if (setEnd < str.length()) {
				sb.append(str.substring(setEnd));
			}
			strReturn = sb.toString();
		}
		return strReturn;
	}

	/**
	 * <p>문자열(String)을 소문자로 변환한다.</p>
	 *
	 * <pre>
	 * StringUtils.toLowerCase(null)  = null
	 * StringUtils.toLowerCase("han") = "han"
	 * StringUtils.toLowerCase("hAn") = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return 소문자로 변환한 문자열
	 */
	public static String toLowerCase(String str) {
		if (str == null) {
			return null;
		}
		return str.toLowerCase();
	}

	/**
	 * <p>시작 인덱스부터 종료 인덱스까지 소문자로 변환한다.</p>
	 *
	 * <pre>
	 * StringUtils.toLowerCase(null, *, *)  = null
	 * StringUtils.toLowerCase("HAN", 0, 1) = "hAN"
	 * StringUtils.toLowerCase("HAN", 0, 2) = "haN"
	 * StringUtils.toLowerCase("HAN", 0, 3) = "han"
	 * </pre>
	 *
	 * @param str
	 * @param begin
	 * @param end
	 * @return
	 */
	public static String toLowerCase(String str, int begin, int end) {
		StringBuilder sb = null;
		String strReturn = null;
		int setBegin = begin;
		int setEnd = end;
		if (str != null) {
			sb = new StringBuilder();
			if (setBegin < 0) {
				setBegin = 0;
			}
			if (setEnd > str.length()) {
				setEnd = str.length();
			}
			if (setBegin > 0) {
				sb.append(str.substring(0, setBegin));
			}
			sb.append(str.substring(setBegin, setEnd).toLowerCase());
			if (setEnd < str.length()) {
				sb.append(str.substring(setEnd));
			}
			strReturn = sb.toString();
		}
		return strReturn;
	}

	/**
	 * <p>대문자는 소문자로 변환하고 소문자는 대문자로 변환한다.</p>
	 *
	 * <pre>
	 * StringUtils.swapCase(null)  = null
	 * StringUtils.swapCase("Han") = "hAN"
	 * StringUtils.swapCase("hAn") = "HaN"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String swapCase(String str) {
		if (str == null) {
			return null;
		}
		char[] charArray = str.toCharArray();
		for (int i = 0; i < charArray.length; i++) {
			if (Character.isLowerCase(charArray[i])) {
				charArray[i] = Character.toUpperCase(charArray[i]);
			} else {
				charArray[i] = Character.toLowerCase(charArray[i]);
			}
		}

		return new String(charArray);
	}

	/**
	 * 문자열(String)의 첫번째 문자를 대문자로 변환한다.
	 *
	 * <pre>
	 * StringUtils.capitalize(null)  = null
	 * StringUtils.capitalize("Han") = "Han"
	 * StringUtils.capitalize("han") = "Han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return 첫번째 문자를 대문자로 변환한 문자열
	 */
	public static String capitalize(String str) {
		if (str == null) {
			return null;
		}
		char[] charArray = str.toCharArray();
		if (charArray.length > 0) {
			charArray[0] = Character.toUpperCase(charArray[0]);
		}
		return new String(charArray);
	}

	/**
	 * 문자열(String)의 첫번째 문자를 소문자로 변환한다.
	 *
	 * <pre>
	 * StringUtils.uncapitalize(null)  = null
	 * StringUtils.uncapitalize("han") = "han"
	 * StringUtils.uncapitalize("HAN") = "hAN"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return 첫번째 문자를 대문자로 변환한 문자열
	 */
	public static String uncapitalize(String str) {
		if (str == null) {
			return null;
		}
		char[] charArray = str.toCharArray();
		if (charArray.length > 0) {
			charArray[0] = Character.toLowerCase(charArray[0]);
		}
		return new String(charArray);
	}

	// ----------------------------------------------------------------------
	// 문자열 배열 결합/분리
	// ----------------------------------------------------------------------
	/**
	 * <p>문자열 배열을 하나의 문자열로 결합시킨다.</p>
	 * <p>배열의 문자열 중에 <code>null</code>과 공백("")은 무시한다.</p>
	 *
	 * <pre>
	 * StringUtils.compose(null, *)               = ""
	 * StringUtils.compose(["h", "a", "n"], ".")  = "h.a.n"
	 * StringUtils.compose([null, "a", "n"], ".") = "a.n"
	 * StringUtils.compose(["", "a", "n"], ".")   = "a.n"
	 * StringUtils.compose(["h", "", "n"], ".")   = "h.n"
	 * StringUtils.compose(["  ", "a", "n"], ".") = "  .a.n"
	 * </pre>
	 *
	 * @param strArray 문자열 배열
	 * @param separator 구분자
	 * @return 구분자로 결합한 문자열
	 */
	public static String compose(String[] strArray, char separator) {
		StringBuilder sb = new StringBuilder();
		if (strArray != null) {
			for (int i = 0; i < strArray.length; i++) {
				if (StringUtils.isEmpty(strArray[i])) {
					sb.append(EMPTY);
				} else {
					if (sb.length() > 0) {
						sb.append(separator);
					}
					sb.append(strArray[i]);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * <p>문자열 배열을 하나의 문자열로 결합시킨다.</p>
	 * <p>배열의 문자열 중에 <code>null</code>과 공백("")은 무시한다.</p>
	 *
	 * <pre>
	 * StringUtils.compose(null, *)               = ""
	 * StringUtils.compose(["h", "a", "n"], ".")  = "h.a.n"
	 * StringUtils.compose([null, "a", "n"], ".") = "a.n"
	 * StringUtils.compose(["", "a", "n"], ".")   = "a.n"
	 * StringUtils.compose(["h", "", "n"], ".")   = "h.n"
	 * StringUtils.compose(["  ", "a", "n"], ".") = "  .a.n"
	 * </pre>
	 *
	 * @param strArray 문자열 배열
	 * @param separator 구분자
	 * @return 구분자로 결합한 문자열
	 */
	public static String compose(String[] strArray, String separator) {
		StringBuilder sb = new StringBuilder();
		if (strArray != null) {
			for (int i = 0; i < strArray.length; i++) {
				if (StringUtils.isEmpty(strArray[i])) {
					sb.append(EMPTY);
				} else {
					if (sb.length() > 0) {
						sb.append(separator);
					}
					sb.append(strArray[i]);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * <p>문자열 배열을 하나의 문자열로 결합시킨다.</p>
	 * <p>배열의 문자열 중에 <code>null</code>과 공백("")도 포함한다.</p>
	 *
	 * <pre>
	 * StringUtils.join(null, *)               = ""
	 * StringUtils.join(["h", "a", "n"], '-')  = "h-a-n"
	 * StringUtils.join([null, "a", "n"], '-') = "-a-n"
	 * StringUtils.join(["", "a", "n"], '-')   = "-a-n"
	 * StringUtils.join(["h", "", "n"], '-')   = "h--n"
	 * StringUtils.join(["  ", "a", "n"], '-') = "  -a-n"
	 * </pre>
	 *
	 * @param strArray 문자열 배열
	 * @param separator 구분자
	 * @return 구분자로 결합한 문자열
	 */
	public static String join(String[] strArray, char separator) {
		StringBuilder sb = new StringBuilder();
		if (strArray != null) {
			boolean isFirst = true;
			for (int i = 0; i < strArray.length; i++) {
				if (isFirst) {
					isFirst = false;
				} else {
					sb.append(separator);
				}
				if (StringUtils.isEmpty(strArray[i])) {
					sb.append(EMPTY);
				} else {
					sb.append(strArray[i]);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * <p>문자열 배열을 하나의 문자열로 결합시킨다.</p>
	 * <p>배열의 문자열 중에 <code>null</code>과 공백("")도 포함한다.</p>
	 *
	 * <pre>
	 * StringUtils.join(null, *)               = ""
	 * StringUtils.join(["h", "a", "n"], "-")  = "h-a-n"
	 * StringUtils.join([null, "a", "n"], "-") = "-a-n"
	 * StringUtils.join(["", "a", "n"], "-")   = "-a-n"
	 * StringUtils.join(["h", "", "n"], "-")   = "h--n"
	 * StringUtils.join(["  ", "a", "n"], "-") = "  -a-n"
	 * </pre>
	 *
	 * @param strArray 문자열 배열
	 * @param separator 구분자
	 * @return 구분자로 결합한 문자열
	 */
	public static String join(String[] strArray, String separator) {
		StringBuilder sb = new StringBuilder();
		if (strArray != null) {
			boolean isFirst = true;
			for (int i = 0; i < strArray.length; i++) {
				if (isFirst) {
					isFirst = false;
				} else {
					sb.append(separator);
				}
				if (StringUtils.isEmpty(strArray[i])) {
					sb.append(EMPTY);
				} else {
					sb.append(strArray[i]);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * <p>문자열을 구분자로 나누어서, 문자열 배열로 만든다.</p>
	 * <p>배열의 문자열 중에 <code>null</code>과 공백("")도 포함한다.</p>
	 *
	 * <pre>
	 * StringUtils.split("h-a-n", '-') = ["h", "a", "n"]
	 * StringUtils.split("h--n", '-')  = ["h", "", "n"]
	 * StringUtils.split(null, *)      = null
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return 구분자로 나누어진 문자열 배열
	 */
	public static String[] split(String str, char separator) {
		return split(str, new String(new char[]{separator}));
	}

	/**
	 * <p>문자열을 구분자로 나누어서, 문자열 배열로 만든다.</p>
	 * <p>배열의 문자열 중에 <code>null</code>과 공백("")도 포함한다.</p>
	 *
	 * <pre>
	 * StringUtils.split("h-a-n", "-") = ["h", "a", "n"]
	 * StringUtils.split("h--n", "-")  = ["h", "", "n"]
	 * StringUtils.split(null, *)      = null
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return 구분자로 나누어진 문자열 배열
	 */
	public static String[] split(String str, String separator) {
		if (str == null) {
			return null;
		}
		StrTokenizer tokenizer = new StrTokenizer(str, separator);
		return tokenizer.toArray();
	}

	// ----------------------------------------------------------------------
	// 문자열 자르기
	// ----------------------------------------------------------------------
	/**
	 * <p>문자열(String)을 해당 길이(<code>length</code>) 만큼, 왼쪽부터 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.left(null, *)    = null
	 * StringUtils.left(*, -length) = ""
	 * StringUtils.left("", *)      = *
	 * StringUtils.left("han", 0)   = ""
	 * StringUtils.left("han", 1)   = "h"
	 * StringUtils.left("han", 11)  = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param length 길이
	 * @return
	 */
	public static String left(String str, int length) {
		if (str == null) {
			return null;
		}
		if (length < 0) {
			return EMPTY;
		}
		if (str.length() <= length) {
			return str;
		}
		return str.substring(0, length);
	}

	/**
	 * <p>문자열(String)을 해당 길이(<code>length</code>) 만큼, 오른쪽부터 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.right(null, *)    = null
	 * StringUtils.right(*, -length) = ""
	 * StringUtils.right("", *)      = *
	 * StringUtils.right("han", 0)   = ""
	 * StringUtils.right("han", 1)   = "n"
	 * StringUtils.right("han", 11)  = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param length 길이
	 * @return
	 */
	public static String right(String str, int length) {
		if (str == null) {
			return null;
		}
		if (length < 0) {
			return EMPTY;
		}
		if (str.length() <= length) {
			return str;
		}
		return str.substring(str.length() - length);
	}

	/**
	 * <p>문자열(String)을 시작 위치(<code>begin</code>)부터 길이( <code>length</code>) 만큼 자른다.</p>
	 *
	 * <p>시작 위치(<code>begin</code>)가 음수일 경우는 0으로 자동 변환된다.</p>
	 *
	 * <pre>
	 * StringUtils.mid(null, *, *)    = null
	 * StringUtils.mid(*, *, -length) = ""
	 * StringUtils.mid("han", 0, 1)   = "h"
	 * StringUtils.mid("han", 0, 11)  = "han"
	 * StringUtils.mid("han", 2, 3)   = "n"
	 * StringUtils.mid("han", -2, 3)  = "han"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param begin 위치(음수일 경우는 0으로 자동 변환된다.)
	 * @param length 길이
	 * @return
	 */
	public static String mid(String str, int begin, int length) {
		String strReturn = null;
		int setBegin = begin;
		if (str != null) {
			if (setBegin < 0 || setBegin > str.length()) {
				strReturn = EMPTY;
			}else{
				if (setBegin < 0) {
					setBegin = 0;
				}
				if (str.length() <= (setBegin + length)) {
					strReturn = str.substring(setBegin);
				}else{
					strReturn = str.substring(setBegin, setBegin + length);
				}
			}
		}
		return strReturn;
	}

	/**
	 * <p>시작 인덱스부터 문자열을 자는다.</p>
	 * <p>시작 인덱스가 0보다 작거나, 문자열의 총길이보다 크면 공백("")을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.substring(null, *)    = null
	 * StringUtils.substring("", *)      = ""
	 * StringUtils.substring("han", 1)   = "an"
	 * StringUtils.substring("han", 615) = ""
	 * StringUtils.substring("han", -1)  = ""
	 * </pre>
	 *
	 * @param str
	 * @param begin 시작 인덱스(0부터 시작)
	 * @return
	 */
	public static String substring(String str, int begin) {
		if (str == null){
			return null;
		}

		if (begin < 0) {
			return EMPTY;
		}

		if (begin > str.length()) {
			return EMPTY;
		}

		return str.substring(begin);
	}

	/**
	 * <p>시작 인덱스부터 끝 인덱스까지 문자열을 자는다.</p>
	 * <p>시작 인덱스또는 끝 인덱스가  0보다 작으면 공백("")을 반환한다.</p>
	 *
	 * <pre>
	 * StringUtils.substring(null, *, *)    = null
	 * StringUtils.substring("", *, *)      = ""
	 * StringUtils.substring("han", 1, 2)   = "a"
	 * StringUtils.substring("han", 1, 3)   = "an"
	 * StringUtils.substring("han", 1, 615) = "an"
	 * StringUtils.substring("han", -1, *)  = ""
	 * StringUtils.substring("han", *, -1)  = ""
	 * </pre>
	 *
	 * @param str
	 * @param begin
	 * @param end
	 * @return
	 */
	public static String substring(String str, int begin, int end) {
		String strReturn = null;
		int setBegin = begin;
		int setEnd = end;
		if (str != null){
			if (setBegin < 0 || setEnd < 0) {
				strReturn = EMPTY;
			}else{
				if (setEnd > str.length()) {
					setEnd = str.length();
				}
				if (setBegin > setEnd || setBegin > str.length()) {
					strReturn = EMPTY;
				}else{
					strReturn = str.substring(setBegin, setEnd);
				}
			}
		}
		return strReturn;
	}

	/**
	 * <p>처음 발견한 구분자의 위치까지 문자열을 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.substringBefore(null, *)       = null
	 * StringUtils.substringBefore("", *)         = ""
	 * StringUtils.substringBefore("han", null)   = "han"
	 * StringUtils.substringBefore("han", "")     = ""
	 * StringUtils.substringBefore("hanhan", "a") = "h"
	 * StringUtils.substringBefore("hanhan", "g") = "hanhan"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return
	 */
	public static String substringBefore(String str, String separator) {
		if (isEmpty(str) || separator == null) {
			return str;
		}
        if (separator.length() == 0) {
            return EMPTY;
        }
		int end = str.indexOf(separator);
		if (end == INDEX_NOT_FOUND) {
			return str;
		}
		return str.substring(0, end);
	}

	/**
	 * <p>마지막으로 발견한 구분자의 위치까지 문자열을 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.substringBeforeLast(null, *)       = null
	 * StringUtils.substringBeforeLast("", *)         = ""
	 * StringUtils.substringBeforeLast("han", null)   = "han"
	 * StringUtils.substringBeforeLast("han", "")     = "han"
	 * StringUtils.substringBeforeLast("hanhan", "a") = "hanh"
	 * StringUtils.substringBeforeLast("hanhan", "g") = "hanhan"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return
	 */
	public static String substringBeforeLast(String str, String separator) {
		if (isEmpty(str) || isEmpty(separator)) {
			return str;
		}
		int end = str.lastIndexOf(separator);
		if (end == INDEX_NOT_FOUND) {
			return str;
		}
		return str.substring(0, end);
	}

	/**
	 * <p>처음 발견한 구분자의 위치 다음부터 문자열을 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.substringAfter(null, *)       = null
	 * StringUtils.substringAfter("", *)         = ""
	 * StringUtils.substringAfter("han", null)   = ""
	 * StringUtils.substringAfter("han", "")     = "han"
	 * StringUtils.substringAfter("hanhan", "a") = "nhan"
	 * StringUtils.substringAfter("hanhan", "g") = ""
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return
	 */
	public static String substringAfter(String str, String separator) {
		if (isEmpty(str)) {
			return str;
		}
		if (separator == null) {
			return EMPTY;
		}
		int begin = str.indexOf(separator);
		if (begin == INDEX_NOT_FOUND) {
			return EMPTY;
		}
		begin = begin + separator.length();
		if (begin == str.length()) {
			return EMPTY;
		}
		return str.substring(begin);
	}

	/**
	 * <p>마지막으로 발견한 구분자의 위치 다음부터 문자열을 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.substringAfterLast(null, *)       = null
	 * StringUtils.substringAfterLast("", *)         = ""
	 * StringUtils.substringAfterLast("han", null)   = ""
	 * StringUtils.substringAfterLast("han",     "") = ""
	 * StringUtils.substringAfterLast("hanhan", "a") = "n"
	 * StringUtils.substringAfterLast("hanhan", "g") = ""
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return
	 */
	public static String substringAfterLast(String str, String separator) {
		if (isEmpty(str)) {
			return str;
		}
		if (isEmpty(separator)) {
			return EMPTY;
		}
		int begin = str.lastIndexOf(separator);
		if (begin == INDEX_NOT_FOUND) {
			return EMPTY;
		}
		begin = begin + separator.length();
		if (begin == str.length()) {
			return EMPTY;
		}
		return str.substring(begin);
	}

	/**
	 * <p>시작 문자부터 끝 문자열까지 자른다.</p>
	 *
	 * <pre>
	 * StringUtils.substringBetween(null, *, *)       = null
	 * StringUtils.substringBetween(*, null, *)       = null
	 * StringUtils.substringBetween(*, *, null)       = null
	 * StringUtils.substringBetween("h<a>n", "<", ">") = "a"
	 * StringUtils.substringBetween("h<a><b>n", "<", ">") = "a"
	 * </pre>
	 *
	 * @param str 문자열
	 * @param separator 구분자
	 * @return
	 * @since 1.1
	 */
    public static String substringBetween(String str, String open, String close) {
		if (str == null || open == null || close == null) {
			return null;
		}

		int start = str.indexOf(open);
		if (start != INDEX_NOT_FOUND) {
			int end = str.indexOf(close, start + open.length());
			if (end != INDEX_NOT_FOUND) {
				return str.substring(start + open.length(), end);
			} else {
				// 끝이 없으면 null이 좋을까, 끝까지가 좋을까...
			}
		}
		return null;
	}

    /**
     * <p>입력한 문자열을 한줄의 최대 길이만큼, 여러 줄로 나누어 반환한다.</p>
     * <p>공백(" ")을 기준으로 줄 바꿈을 시도한다.</p>
     *
     * @param str
     * @param maxLineLength 한줄의 최대 길이
     * @return
     */
    public static List<String> wrap(String str, int maxLineLength) {
    	if (str == null) {
    		return null;
    	}
    	List<String> lines = new ArrayList<String>();
        if (str.length() <= maxLineLength || str.indexOf(' ') == INDEX_NOT_FOUND) {
        	// 전체 길이가 최대 길이보다 짧거나, 구분할수 있는 조건이 안되면 그대로 반환한다.
        	lines.add(str);
            return lines;
        }

        StringBuilder sb = new StringBuilder();
        StringTokenizer tokenzier = new StringTokenizer(str, " ");
        sb.append(tokenzier.nextToken());
        while (tokenzier.hasMoreTokens()) {
            String token = tokenzier.nextToken();
            if ( (sb.length() + token.length() + 1) > maxLineLength) {
                lines.add(sb.toString());
                sb.setLength(0);
                sb.append(token);
            } else {
                sb.append(" ");
                sb.append(token);
            }
        }

        if (sb.toString().trim().length() > 0) {
            lines.add(sb.toString());
        }
        return lines;
    }

	/**
	 * <p>문자열이 해당 길이보다 크면, 자른 후 줄임말을 붙여준다.</p>
	 * <p>길이는 기본문자들(영어/숫자등)이 1으로, 다국어(한글등)이면 2로 계산한다.</p>
	 *
	 * <pre>
	 * StringUtils.curtail(null, *, *) = null
	 * StringUtils.curtail("abcdefghijklmnopqr", 10, null) = "abcdefghij"
	 * StringUtils.curtail("abcdefghijklmnopqr", 10, "..") = "abcdefgh.."
	 * StringUtils.curtail("한글을 사랑합시다.", 10, null)   = "한글을 사랑"
	 * StringUtils.curtail("한글을 사랑합시다.", 10, "..")   = "한글을 사.."
	 * </pre>
	 *
	 *
	 * @param str 문자열
	 * @param size 길이(byte 길이)
	 * @param tail 줄임말
	 * @return
	 */
	public static String curtail(String str, int size, String tail) {
		if (str == null) {
			return null;
		}
		int strLen = str.length();
		int tailLen = (tail != null) ? tail.length() : 0;
		int maxLen = size - tailLen;
		int curLen = 0;
		int index = 0;
		for (; index < strLen && curLen < maxLen; index++) {
			if (Character.getType(str.charAt(index)) == Character.OTHER_LETTER) {
				curLen++;
			}
			curLen++;
		}

		if (index == strLen) {
			return str;
		} else {
			StringBuilder result = new StringBuilder();
			result.append(str.substring(0, index));
			if (tail != null) {
				result.append(tail);
			}
			return result.toString();
		}
	}

	// ----------------------------------------------------------------------
	// 패딩
	// ----------------------------------------------------------------------
	/**
	 * <p>왼쪽부터 크기만큼 패딩문자로 채운다.</p>
	 *
	 * <pre>
	 * StringUtils.leftPad("han", 5, " ")    = "  han"
	 * StringUtils.leftPad("han", 5, "123")  = "12han"
	 * StringUtils.leftPad("han", 10, "123") = "1231231han"
	 * StringUtils.leftPad("han", -1, " ")   = "han"
	 * </pre>
	 *
	 * @param str
	 * @param size 크기
	 * @param padStr 패딩문자
	 * @return
	 */
	public static String leftPad(String str, int size, String padStr) {
		String strReturn = null;
		StringBuilder result = null;
		String strPad = padStr;
		if (str != null) {
			if (isEmpty(strPad)) {
				strPad = " "; //$NON-NLS-1$
			}
			int strLen = str.length();
			int padStrLen = strPad.length();
			int padLen = size - strLen;
			if (padLen <= 0) {
				// 패딩할 필요가 없음
				strReturn = str;
			}else{
				result = new StringBuilder();
				if (padLen == padStrLen) {
					result.append(strPad);
					result.append(str);
				} else if (padLen < padStrLen) {
					result.append(strPad.substring(0, padLen));
					result.append(str);
				} else {
					char[] padding = strPad.toCharArray();
					for (int i = 0; i < padLen; i++) {
						result.append(padding[ i % padStrLen]);
					}
					result.append(str);
				}
				strReturn = result.toString();
			}
		}
		return strReturn;
	}

	/**
	 * <p>오른쪽부터 크기만큼 패딩문자로 채운다.</p>
	 *
	 * <pre>
	 * StringUtils.rightPad("han", 5, " ")    = "han  "
	 * StringUtils.rightPad("han", 5, "123")  = "han12"
	 * StringUtils.rightPad("han", 10, "123") = "han1231231"
	 * StringUtils.rightPad("han", -1, " ")   = "han"
	 * </pre>
	 *
	 * @param str
	 * @param size 크기
	 * @param padStr 패딩문자
	 * @return
	 */
	public static String rightPad(String str, int size, String padStr) {
		String strReturn = null;
		StringBuilder result = null;
		String strPad = padStr;
		if (str != null) {
			if (isEmpty(strPad)) {
				strPad = " "; //$NON-NLS-1$
			}
			int strLen = str.length();
			int padStrLen = strPad.length();
			int padLen = size - strLen;
			if (padLen <= 0) {
				// 패딩할 필요가 없음
				strReturn = str;
			}else{
				result = new StringBuilder();
				if (padLen == padStrLen) {
					result.append(str);
					result.append(strPad);
				} else if (padLen < padStrLen) {
					result.append(str);
					result.append(strPad.substring(0, padLen));
				} else {
					result.append(str);
					char[] padding = strPad.toCharArray();
					for (int i = 0; i < padLen; i++) {
						result.append(padding[ i % padStrLen]);
					}
				}
				strReturn = result.toString();
			}
		}
		return strReturn;
	}

	//html tag 및 스크립트 제거 함수
	public static String stripTags(String strContent){
		String strReturn = null;
		if(strContent!=null && strContent.length()>0){
			strReturn = strContent.replaceAll("\\<(\\/?)(\\w+)*([^<>]*)>", "");
			strReturn = strReturn.replaceAll("(?i)\\<script(.*?)</script>", "");
			strReturn = strReturn.replaceAll("(?i) onmouseover=[\"']?([^>\"']+)[\"']*", "");
			strReturn = strReturn.replaceAll("(?i) onmouseout=[\"']?([^>\"']+)[\"']*", "");
			strReturn = strReturn.replaceAll("(?i) onclick=[\"']?([^>\"']+)[\"']*", "");
		}

		return strReturn;
	}

    public static String getBrLineString( String body )
    {
        String sb = "";

        try
        {
            sb = body.replaceAll( "\r\n", "<br>" );
        }
        catch(Exception ee)
        {
            sb = "";
        }
        return sb;
    }

    public static String getBrLineBlank( String body )
    {
        String sb = "";

        try
        {
            sb = body.replaceAll( "\r\n", " " );
        }
        catch(Exception ee)
        {
            sb = "";
        }
        return sb;
    }

    public static String getStripTag( String body )
    {
        String retValue = "";
//        ArrayList<String> strScriptList = null;
        Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");

        if(body!=null && body.length()>0){
	        Matcher m = p.matcher(body);
	        retValue = m.replaceAll("");
        }else
        	retValue = body;

        if(retValue!=null){
	        retValue = retValue.replaceAll( "'", "" );
	        retValue = retValue.replaceAll( "\"", "" );
	        retValue = retValue.replaceAll( ">", "&gt;" );
/*
	        retValue = retValue.replaceAll( "-", "" );
	        retValue = retValue.replaceAll( "#", "" );
	        retValue = retValue.replaceAll( ";", "" );
	        retValue = retValue.replaceAll( "/", "" );
	        retValue = retValue.replaceAll( ",", "" );
	        retValue = retValue.replaceAll( "(", "" );
	        retValue = retValue.replaceAll( ")", "" );
	        retValue = retValue.replaceAll( "%", "" );

			strScriptList = new ArrayList<String>();
			strScriptList.add("location");
			strScriptList.add("href");
			strScriptList.add("style");
			strScriptList.add("document");
			strScriptList.add("img");
			strScriptList.add("script");
			strScriptList.add("cookie");
			strScriptList.add("alert");

			for(int j = 0; j<strScriptList.size(); j++){
				retValue = retValue.replaceAll("(?i)"+strScriptList.get(j), "");
			}

	        XssFilter filter = XssFilter.getInstance(true);
	        retValue = filter.doFilter(retValue);
*/
        }

        return retValue;
    }
    /**
     * 기본값 추가  - 정승탁
     * @param body
     * @param defaultValue - 없을 경우 기본 값 설정
     * @return
     */
    public static String getStripTag( String body , String defaultValue )
    {
        String retValue = "";
//        ArrayList<String> strScriptList = null;
        Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");

        if(body!=null && body.length()>0){
	        Matcher m = p.matcher(body);
	        retValue = m.replaceAll("");
        }else
        	retValue = body;

        if(retValue!=null){
	        retValue = retValue.replaceAll( "'", "" );
	        retValue = retValue.replaceAll( "\"", "" );
	        retValue = retValue.replaceAll( ">", "&gt;" );
/*
	        retValue = retValue.replaceAll( "-", "" );
	        retValue = retValue.replaceAll( "#", "" );
	        retValue = retValue.replaceAll( ";", "" );
	        retValue = retValue.replaceAll( "/", "" );
	        retValue = retValue.replaceAll( ",", "" );
	        retValue = retValue.replaceAll( "(", "" );
	        retValue = retValue.replaceAll( ")", "" );
	        retValue = retValue.replaceAll( "%", "" );

			strScriptList = new ArrayList<String>();
			strScriptList.add("location");
			strScriptList.add("href");
			strScriptList.add("style");
			strScriptList.add("document");
			strScriptList.add("img");
			strScriptList.add("script");
			strScriptList.add("cookie");
			strScriptList.add("alert");

			for(int j = 0; j<strScriptList.size(); j++){
				retValue = retValue.replaceAll("(?i)"+strScriptList.get(j), "");
			}

	        XssFilter filter = XssFilter.getInstance(true);
	        retValue = filter.doFilter(retValue);
*/
        }
        if(retValue == null || retValue.length()==0)
        {
        	retValue = defaultValue;
        }
        return retValue;
    }

    public static String getBrStripString( String body )
    {
        return getBrLineString( getStripTag( body ) );

    }

    public static String getBrStripBlank( String body )
    {
        return getBrLineBlank( getStripTag( body ) );

    }

    public static String getStripXss( String body )
    {
        String sb = "";

        try
        {
            sb = body.replaceAll( "--", "" );
            sb = sb.replaceAll( "'", "" );
            sb = sb.replaceAll( "/", "" );
            sb = sb.replaceAll( ";", "" );

            sb = sb.replaceAll( "create", "" );
            sb = sb.replaceAll( "drop", "" );
            sb = sb.replaceAll( "alter", "" );
            sb = sb.replaceAll( "insert", "" );
            sb = sb.replaceAll( "update", "" );
            sb = sb.replaceAll( "delete", "" );
        }
        catch(Exception ee)
        {
            sb = "";
        }
        return sb;
    }

    public static String encodeURIComponent(String input) {
    	if(StringUtils.isEmpty(input)) {
    		return input;
    	}
    	int l = input.length();
    	StringBuilder o = new StringBuilder(l * 3);
    	try {
    		for (int i = 0; i < l; i++) {
    			String e = input.substring(i, i + 1);
    			if (ALLOWED_CHARS.indexOf(e) == -1) {
    				byte[] b = e.getBytes("utf-8");
    				o.append(getHex(b));
    				continue;
    			}
    			o.append(e);
    		}
    		return o.toString();
    	} catch(UnsupportedEncodingException e) {

    	}
    	return input;
    }

    private static String getHex(byte buf[]) {
    	StringBuilder o = new StringBuilder(buf.length * 3);
    	for (int i = 0; i < buf.length; i++) {
    		int n = (int) buf[i] & 0xff;
    		o.append("%");
    		if (n < 0x10) {
    			o.append("0");
    		}
    		o.append(Long.toString(n, 16).toUpperCase());
    	}
    	return o.toString();
    }

    public static String decodeURIComponent(String encodedURI) {
    	char actualChar;
    	StringBuffer buffer = new StringBuffer();
    	int bytePattern, sumb = 0;
    	for (int i = 0, more = -1; i < encodedURI.length(); i++) {
    		actualChar = encodedURI.charAt(i);

    		switch (actualChar) {
	    		case '%': {
	    			actualChar = encodedURI.charAt(++i);
	    			int hb = (Character.isDigit(actualChar) ? actualChar - '0'
	    					: 10 + Character.toLowerCase(actualChar) - 'a') & 0xF;
	    			actualChar = encodedURI.charAt(++i);
	    			int lb = (Character.isDigit(actualChar) ? actualChar - '0'
	    					: 10 + Character.toLowerCase(actualChar) - 'a') & 0xF;
	    			bytePattern = (hb << 4) | lb;
	    			break;
	    		}
	    		case '+': {
	    			bytePattern = ' ';
	    			break;
	    		}
	    		default: {
	    			bytePattern = actualChar;
	    		}
	    	}
    		if ((bytePattern & 0xc0) == 0x80) { // 10xxxxxx
    			sumb = (sumb << 6) | (bytePattern & 0x3f);
    			if (--more == 0)
    				buffer.append((char) sumb);
    		} else if ((bytePattern & 0x80) == 0x00) { // 0xxxxxxx
    			buffer.append((char) bytePattern);
    		} else if ((bytePattern & 0xe0) == 0xc0) { // 110xxxxx
    			sumb = bytePattern & 0x1f;
    			more = 1;
    		} else if ((bytePattern & 0xf0) == 0xe0) { // 1110xxxx
    			sumb = bytePattern & 0x0f;
    			more = 2;
    		} else if ((bytePattern & 0xf8) == 0xf0) { // 11110xxx
    			sumb = bytePattern & 0x07;
    			more = 3;
    		} else if ((bytePattern & 0xfc) == 0xf8) { // 111110xx
    			sumb = bytePattern & 0x03;
    			more = 4;
    		} else { // 1111110x
    			sumb = bytePattern & 0x01;
    			more = 5;
    		}
    	}
    	return buffer.toString();
    }

	public static String replaceSpecial(Object inputObj)
	{
		String strOut = "";

		try
		{
			if(inputObj != null)
			{
				strOut = inputObj.toString();
				strOut = strOut.replaceAll("<", "&lt;");
				strOut = strOut.replaceAll(">", "&gt;");
				strOut = strOut.replaceAll("(", "&#40;");
				strOut = strOut.replaceAll(")", "&#41;");
				strOut = strOut.replaceAll("#", "&#35;");
				strOut = strOut.replaceAll("&", "&#38;");
			}
		}
		catch(Exception e)
		{

		}

		return strOut;
	}

	public static String replaceGeneral(Object inputObj)
	{
		String strOut = "";

		try
		{
			if(inputObj != null)
			{
				strOut = inputObj.toString();
				strOut = strOut.replaceAll("&lt;", "<");
				strOut = strOut.replaceAll("&gt;", ">");
				strOut = strOut.replaceAll("&#40;", "(");
				strOut = strOut.replaceAll("&#41;", ")");
				strOut = strOut.replaceAll("&#35;", "#");
				strOut = strOut.replaceAll("&amp;", "&");
				strOut = strOut.replaceAll("&quot;", "'");
				strOut = strOut.replaceAll("&laquo;", "<<");
				strOut = strOut.replaceAll("&raquo;", ">>");
			}
		}
		catch(Exception e)
		{

		}

		return strOut;
	}

	public static String replaceXSS(Object inputObj)
	{
		String strOut = "";

		try
		{
			if(inputObj != null)
			{
				strOut = inputObj.toString().toLowerCase();
				strOut = strOut.replaceAll("document", "");
				strOut = strOut.replaceAll("alert", "");
				strOut = strOut.replaceAll("cookie", "");
			}
		}
		catch(Exception e)
		{

		}

		return strOut;
	}

	private static final Pattern HTML_SCRIPT = Pattern.compile("\\<script[^>]*?>.*?\\<\\/script\\>", Pattern.CASE_INSENSITIVE);
	private static final Pattern HTML_STYLE = Pattern.compile("\\<style[^>]*?>.*?\\<\\/style\\>", Pattern.CASE_INSENSITIVE);
	private static final Pattern HTML_OPTION = Pattern.compile("\\<option[^>]*?>.*?\\<\\/option\\>", Pattern.CASE_INSENSITIVE);
	private static final Pattern HTML_HEAD = Pattern.compile("\\<head[^>]*?>.*?\\<\\/head\\>", Pattern.CASE_INSENSITIVE);
	//private static final Pattern HTML_TAG = Pattern.compile("\\<.*?\\", Pattern.CASE_INSENSITIVE);

	public static String getStripTagByPattern(String html)
	{
		String strReturn = null;
		strReturn = HTML_SCRIPT.matcher(html).replaceAll("");
		strReturn = HTML_STYLE.matcher(strReturn).replaceAll("");
		strReturn = HTML_OPTION.matcher(strReturn).replaceAll("");
		strReturn = HTML_HEAD.matcher(strReturn).replaceAll("");
		//strReturn = HTML_TAG.matcher(strReturn).replaceAll("");
		return strReturn;
	}

	public static boolean isStringDouble(String str){
		try{
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException e){
			return false;
		}
	}

	/*
	 *  XSS 방지  */
	public static String removeXSS(String str, boolean use_html) {
		String strReturn = str;
		if(strReturn!=null && strReturn.length()>0){
			if(use_html){ // HTML tag를 사용하게 할 경우 부분 허용
				// HTML tag를 모두 제거
				strReturn = strReturn.replaceAll("<","&lt;");
				//strReturn = strReturn.replaceAll(">","&gt;");

				// 특수 문자 제거
				//strReturn = strReturn.replaceAll("\"","&gt;");
				//strReturn = strReturn.replaceAll("&", "&amp;");
				strReturn = strReturn.replaceAll("%00", null);
				//strReturn = strReturn.replaceAll("\"", "&#34;");
				//strReturn = strReturn.replaceAll("\'", "&#39;");
				//strReturn = strReturn.replaceAll("%", "&#37;");
				//strReturn = strReturn.replaceAll("../", "");
				strReturn = strReturn.replaceAll("..\\\\", "");
				//strReturn = strReturn.replaceAll("./", "");
				strReturn = strReturn.replaceAll("%2F", "");

				// 허용할 HTML tag만 변경
				/*
				strReturn = strReturn.replaceAll("&lt;p&gt;", "<p>");
				strReturn = strReturn.replaceAll("&lt;P&gt;", "<P>");
				strReturn = strReturn.replaceAll("&lt;br&gt;", "<br>");
				strReturn = strReturn.replaceAll("&lt;BR&gt;", "<BR>");
				*/
				strReturn = strReturn.replaceAll(" &lt; ", " < ");     // javascript for 문을 위해 허용
				strReturn = strReturn.replaceAll(" &lt;= ", " <= ");     // javascript for 문을 위해 허용
				strReturn = strReturn.replaceAll("&lt;br", "<br");
				strReturn = strReturn.replaceAll("&lt;b", "<b");
				strReturn = strReturn.replaceAll("&lt;/b>", "</b>");
				strReturn = strReturn.replaceAll("&lt;input ", "<input ");

				strReturn = strReturn.replaceAll("&lt;img ", "<img ");
				strReturn = strReturn.replaceAll("&lt;map ", "<map ");
				strReturn = strReturn.replaceAll("&lt;/map>", "</map>");
				strReturn = strReturn.replaceAll("&lt;area ", "<area ");
				strReturn = strReturn.replaceAll("&lt;/area>", "</area>");
				strReturn = strReturn.replaceAll("&lt;script ", "<script ");
				strReturn = strReturn.replaceAll("&lt;/script>", "</script>");
				strReturn = strReturn.replaceAll("&lt;a ", "<a ");
				strReturn = strReturn.replaceAll("&lt;/a>", "</a>");
				strReturn = strReturn.replaceAll("&lt;iframe ", "<iframe ");
				strReturn = strReturn.replaceAll("&lt;/iframe>", "</iframe>");

				strReturn = strReturn.replaceAll("&lt;p", "<p");
				strReturn = strReturn.replaceAll("&lt;/p>", "</p>");
				strReturn = strReturn.replaceAll("&lt;div", "<div");
				strReturn = strReturn.replaceAll("&lt;/div>", "</div>");
				strReturn = strReturn.replaceAll("&lt;span", "<span");
				strReturn = strReturn.replaceAll("&lt;/span>", "</span>");
				strReturn = strReturn.replaceAll("&lt;strong", "<strong");
				strReturn = strReturn.replaceAll("&lt;/strong>", "</strong>");
				strReturn = strReturn.replaceAll("&lt;font", "<font");
				strReturn = strReturn.replaceAll("&lt;/font>", "</font>");
				strReturn = strReturn.replaceAll("&lt;em", "<em");
				strReturn = strReturn.replaceAll("&lt;/em>", "</em>");
				strReturn = strReturn.replaceAll("&lt;ol", "<ol");
				strReturn = strReturn.replaceAll("&lt;/ol>", "</ol>");
				strReturn = strReturn.replaceAll("&lt;li", "<li");
				strReturn = strReturn.replaceAll("&lt;/li>", "</li>");
				strReturn = strReturn.replaceAll("&lt;ul", "<ul");
				strReturn = strReturn.replaceAll("&lt;/ul>", "</ul>");
				strReturn = strReturn.replaceAll("&lt;h1", "<h1");
				strReturn = strReturn.replaceAll("&lt;/h1>", "</h1>");
				strReturn = strReturn.replaceAll("&lt;h2", "<h2");
				strReturn = strReturn.replaceAll("&lt;/h2>", "</h2>");
				strReturn = strReturn.replaceAll("&lt;h3", "<h3");
				strReturn = strReturn.replaceAll("&lt;/h3>", "</h3>");
				strReturn = strReturn.replaceAll("&lt;h4", "<h4");
				strReturn = strReturn.replaceAll("&lt;/h4>", "</h4>");
				strReturn = strReturn.replaceAll("&lt;h5", "<h5");
				strReturn = strReturn.replaceAll("&lt;/h5>", "</h5>");
				strReturn = strReturn.replaceAll("&lt;h6", "<h6");
				strReturn = strReturn.replaceAll("&lt;/h6>", "</h6>");
				strReturn = strReturn.replaceAll("&lt;h7", "<h7");
				strReturn = strReturn.replaceAll("&lt;/h7>", "</h7>");
				strReturn = strReturn.replaceAll("&lt;h8", "<h8");
				strReturn = strReturn.replaceAll("&lt;/h8>", "</h8>");
				strReturn = strReturn.replaceAll("&lt;h9", "<h9");
				strReturn = strReturn.replaceAll("&lt;/h9>", "</h9>");
				strReturn = strReturn.replaceAll("&lt;dl", "<dl");
				strReturn = strReturn.replaceAll("&lt;/dl>", "</dl>");
				strReturn = strReturn.replaceAll("&lt;dt", "<dt");
				strReturn = strReturn.replaceAll("&lt;/dt>", "</dt>");
				strReturn = strReturn.replaceAll("&lt;dd", "<dd");
				strReturn = strReturn.replaceAll("&lt;/dd>", "</dd>");
				strReturn = strReturn.replaceAll("&lt;sup", "<sup");
				strReturn = strReturn.replaceAll("&lt;/sup>", "</sup>");
				strReturn = strReturn.replaceAll("&lt;sub", "<sub");
				strReturn = strReturn.replaceAll("&lt;/sub>", "</sub>");
				strReturn = strReturn.replaceAll("&lt;u", "<u");
				strReturn = strReturn.replaceAll("&lt;/u>", "</u>");
				strReturn = strReturn.replaceAll("&lt;style ", "<style ");
				strReturn = strReturn.replaceAll("&lt;/style>", "</style>");
				strReturn = strReturn.replaceAll("&lt;label ", "<label ");
				strReturn = strReturn.replaceAll("&lt;/label>", "</label>");
				strReturn = strReturn.replaceAll("&lt;article", "<article");
				strReturn = strReturn.replaceAll("&lt;/article>", "</article>");

				strReturn = strReturn.replaceAll("&lt;table", "<table");
				strReturn = strReturn.replaceAll("&lt;/table>", "</table>");
				strReturn = strReturn.replaceAll("&lt;caption", "<caption");
				strReturn = strReturn.replaceAll("&lt;/caption>", "</caption>");
				strReturn = strReturn.replaceAll("&lt;col", "<col");
				strReturn = strReturn.replaceAll("&lt;/col>", "</col>");
				strReturn = strReturn.replaceAll("&lt;/colgroup>", "</colgroup>");
				strReturn = strReturn.replaceAll("&lt;tbody", "<tbody");
				strReturn = strReturn.replaceAll("&lt;/tbody>", "</tbody>");
				strReturn = strReturn.replaceAll("&lt;th", "<th");
				strReturn = strReturn.replaceAll("&lt;/th>", "</th>");
				strReturn = strReturn.replaceAll("&lt;thead", "<thead");
				strReturn = strReturn.replaceAll("&lt;/thead>", "</thead>");
				strReturn = strReturn.replaceAll("&lt;tfoot", "<tfoot");
				strReturn = strReturn.replaceAll("&lt;/tfoot>", "</tfoot>");
				strReturn = strReturn.replaceAll("&lt;tr", "<tr");
				strReturn = strReturn.replaceAll("&lt;/tr>", "</tr>");
				strReturn = strReturn.replaceAll("&lt;td", "<td");
				strReturn = strReturn.replaceAll("&lt;/td>", "</td>");
				strReturn = strReturn.replaceAll("&lt;section", "<section");
				strReturn = strReturn.replaceAll("&lt;/section>", "</section>");
				strReturn = strReturn.replaceAll("&lt;button", "<button");
				strReturn = strReturn.replaceAll("&lt;/button>", "</button>");
				strReturn = strReturn.replaceAll("&lt;video", "<video");
				strReturn = strReturn.replaceAll("&lt;/video>", "</video>");
				strReturn = strReturn.replaceAll("&lt;source", "<source");
				strReturn = strReturn.replaceAll("&lt;/source>", "</source>");
				strReturn = strReturn.replaceAll("&lt;ins", "<ins");
				strReturn = strReturn.replaceAll("&lt;/ins>", "</ins>");

				// 스크립트 문자열 필터링 (선별함 - 필요한 경우 보안가이드에 첨부된 구문 추가)
				ArrayList<String> strScriptList = new ArrayList<String>();
				/*
				strScriptList.add("alert");
				strScriptList.add("applet");
				strScriptList.add("cookie");
				strScriptList.add("document");
				strScriptList.add("embed");
				strScriptList.add("frame");
				strScriptList.add("iframe");
			 	strScriptList.add("javascript");
				strScriptList.add("layer");
				strScriptList.add("onclick");
				strScriptList.add("onfocus");
				strScriptList.add("onload");
				strScriptList.add("script");
				*/
				strScriptList.add("bgsound");
				strScriptList.add("enerror");
				strScriptList.add("grameset");
				strScriptList.add("object");
				strScriptList.add("onunload");
				strScriptList.add("onblur");
				strScriptList.add("onchange");
				strScriptList.add("ondblclick");
				strScriptList.add("onmouse");
				strScriptList.add("onscroll");
				strScriptList.add("onsubmit");
				strScriptList.add("vbscript");

				for(int j = 0; j<strScriptList.size(); j++){
					strReturn = strReturn.replaceAll("(?i)"+strScriptList.get(j), "x-"+strScriptList.get(j));
				}
			}else{ // HTML tag를 사용하지 못하게 할 경우
				strReturn = strReturn.replaceAll("\"","&gt;");
				strReturn = strReturn.replaceAll("&", "&amp;");
				strReturn = strReturn.replaceAll("<", "&lt;");
				strReturn = strReturn.replaceAll(">", "&gt;");
				strReturn = strReturn.replaceAll("%00", null);
				strReturn = strReturn.replaceAll("\"", "&#34;");
				strReturn = strReturn.replaceAll("\'", "&#39;");
				strReturn = strReturn.replaceAll("%", "&#37;");
				strReturn = strReturn.replaceAll("../", "");
				strReturn = strReturn.replaceAll("..\\\\", "");
				strReturn = strReturn.replaceAll("./", "");
				strReturn = strReturn.replaceAll("%2F", "");
			}
		}

		return strReturn;
	}

	/**
	 * String을 지정된 길이만큼만 출력할 수 있도록 하며, 만약
	 * 일부분만이 출력되는 경우에는 "..."를 끝에 추가한다.
	 * strSource의 앞뒤에 공백문자가 포함되어 있는 경우 trim을
	 * 수행한다.
	 *
	 *  cutByte값은 문자열의 byte 길이를 의미한다.  한글과 같이
	 *  2byte character는 2로 계산하며, 영문 및 반각 기호는 1로
	 * 계산한다.
	 *
	 * @param strSource 변환하고자 하는 원본 문자열. null인
	 *                           경우 공백문자열이 반환된다.
	 * @param cutByte 변환후 총 길이(postfix 문자열 "..."의 길이
	 *                         포함).  반드시 4 이상의 숫자를 입력해야
	 *                         한다.  그렇지 않은 경우 원본 문자열을
	 *                         그대로 반환한다.
	 * @return 변환된 결과 문자열을 return 한다. 단, strSource가
	 *             null인 경우 공백문자열이 반환되며 cutByte가 4
	 *             미만의 숫자가 오는 경우 원본 문자열을 그대로
	 *             반환한다.
	 */
	public static String subStrLen(String strSource, int cutByte) {
		return subStrLen( strSource, cutByte, true, "..." );
	}

	/**
	 * String을 지정된 길이만큼만 출력할 수 있도록 하며, 만약 일부분만이 출력되는 경우에는
	 * 지정된 postfix 문자열을 끝에 추가한다.
	 *
	 *  cutByte값은 문자열의 byte 길이를 의미한다.  한글과 같이 2byte character는 2로 계산하며, 영문 및 반각 기호는 1로 계산한다.
	 *
	 * @param strSource 변환하고자 하는 원본 문자열. null인 경우 공백문자열이 반환된다.
	 * @param cutByte 변환후 총 길이(postfix 문자열의 길이 포함).  반드시 strPostfix문자열의 byte크기 이상의 숫자를 입력해야 한다.  그렇지 않은 경우 원본 문자열을 그대로 반환한다.
	 * @param bTrim 원본 문자열의 앞뒤에 공백문자가 있을경우 trim을 수행할지를 결정한다.
	 * @param strPost 문자열이 잘릴경우 이를 표현하기 위한 문자열. null인 경우 "..."이 추가된다.
	 * @return 변환된 결과 문자열을 return 한다. 단, strSource가 null인 경우 공백문자열이 반환되며 cutByte가 strPostfix문자열의 byte크기 미만의 숫자가 오는 경우 원본 문자열을 그대로 반환한다.
	 */
	public static String subStrLen(String strText, int cutByte, boolean bTrim, String strPost) {
		String strReturn = null;
		String strPostfix = strPost;
		String strSource = strText;
		if( strSource != null ){
			strPostfix = (strPostfix == null) ? "..." : strPostfix;
			int postfixSize = 0;
			for( int i=0; i < strPostfix.length(); i ++ ) {
				if( strPostfix.charAt( i ) < 256 ){
					postfixSize += 1;
				}
				else{
					postfixSize += 2;
				}
			}
			if( postfixSize > cutByte ){
				strReturn = strSource;
			}else{
				if( bTrim ){
					strSource = strSource.trim();
				}
				char[] charArray = strSource.toCharArray();
				int strIndex = 0;
				int byteLength = 0;
				for( ; strIndex < strSource.length(); strIndex++ ) {
					int byteSize = 0;
					if( charArray[ strIndex ] < 256) {
						// 1byte character 이면
						byteSize = 1;
					}
					else {
						// 2byte character 이면
						byteSize = 2;
					}
					if( ( byteLength + byteSize ) > cutByte - postfixSize ) {
						break;
					}
					byteLength = byteLength += byteSize;
				}

				if( strIndex == strSource.length() ) {
					strPostfix = "";
				}
				else {
					if( (byteLength + postfixSize) < cutByte ){
						strPostfix = " " + strPostfix;
					}
				}

				strReturn = strSource.substring( 0, strIndex ) + strPostfix;
			}
		}
		return strReturn;
	}

	/**
	 * Object 를 String으로 변환한다.
	 * @param obj
	 * @return
	 */
	public static String getString(Object obj) {
		try {
			if (obj != null) {
				return obj.toString();
			}else {
				return "";
			}
		}catch(Exception e) {
			return "";
		}
	}

	/**
	 * Object 를 String으로 변환한다.
	 * @param obj
	 * @return
	 */
	public static long getLong(Object obj) {
		try {
			if (obj != null) {
				return Long.parseLong(obj.toString());
			}else {
				return 0L;
			}
		}catch(Exception e) {
			return 0L;
		}
	}

	private static final String[] firstSounds = { "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" };

	public static String getFirstElement(String str) {
		if (str == null || str.length() <= 0) {
			return str;
		}

		char c = str.charAt(0);

		if (c < 0xAC00 || c > 0xD7A3) {
			return str.substring(0, 1);
		}

		return firstSounds[(c - 0xAC00) / (21 * 28)];
	}

	public static Boolean toEqualsStr(String str1, Object str2) {
		Boolean flag = false;
		if (str1 == null || str2 == null) {
			return flag;
		}
		try{
			String str2Str = String.valueOf(str2);

			if("".equals(str1) || "".equals(str2Str)){
				return flag;
			}

			if(str1.equals(str2Str)){
				flag =  true;
			}
		}catch(ClassCastException ce){
			flag = false;
		}catch(Exception ce){
			flag = false;
		}

		return flag;

	}


}
