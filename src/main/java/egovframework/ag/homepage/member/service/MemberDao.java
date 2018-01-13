package egovframework.ag.homepage.member.service;

import egovframework.ag.common.annotation.MemberMapper;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.homepage.nice.service.NiceCertiVo;

@MemberMapper
public interface MemberDao {
	/**
	 * 사용자 정보 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public MemberDetails selectMemberInfoByUserId(String userId) throws Exception;

	/**
	 * DB 암호화 String 조회
	 * @param plainText
	 * @return
	 * @throws Exception
	 */
	public String selectEncryptString(String plainText) throws Exception;


	/**
	 * 패스워드 암호화 정보
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public String getDataStringByEncryptForPassword(String password) throws Exception;

	/**
	 * 로그인 시간 변경
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int updateLoginDate(String userId) throws Exception;

	/**
	 * 사용자 정보 조회 - 인증
	 * @param certiInfo
	 * @return
	 * @throws Exception
	 */
	public NiceCertiVo selectMemberInfoByCerti(NiceCertiVo niceCerti) throws Exception;

	/**
	 * 사용자 비밀번호 변경
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	public int updatePasswordInfo(ChangePassVo changePassVo) throws Exception;

	/**
	 * 중복 아이디 카운트 조회
	 * @param userId
	 * @return
	 */
	public int selectUserIdDupCount(String userId) throws Exception;

	/**
	 * 내정보 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public JoinMemberVo selectMypageInfo(String userId) throws Exception;

	/**
	 * 내정보 변경
	 * @param changeInfoVo
	 * @return
	 * @throws Exception
	 */
	public int updateMypageInfo(ChangeInfoVo changeInfoVo) throws Exception;

	/**
	 * 중복 탈퇴 아이디 카운트 조회
	 * @param userId
	 * @return
	 */
	public int selectOutUserIdDupCount(String userId) throws Exception;

	/**
	 * 회원 탈퇴 - 입력
	 *
	 * @param outMemberVo
	 * @return
	 * @throws Exception
	 */
	public void insertOutMember(OutMemberVo outMemberVo) throws Exception;

	/**
	 * 회원 탈퇴 - 수정
	 *
	 * @param outMemberVo
	 * @return
	 * @throws Exception
	 */
	public void updateOutMember(OutMemberVo outMemberVo) throws Exception;

	/**
	 * 회원 탈퇴 처리
	 *
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void updateMemberByOut(String userId) throws Exception;

	/**
	 * 회원갱신
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int updateRenew(String userId) throws Exception;

	/**
	 * 회원 비밀번호 갱신 1달 연장
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int updatePasswordDelay(String userId) throws Exception ;
}
