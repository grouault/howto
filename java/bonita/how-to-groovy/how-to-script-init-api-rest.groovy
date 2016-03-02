import static org.codehaus.groovy.runtime.DefaultGroovyMethods.*;
import com.company.model.LeaveType;
import groovy.json.JsonSlurper;

// Login user.
Map<String, String> lTypes
CookieManager mgrCookie = new CookieManager()
mgrCookie.setCookiePolicy(CookiePolicy.ACCEPT_ALL)
CookieHandler.setDefault(mgrCookie)
def urlLogin = new URL("http://localhost:8080/bonita/loginservice?username=walter.bates&password=bpm&redirect=false&redirectUrl=")
URLConnection connection = urlLogin.openConnection()
Map headerFields = connection.getHeaderFields()

// Appel WebService LeaveRequest
URL url = new URL("http://localhost:8080/bonita/portal/resource/process/Leave%20request/7.1/API/extension/test/leaveReasons");
InputStream urlStream = null;
def jsonContent = "null";
try {
	urlStream = url.openStream();
	BufferedReader reader = new BufferedReader(new InputStreamReader(urlStream));
	JsonSlurper jsonSlurper = new JsonSlurper();
	List<LeaveType> typesLeave = jsonSlurper.parse(reader);
	lTypes = new HashMap<String, String>()
	for (LeaveType current : typesLeave) {
		lTypes.put(current.id, current.label)
	}
} finally {
	if (urlStream != null) {
		urlStream.close();
	}
	URL urlLogout = new URL("http://localhost:8080/bonita/logoutservice")
	urlLogout.openConnection()
	println 'logout'
}
return lTypes