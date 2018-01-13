package egovframework.ag.homepage.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.ag.common.Constant;
import egovframework.ag.common.security.MemberDetails;
import egovframework.ag.homepage.nice.service.NiceCertiVo;

@Service
@Transactional
public class MemberService {
	@Value(value="${active.type}")
	private String activeType;

	@Autowired
	private MemberDao memberDao;

	/**
	 * 사용자 정보 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public MemberDetails selectMemberInfo(String userId) throws Exception {
		MemberDetails member = null;
		try {
			member = memberDao.selectMemberInfoByUserId(userId);
		}catch(Exception e) {
			e.printStackTrace();
			throw new UsernameNotFoundException(String.format("Username not found : %s", userId));
		}

		return member;
	}

	/**
	 * 패스워드 암호화 정보
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public String selectEncryptString(String password) throws Exception {
		if (activeType.equals(Constant.ACTIVE_TYPE_LIVE)) {
			return memberDao.selectEncryptString(password);
		}else {
			return password;
		}
	}

	/**
	 * 로그인 시간 변경
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int updateLoginDate(String userId) throws Exception {
		return memberDao.updateLoginDate(userId);
	}

	/**
	 * 사용자 정보 조회 - 인증
	 * @param certiInfo
	 * @return
	 * @throws Exception
	 */
	public NiceCertiVo selectMemberInfoByCerti(NiceCertiVo niceCerti) throws Exception {
		return memberDao.selectMemberInfoByCerti(niceCerti);
	}

	/**
	 * 사용자 비밀번호 변경
	 * @param changePassVo
	 * @return
	 * @throws Exception
	 */
	public int updatePasswordInfo(ChangePassVo changePassVo) throws Exception {
		changePassVo.setActiveType(activeType);

		return memberDao.updatePasswordInfo(changePassVo);
	}

	/**
	 * 중복 아이디 카운트 조회
	 * @param userId
	 * @return
	 */
	public int selectUserIdDupCount(String userId) throws Exception {
		return memberDao.selectUserIdDupCount(userId);
	}

	/**
	 * 내정보 조회
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public JoinMemberVo selectMypageInfo(String userId) throws Exception {
		return memberDao.selectMypageInfo(userId);
	}

	/**
	 * 내정보 변경
	 * @param changeInfoVo
	 * @return
	 * @throws Exception
	 */
	public int updateMypageInfo(ChangeInfoVo changeInfoVo) throws Exception {
		return memberDao.updateMypageInfo(changeInfoVo);
	}

	/**
	 * 중복 탈퇴 아이디 카운트 조회
	 * @param userId
	 * @return
	 */
	public int selectOutUserIdDupCount(String userId) throws Exception {
		return memberDao.selectOutUserIdDupCount(userId);
	}

	/**
	 * 회원 탈퇴 - 입력
	 *
	 * @param outMemberVo
	 * @return
	 * @throws Exception
	 */
	public void insertOutMember(OutMemberVo outMemberVo) throws Exception {
		memberDao.insertOutMember(outMemberVo);
	}

	/**
	 * 회원 탈퇴 - 수정
	 *
	 * @param outMemberVo
	 * @return
	 * @throws Exception
	 */
	public void updateOutMember(OutMemberVo outMemberVo) throws Exception {
		memberDao.updateOutMember(outMemberVo);
	}

	/**
	 * 회원 탈퇴 처리
	 *
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void updateMemberByOut(String userId) throws Exception {
		memberDao.updateMemberByOut(userId);
	}

	/**
	 * 회원 탈퇴 처리
	 *
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void updateMemberByOutProc(OutMemberVo outMemberVo) throws Exception {

		//회원상태변경
		updateMemberByOut(outMemberVo.getUserId());

		// 탈퇴회원 등록
		int cntDuplicateId = selectOutUserIdDupCount(outMemberVo.getUserId());
		if(cntDuplicateId>0) {
			updateOutMember(outMemberVo);
		}else{
			insertOutMember(outMemberVo);
		}
	}

	/**
	 * 회원 갱신
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int updateRenew(String userId) throws Exception {
		return memberDao.updateRenew(userId);
	}

	/**
	 * 회원 비밀번호 갱신 1달 연장
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int updatePasswordDelay(String userId) throws Exception {
		return memberDao.updatePasswordDelay(userId);
	}
}
