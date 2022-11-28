package fr.exagone.teamanage.security;

import org.springframework.dao.DataAccessException;
import org.springframework.security.AuthenticationServiceException;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;

import fr.exagone.teamanage.bean.User;
import fr.exagone.teamanage.services.UserManager;

/**
 * 
 * @author Gildas
 *
 * @spring.bean id="userAuthenticationService"
 * @spring.property name="userManager" ref="userManager"
 */
public class CSIUserDetailsService implements UserDetailsService {

	private UserManager userManager;
	
	public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException, DataAccessException {
		UserDetails details = null;
		User usr = userManager.findByLogin(login);
		if (usr != null) {
			details = new CSIUserDetails(usr);
		} else {
			throw new AuthenticationServiceException("user is unknown");
		}
		return details;
	}

	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}
	

}
