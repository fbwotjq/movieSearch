package egovframework.ag.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import egovframework.ag.homepage.member.service.MemberService;

public class CustomPasswordEncoder implements PasswordEncoder {

    @Autowired
    private MemberService memberService;

	@Override
	public String encode(CharSequence rawPassword) {
		String encodedPassword = null;

		try {
			// 비밀번호 암호화
			encodedPassword = memberService.selectEncryptString(rawPassword.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return encodedPassword;
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		if (encodedPassword == null || rawPassword == null) {
			return false;
		}

		if (!encodedPassword.equals(encode(rawPassword))) {
			return false;
		}

		return true;
	}

}
