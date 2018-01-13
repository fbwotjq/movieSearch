package egovframework.ag.common.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class MemberDetails implements UserDetails {
	/**
	 *
	 */
	private static final long serialVersionUID = 7883950484338812263L;


	private String userid;

	private String passwd;

	private String name;

	private String renewalDate;

	private String passwordDate;

	private String foreign;

	private String cellno;

	private String mailaddr;

	private String userAge;

	private String userLevel;

	private String sexType;

	private String sex;


	private Collection<? extends GrantedAuthority> authorities;


	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRenewalDate() {
		return renewalDate;
	}

	public void setRenewalDate(String renewalDate) {
		this.renewalDate = renewalDate;
	}

	public String getPasswordDate() {
		return passwordDate;
	}

	public void setPasswordDate(String passwordDate) {
		this.passwordDate = passwordDate;
	}

	public String getForeign() {
		return foreign;
	}

	public void setForeign(String foreign) {
		this.foreign = foreign;
	}

	public String getCellno() {
		return cellno;
	}

	public void setCellno(String cellno) {
		this.cellno = cellno;
	}

	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public String getMailaddr() {
		return mailaddr;
	}

	public void setMailaddr(String mailaddr) {
		this.mailaddr = mailaddr;
	}

	public String getUserAge() {
		return userAge;
	}

	public void setUserAge(String userAge) {
		this.userAge = userAge;
	}

	public String getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}

	public String getSexType() {
		return sexType;
	}

	public void setSexType(String sexType) {
		this.sexType = sexType;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}


	public void setPassword(String password) {
		this.passwd = password;
	}

	@Override
	public String getPassword() {
		return this.passwd;
	}

	@Override
	public String getUsername() {
		return this.userid;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

    @Override
    public boolean equals(Object o) {
        if (o instanceof MemberDetails) {
            return this.getUsername().equals(((MemberDetails) o).getUsername());
        }
        return false;
    }

    @Override
    public int hashCode() {
        return this.getUsername().hashCode();
    }

	@Override
	public String toString() {
		return "MemberDetails ["
				+ (userid != null ? "userid=" + userid + ", " : "")
				+ (passwd != null ? "passwd=" + passwd + ", " : "")
				+ (name != null ? "name=" + name + ", " : "")
				+ (renewalDate != null ? "renewalDate=" + renewalDate + ", "
						: "")
				+ (passwordDate != null ? "passwordDate=" + passwordDate + ", "
						: "")
				+ (foreign != null ? "foreign=" + foreign + ", " : "")
				+ (cellno != null ? "cellno=" + cellno + ", " : "")
				+ (mailaddr != null ? "mailaddr=" + mailaddr + ", " : "")
				+ (userAge != null ? "userAge=" + userAge + ", " : "")
				+ (userLevel != null ? "userLevel=" + userLevel : "")
				+ (sexType != null ? "sexType=" + sexType : "")
				+ (sex != null ? "sex=" + sex : "")+ "]";
	}

}
