package egovframework.ag.common.security;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.ag.homepage.member.service.MemberService;

@Service
@Transactional(value="txManager_MEMBER")
public class CustomUserDetailsService implements UserDetailsService{

	private final Logger logger = LogManager.getLogger();

    @Autowired
    private MemberService memberService;


    @Transactional(readOnly=true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberDetails memberDetails = null;
		try {
			// 회원 ID 존재 유무
			memberDetails = memberService.selectMemberInfo(username);

	        if(memberDetails == null){
				throw new UsernameNotFoundException(String.format("Username not found : %s", username));
	        }

	        //사용자 레벨 설정
	        String userAge = memberDetails.getUserAge();
	        int nowAge = 19;
	        if(userAge != null && !"".equals(userAge) && !"00".equals(userAge)){
	        	userAge = userAge.replaceAll("-", "");
	        	//생년월일을 이용하여 나이 구하기(만 나이가 아닌 단순나이계산)
	        	Calendar birth = new GregorianCalendar();
	            Calendar today = new GregorianCalendar();

	            birth.setTime(new Date(Long.parseLong(userAge)));
	            today.setTime(new Date());

	            nowAge = today.get(Calendar.YEAR) - birth.get(Calendar.YEAR);
	        }

	        if(nowAge < 13){
	        	memberDetails.setUserLevel("13");
	        }else if(nowAge >= 13 && nowAge < 16){
	        	memberDetails.setUserLevel("16");
	        }else if(nowAge >= 16 && nowAge < 18){
	        	memberDetails.setUserLevel("18");
	        }else{
	        	memberDetails.setUserLevel("19");
	        }

	        //재등록일, 패스워드 등록일 설정
	        String renewalDate = memberDetails.getRenewalDate();
	        String passwordDate = memberDetails.getPasswordDate();

	        Date now = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        String formatNow = sdf.format(now);
	        logger.debug(formatNow);

	        if(renewalDate == null || "".equals(renewalDate)){
	        	memberDetails.setRenewalDate(formatNow);
	        }
	        if(passwordDate == null || "".equals(passwordDate)){
	        	memberDetails.setPasswordDate(formatNow);
	        }
	        logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$$");
	        logger.debug(memberDetails.toString());
	        logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$$");

	        memberDetails.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_MEMBER"));

		} catch (Exception e) {
			e.printStackTrace();
			throw new UsernameNotFoundException(String.format("Username not found : %s", username));
		}
		return memberDetails;
    }
}