package egovframework.ag.common.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.ag.homepage.common.service.CommonService;

@Service
public class MenuMap {
	private final Logger logger = LogManager.getLogger();

	public static List<Map<String,Object>> MENU_LIST;
	public static HashMap<String,String> MENU_MAP;

	@Autowired
	private CommonService commonService;

	@PostConstruct
	public void init(){
		logger.debug(":::::menu init start:::::");
		if(MENU_LIST == null){
			try {

				MENU_LIST = new ArrayList<Map<String,Object>>();

				List<Map<String,Object>> memuList = new ArrayList<Map<String,Object>>();

				List<Map<String,Object>> memuListResult = commonService.selectMenuList2();
				List<Map<String,Object>> movieMemuListResult = commonService.selectMovieMenuList();
				HashMap<String,Object> yearMap = new HashMap<String,Object>();

				//영화글 순번
				String movieMenuSeq = "";
				String movieHistorySeq = "";

				int cnt = 0;
				for(Map<String,Object> m : memuListResult){
					memuList.add(cnt, m);
					cnt++;
					if("Y".equals((String)m.get("leafYn")) && "1".equals(m.get("levelNum").toString()) && "영화글".equals((String)m.get("cPmenuTitle"))){
						movieMenuSeq = (String)m.get("cPmenuId");
						for(Map<String,Object> m2 : movieMemuListResult){

							Map<String,Object> m3 = new HashMap<String,Object>();
							String title = (String)m2.get("title");
							m3.put("cPmenuId", String.valueOf(m2.get("storyDivSeq")));
							int levelNum = ((BigDecimal)m2.get("levelNum")).intValue();
							if(levelNum == 1){
								m3.put("cParentId", movieMenuSeq);
							}else{
								m3.put("cParentId",  String.valueOf(m2.get("upStoryDivSeq")));
							}
							m3.put("cPmenuDepth", levelNum+1);
							m3.put("cPmenuOrder", m2.get("sortNo"));
							m3.put("cPmenuTitle", title);
							m3.put("cPagePath", "/story/"+m2.get("storyDivSeq"));
							m3.put("leafYn", m2.get("leafYn"));
							m3.put("levelNum", levelNum+1);
							memuList.add(cnt, m3);
							cnt++;
							if("영화사".equals(title) && levelNum == 1){
								movieHistorySeq =  ((BigDecimal)m2.get("storyDivSeq")).toString();
							}
						}
					}else if("N".equals((String)m.get("leafYn")) && "영화연표".equals((String)m.get("cPmenuTitle"))){
						cnt = cnt -1;
						memuList.remove(cnt);
						yearMap.putAll(m);
					}
				}

				//영화연표 메뉴 붙여넣기
				if(movieHistorySeq != null && !"".equals(movieHistorySeq) && yearMap != null && yearMap.size() > 0){

					yearMap.put("cParentId", movieHistorySeq);
					yearMap.put("leafYn", "N");
					int levelNum = ((BigDecimal)yearMap.get("levelNum")).intValue();
					yearMap.put("cPmenuDepth", levelNum+1);
					yearMap.put("cPmenuOrder", "999");
					yearMap.put("levelNum", levelNum+1);

					memuList.add(cnt,yearMap);
				}

				MENU_LIST.addAll(memuList);

				MENU_MAP = new HashMap<String,String>();
				for(int i=0; i< MENU_LIST.size(); i++){
					MENU_MAP.put(((String)MENU_LIST.get(i).get("cPagePath")).toLowerCase(), String.valueOf(i));
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		logger.debug(":::::menu init end:::::");
	}
	@PreDestroy
	public void destroy() {
		logger.debug(":::::menu destroy:::::");
		MENU_LIST.clear();
		MENU_LIST = null;
	}

	public static List<Map<String,Object>> getMenuList() {
        return MENU_LIST;
	}

	public static String getMapValue(String key) {
		String returnValue = MENU_MAP.get(key.toLowerCase());
        return returnValue == null ? "":returnValue;
	}

	public static int getMenuNumForURL(String url) throws Exception {
		String returnValue = "";

		if(url == null || url.length() < 2){
			return 0;
		}

		String splitUrl[] = url.split("/");
		String preMenuUrl =  url;
		for(int j=0; j<splitUrl.length; j++){
			if("".equals(returnValue)){
				if(j>0){
					preMenuUrl = preMenuUrl.substring(0, preMenuUrl.lastIndexOf("/"));
				}
				returnValue = MenuMap.getMapValue(preMenuUrl);
			}else{
				break;
			}
		}

		return returnValue == ""? 0 : Integer.parseInt(returnValue);
	}

}
