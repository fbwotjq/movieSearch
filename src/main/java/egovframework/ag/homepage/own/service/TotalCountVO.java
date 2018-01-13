package egovframework.ag.homepage.own.service;

import lombok.Data;

import org.apache.ibatis.type.Alias;

@Data
@Alias("totalCountVO")
public class TotalCountVO {

    private int mtotal; //영상자료
    private int filmcnt; //--필름
    private int dcinemacnt; //--D시네마
    private int tapecnt;//--테이프
    private int diskcnt;//--디스크
    private int moviecnt;//동영상
    private int vodcnt;//VOD
    private int itotal;//이미지
    private int postercnt;//포스터
    private int stilcnt;//스틸
    private int btotal;//문헌자료
    private int scenariocnt;//시나리오/콘티
    private int handbillcnt;//전단
    private int bookcnt;//도서
    private int theorycnt;//논문
    private int censorshipcnt;//심의서류
    private int newscnt;//보도자료
    private int etccnt;//기타자료
    private int etotal;//기타
    private int ostcnt;//OST
    private int equipcnt;//박물류


}
