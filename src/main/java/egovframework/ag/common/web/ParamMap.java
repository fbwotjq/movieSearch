package egovframework.ag.common.web;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.codec.binary.Base64;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.ReferenceUtils;
import egovframework.ag.common.util.StringUtils;


public class ParamMap {
    Map<String,Object> map = new HashMap<String,Object>();

    public String getBase64ParamString() {
    	String result = "";

    	Set<String> keySet = this.getMap().keySet();

    	int step = 0;

    	for (String key : keySet) {
    		if (step > 0) {
    			result += "&";
    		}

    		result += key + "=" + getString(key);


    		step++;
		}

    	return new String(Base64.encodeBase64(result.getBytes()));
    }

    public void putBase64ParamString(String base64ParamString) {
    	try {
    		if (StringUtils.isBlank(base64ParamString) == true) {
    			return;
    		}

        	String decString = new String(Base64.decodeBase64(base64ParamString.getBytes()));


        	String[] arrDecString = decString.split("\\&");

        	for (String paramString : arrDecString) {
        		String[] arrParamString = paramString.split("\\=");

        		if (arrParamString != null && arrParamString.length >= 2) {
        			put(arrParamString[0], arrParamString[1]);
        		}
        	}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    }

    public Object get(String key){
        return map.get(key);
    }

    public String getString(String key){
    	try {
        	if (map.get(key) != null) {
        		return map.get(key).toString();
        	}else {
        		return "";
        	}
		} catch (Exception e) {
			return "";
		}

    }

    public String getString(String key, String defaultString){
    	try {
    		if (map.get(key) != null) {
    			return map.get(key).toString();
    		}else {
    			return defaultString;
    		}
    	} catch (Exception e) {
    		return defaultString;
    	}

    }

    public int getInt(String key){
    	try {
    		if (map.get(key) != null) {
    			try {
    				return Integer.parseInt(map.get(key).toString());
    			}catch(Exception e) {
    				return 0;
    			}
    		}else {
    			return 0;
    		}
    	} catch (Exception e) {
    		return 0;
    	}

    }
    public Long getLong(String key){
    	try {
    		if (map.get(key) != null) {
    			try {
    				return Long.parseLong(map.get(key).toString());
    			}catch(Exception e) {
    				return 0L;
    			}
    		}else {
    			return 0L;
    		}
    	} catch (Exception e) {
    		return 0L;
    	}

    }

    public void put(String key, Object value){
        map.put(key, value);
    }

    public Object remove(String key){
        return map.remove(key);
    }

    public boolean containsKey(String key){
        return map.containsKey(key);
    }

    public boolean containsValue(Object value){
        return map.containsValue(value);
    }

    public void clear(){
        map.clear();
    }

    public Set<Entry<String, Object>> entrySet(){
        return map.entrySet();
    }

    public Set<String> keySet(){
        return map.keySet();
    }

    public boolean isEmpty(){
        return map.isEmpty();
    }

    public void putAll(Map<? extends String, ?extends Object> m){
        map.putAll(m);
    }

    public Map<String,Object> getMap(){
        return map;
    }

    public String getPagingTagString(int totalCount) {
    	return ReferenceUtils.getNavigationByPage(getString(Constant.CONTEXT_PATH), totalCount, getInt(Constant.PAGE), getInt(Constant.PAGE_SIZE), getInt(Constant.PAGE_BLOCK));
    }

    public String getPagingTagString(int totalCount, String fncGubun) {
    	return ReferenceUtils.getNavigationByPage(getString(Constant.CONTEXT_PATH), totalCount, getInt(Constant.PAGE), getInt(Constant.PAGE_SIZE), getInt(Constant.PAGE_BLOCK), fncGubun);
    }

    public String getPagingTagString(int totalCount, int page, int pageSize) {
    	return ReferenceUtils.getNavigationByPage(getString(Constant.CONTEXT_PATH), totalCount, page, pageSize, getInt(Constant.PAGE_BLOCK));
    }

    public int getTotalPageCount(int totalCount) {
    	return  (int)Math.ceil((double)totalCount / getInt(Constant.PAGE_SIZE));
    }

    public int getTotalPageCount(int totalCount, int pageSize) {
    	return  (int)Math.ceil((double)totalCount / pageSize);
    }

	@Override
	public String toString() {
		return "ParamMap [" + map.toString() + "]";
	}


}
