package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("filmVO")
public class FilmVO {
	private String movieId;
	private String movieSeq;
	private String fItem; // 구분
	private String fUnit; // 규격
	private String fColor; // 색채
	private String fScreen; // 화면비
	private String fSound; // 사운드
	private String fLang; // 언어
	private String fJamak; // 자막
	private String fRuntime; // 시간
	private String fPosition; // 보관위치
	private String fImethod; // 입수방법
	private String fItemNm; // 구분
	private String fUnitNm; //규격
	private String fColorNm; //색채
	private String fScreenNm; //
	private String fSoundNm; //사운드
	private String fImethodNm;// 입수방법
	private String fPositionNm; // 보관위치


	public String getfItem() {
		return fItem;
	}
	public void setfItem(String fItem) {
		this.fItem = fItem;
	}
	public String getfUnit() {
		return fUnit;
	}
	public void setfUnit(String fUnit) {
		this.fUnit = fUnit;
	}
	public String getfColor() {
		return fColor;
	}
	public void setfColor(String fColor) {
		this.fColor = fColor;
	}
	public String getfScreen() {
		return fScreen;
	}
	public void setfScreen(String fScreen) {
		this.fScreen = fScreen;
	}
	public String getfSound() {
		return fSound;
	}
	public void setfSound(String fSound) {
		this.fSound = fSound;
	}
	public String getfLang() {
		return fLang;
	}
	public void setfLang(String fLang) {
		this.fLang = fLang;
	}
	public String getfJamak() {
		return fJamak;
	}
	public void setfJamak(String fJamak) {
		this.fJamak = fJamak;
	}
	public String getfRuntime() {
		return fRuntime;
	}
	public void setfRuntime(String fRuntime) {
		this.fRuntime = fRuntime;
	}
	public String getfPosition() {
		return fPosition;
	}
	public void setfPosition(String fPosition) {
		this.fPosition = fPosition;
	}
	public String getfImethod() {
		return fImethod;
	}
	public void setfImethod(String fImethod) {
		this.fImethod = fImethod;
	}
	public String getfItemNm() {
		return fItemNm;
	}
	public void setfItemNm(String fItemNm) {
		this.fItemNm = fItemNm;
	}
	public String getfUnitNm() {
		return fUnitNm;
	}
	public void setfUnitNm(String fUnitNm) {
		this.fUnitNm = fUnitNm;
	}
	public String getfColorNm() {
		return fColorNm;
	}
	public void setfColorNm(String fColorNm) {
		this.fColorNm = fColorNm;
	}
	public String getfScreenNm() {
		return fScreenNm;
	}
	public void setfScreenNm(String fScreenNm) {
		this.fScreenNm = fScreenNm;
	}
	public String getfSoundNm() {
		return fSoundNm;
	}
	public void setfSoundNm(String fSoundNm) {
		this.fSoundNm = fSoundNm;
	}
	public String getfImethodNm() {
		return fImethodNm;
	}
	public void setfImethodNm(String fImethodNm) {
		this.fImethodNm = fImethodNm;
	}
	public String getfPositionNm() {
		return fPositionNm;
	}
	public void setfPositionNm(String fPositionNm) {
		this.fPositionNm = fPositionNm;
	}

}
