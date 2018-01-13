package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("scenarioVO")
public class ScenarioVO {

	private String movieId;
	private String movieSeq;
	private String scenarioNo;
    private String sTitle ; //본제목
    private String titleSub ; //부제목
    private String titleEtc ; //기타제목
    private String titleEqual; //대동제목
	private String formClss ; //형태
	private String contensClss ; //내용구분
	private String sScenario ; //각본
	private String sFilmzation ; //각색
	private String director ; //감독
	private String sAuthor ; //원작자
	private String orgTitle ; //원작
	private String cAuthor ; //콘티작가
	private String produce ; //제작사
	private String sYear ; //발행년도
	private String hSize ; //실물크기
	private String vSize ; //실물크기
	private String langClss ; //언어
	private String sPage ; //페이지
	private String pageClss ; //페이지
	private String posClss ; //보관위치
	private String mngno ; //배가번호
	private String copyInfo;
	private String formClssNm;
	private String posClssNm;

	public String getsTitle() {
		return sTitle;
	}
	public void setsTitle(String sTitle) {
		this.sTitle = sTitle;
	}
	public String getsScenario() {
		return sScenario;
	}
	public void setsScenario(String sScenario) {
		this.sScenario = sScenario;
	}
	public String getsFilmzation() {
		return sFilmzation;
	}
	public void setsFilmzation(String sFilmzation) {
		this.sFilmzation = sFilmzation;
	}
	public String getsAuthor() {
		return sAuthor;
	}
	public void setsAuthor(String sAuthor) {
		this.sAuthor = sAuthor;
	}
	public String getcAuthor() {
		return cAuthor;
	}
	public void setcAuthor(String cAuthor) {
		this.cAuthor = cAuthor;
	}
	public String getsYear() {
		return sYear;
	}
	public void setsYear(String sYear) {
		this.sYear = sYear;
	}
	public String gethSize() {
		return hSize;
	}
	public void sethSize(String hSize) {
		this.hSize = hSize;
	}
	public String getvSize() {
		return vSize;
	}
	public void setvSize(String vSize) {
		this.vSize = vSize;
	}
	public String getsPage() {
		return sPage;
	}
	public void setsPage(String sPage) {
		this.sPage = sPage;
	}
}
