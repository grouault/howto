package fr.test.liferay;

import java.net.URL;

import com.liferay.client.soap.portal.model.CompanySoap;
import com.liferay.client.soap.portal.service.http.CompanyServiceSoapServiceLocator;
import com.liferay.client.soap.portal.service.http.UserServiceSoap;
import com.liferay.client.soap.portal.service.http.UserServiceSoapServiceLocator;

public class RemoteService {

	public static void main(String[] args) {
		
		String serviceUserName = "Portal_UserService";
		String serviceCompanyName = "Portal_CompanyService";
		long userId = 0;
		
		try {
	         String remoteUser = "test";
	         String password = "test";
	         String virtualHost = "localhost";
		
	      // Locate the Company
	         CompanyServiceSoapServiceLocator locatorCompany =
	          new CompanyServiceSoapServiceLocator();

	         com.liferay.client.soap.portal.service.http.CompanyServiceSoap soapCompany =
	          locatorCompany.getPortal_CompanyService(
	              _getURL(remoteUser, password, serviceCompanyName,
	                   true));
	         
	         CompanySoap companySoap = soapCompany.getCompanyByVirtualHost(virtualHost);
	         
			// Locate the User service
	        UserServiceSoapServiceLocator locatorUser = new UserServiceSoapServiceLocator();
	        URL url = _getURL(remoteUser, password, serviceUserName, true);
	        UserServiceSoap userSoap = locatorUser.getPortal_UserService(url);		
	        
	        
		    // Get the ID of the remote user
		    userId = userSoap.getUserIdByScreenName(
		          companySoap.getCompanyId(), remoteUser);
		         System.out.println("userId for user named " + remoteUser +
		              " is " + userId);	        
	        
		} catch (Exception e) {
	         e.printStackTrace();
	    }
		
	}
	
	private static URL _getURL(String remoteUser, String password,
		       String serviceName, boolean authenicate)
		    throws Exception {
		       //Unauthenticated url
		       String url = "http://localhost:8080/api/axis/" + serviceName;

		       //Authenticated url
		       if (authenicate) {
		         url = "http://" + remoteUser + ":" + password +
		          "@localhost:8080/api/secure/axis/" + serviceName;
		       }
		  return new URL(url);
	}

	
}
