package fr.exagone.teamanage.security;

import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;

import fr.exagone.teamanage.bean.User;
import fr.exagone.teamanage.bean.Role;

public class CSIUserDetails implements UserDetails {
	
	User user;
	
	public CSIUserDetails(User usr){
		if (usr==null){
			throw new IllegalArgumentException("Constructor Argument must not be null...");
		}
		this.user=usr;
	}
	
	public GrantedAuthority[] getAuthorities() {
		GrantedAuthority[] auths = new GrantedAuthority[user.getRoles().size()];
		int i=0;
		for (Role r : user.getRoles() ){
			GrantedAuthorityImpl auth = new GrantedAuthorityImpl(r.getCode());
			auths[i++]=auth;
		}
		return auths;
	}

	public String getPassword() {
		return null;
	}

	public String getUsername() {
		return user.getLogin();
	}

	public boolean isAccountNonExpired() {
		return false;
	}

	public boolean isAccountNonLocked() {
		return false;
	}

	public boolean isCredentialsNonExpired() {
		return false;
	}

	public boolean isEnabled() {
		return true;
	}
}
