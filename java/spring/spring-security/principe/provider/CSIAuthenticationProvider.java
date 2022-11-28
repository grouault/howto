package fr.exagone.teamanage.security;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationException;
import org.springframework.security.AuthenticationServiceException;
import org.springframework.security.BadCredentialsException;
import org.springframework.security.SpringSecurityMessageSource;
import org.springframework.security.providers.AuthenticationProvider;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

/**
 * 
 * @author Gildas
 *
 * @spring.bean id="authenticationProvider"
 * @spring.property name="userDetailsService" ref="userAuthenticationService"
 */
public class CSIAuthenticationProvider implements AuthenticationProvider {

	private static final Log logger = LogFactory.getLog(CSIAuthenticationProvider.class);
	
	protected UserDetailsService userDetailsService;

	protected MessageSourceAccessor messages = SpringSecurityMessageSource.getAccessor();
	
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		Assert.isInstanceOf(UsernamePasswordAuthenticationToken.class, authentication, messages.getMessage(
				"AbstractUserDetailsAuthenticationProvider.onlySupports", "Only UsernamePasswordAuthenticationToken is supported"));

		UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) authentication;

		String username = userToken.getName();

		if (!StringUtils.hasLength(username)) {
			throw new BadCredentialsException(messages.getMessage("CSIAuthenticationProvider.emptyUsername", "Empty Username"));
		}

		String password = (String) authentication.getCredentials();
		Assert.notNull(password, "Null password was supplied in authentication token");

		if (password.length() == 0) {
			logger.debug("Rejecting empty password for user " + username);
			throw new BadCredentialsException(messages.getMessage("LdapAuthenticationProvider.emptyPassword", "Empty Password"));
		}

//		LDAPAuthentication ldapAuthentication = new LDAPAuthentication();
		UserDetails user = null;
//		conf ldap		
//		if (ldapAuthentication.secureAuthentication(username, password)) {
			user = userDetailsService.loadUserByUsername(username);
//		} else {
//			throw new AuthenticationServiceException("Ldap Athentication failed for user : " + username);
//		}
		if (user == null){
			throw new AuthenticationServiceException("Athentication failed for user : " + username);
		}
		
		return createSuccessfulAuthentication(userToken, user);
		
	}

	@SuppressWarnings("unchecked")
	public boolean supports(Class authentication) {
		return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}

	protected Authentication createSuccessfulAuthentication(UsernamePasswordAuthenticationToken authentication, UserDetails user) {

		return new UsernamePasswordAuthenticationToken(user, authentication.getCredentials(), user.getAuthorities());
	}

	/**
	 * @return the userDetailsService
	 */
	public UserDetailsService getUserDetailsService() {
		return userDetailsService;
	}

	/**
	 * @param userDetailsService the userDetailsService to set
	 */
	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}

}
