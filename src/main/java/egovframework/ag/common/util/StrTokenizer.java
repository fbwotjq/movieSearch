package egovframework.ag.common.util;

/*
 * Copyright (c) 2002 Jaru Soft, 
 *                    All Rights Reserved.
 * 
 * 이 라이브러리는 자유 소프트웨어입니다. 
 * 소프트웨어의 피양도자는 자유 소프트웨어 재단이 공표한 GNU 약소 일반 공중 사용 허가서 2.1판 또는 
 * 그 이후 판을 임의로 선택해서, 그 규정에 따라 라이브러리를 개작하거나 재배포할 수 있습니다. 
 * 
 * 이 라이브러리는 유용하게 사용될 수 있으리라는 희망에서 배포되고 있지만, 
 * 특정한 목적에 맞는 적합성 여부나 판매용으로 사용할 수 있으리라는 
 * 묵시적인 보증을 포함한 어떠한 형태의 보증도 제공하지 않습니다. 
 * 보다 자세한 사항에 대해서는 GNU 약소 일반 공중 사용 허가서를 참고하시기 바랍니다. 
 * 
 * GNU 약소 일반 공중 사용 허가서는 이 라이브러리와 함께 제공됩니다. 
 * 
 * [개발정보]
 * 만든이 : kangwoo(kangwoo@jarusoft.com)
 * 만든곳 : 자루(http://www.jarusoft.com)
 * 만든날 : 2002. 04. 11.
 * 
 * [개발기록]
 *  1.0.0 - 2002. 04. 11. kangwoo
 *      : 처음 만듬
 *      
 *  1.0.1 - 2008. 11. 11. badnom
 *      : 재정리
 */

/**
 * <p>StrTokenizer 클래스를 사용하면, 문자열을 구분자로 분할 할 수 있습니다.</p>
 * <pre> 구분자 사이에 아무것도 없으면, 공백문자를 반환한다.
 * ex) 1||3 -> 1, 공백, 3 이렇게 3개의 토큰을 반환한다.
 * </pre>
 * 
 * @author <a href="mailto:kangwoo@jarusoft.com">kangwoo</a>
 * @version v 1.0
 */
public class StrTokenizer  {
	
	private int currentPosition;
	private int maxPosition;
	private String str;
	private String delimiter;
	private int delimiterSize;
	
	private int countTokens	 = -1;	// Token의 갯수
	
	/**
	 * 대상 문자열에 대한 Tokenizer를 생성합니다. 구분자는 기본값(" ")으로 사용합니다.
	 * 
	 * @param str 대상 문자열
	 */
	public StrTokenizer(String str) {
		this(str, " ");
	}
	
	/**
	 * 대상 문자열에 대한 Tokenizer를 생성합니다. delim는 구분자이니다.
	 * 
	 * 
	 * @param str 대상 문자열
	 * @param delim 구분자
	 * @throws NullPointerException - str 가 null 경우
	 */
	public StrTokenizer(String str, String delim) {
		this.str = str;
		this.delimiter = delim;
		currentPosition = 0;
		maxPosition = this.str.length();
		delimiterSize = this.delimiter.length(); 
	}	
	
	/**
	 * 이용할 수 있는 토큰이 더 존재하지를 판단합니다. 이 메서드가 <code>true</code>를 돌려주는 경우, nextToken 메소드를 호출해 다음 토큰을 가져갈 수 있습니다.
	 *  
	 * @return 현 위치의 뒤로, 1개 이상의 토큰이 존재할 경우 true, 그렇지 않을 경우 false
	 */
	public boolean hasMoreTokens() {
		return ( (currentPosition <= maxPosition) || (str.indexOf(delimiter, currentPosition) > -1));
	}
	
	/**
	 * 다음 토큰을 반환한다.
	 * 반환할 토큰이 없으면 null을 돌려준다.
	 * 
	 * @return 다음 토큰
	 */
	public String nextToken() {
		String result = null;
		int index = str.indexOf(delimiter, currentPosition);
		if (index > -1) {
			result = str.substring(currentPosition, index);
			currentPosition = index + delimiterSize;
		} else {
			result = str.substring(currentPosition);
			currentPosition = maxPosition + delimiterSize;
		}
		return result;
	}
	
	/**
	 * 토큰의 총 갯수를 반환한다.
	 * 
	 * @return 토큰의 총 갯수
	 */
	public int countTokens() {
		if (countTokens < 0) {
			int tCountTokens = 1;
			int cPos = 0;
			int index = 0;
			while ((index = str.indexOf(delimiter, cPos)) > -1) {
			    tCountTokens++;
				cPos = index + delimiterSize;
			}
			countTokens = tCountTokens;
		}
		return countTokens;
	}
	
	/**
	 * 배열 크기 만큼의 문자열배열을 만든후, 토큰 값을 채워넣은 후 반환한다.
	 * 토큰 갯수가 배열 크기보다 작을 경우는, 나머지 값을 null로 설정한고,
	 * 토큰 갯수가 배열 크기보다 클 경우는, 배열 크기만큼만 값을 설정한다.
	 * 
	 * @param arraySize 배열 크기
	 * @return
	 */
	public String[] toArray(int arraySize) {
	    String[] array = new String[arraySize];
	    for (int i = 0; i < arraySize && hasMoreTokens(); i++) {
	        array[i] = nextToken();
	    }
	    return array;
	}
	
	/**
	 * 토큰들을 문자열배열로 만든다.
	 * 문자열배열의 크기는 토큰의 크기로 만들어진다.
	 * 
	 * @return 문자열배열
	 */
	public String[] toArray() {
	    return toArray(countTokens());
	}
	
}