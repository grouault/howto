# Call JSon Rest API

import static org.codehaus.groovy.runtime.DefaultGroovyMethods.*;
import groovy.json.JsonSlurper;

def types = [];
URL url = new URL("http://localhost:8080/bonita/portal/resource/process/Leave%20request/7.1/API/extension/test/leaveReasons");
InputStream urlStream = null;
def jsonContent = "null";
try {

	urlStream = url.openStream();
	BufferedReader reader = new BufferedReader(new InputStreamReader(urlStream));

	
} finally {
	if (urlStream != null) {
		urlStream.close();
	}
}
return jsonContent;


http://localhost:8080/bonita/logoutservice