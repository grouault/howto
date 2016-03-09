		@Test
		public void testUrlOpenStream() {
			
			// Login user.
			CookieManager mgrCookie = new CookieManager()
			mgrCookie.setCookiePolicy(CookiePolicy.ACCEPT_ALL)
			CookieHandler.setDefault(mgrCookie)
			def urlLogin = new URL("http://localhost:8080/bonita/loginservice?username=walter.bates&password=bpm&redirect=false&redirectUrl=")
			URLConnection connection = urlLogin.openConnection()
			Map headerFields = connection.getHeaderFields()
			println 'login'
			// Appel WebService LeaveRequest
			URL url = new URL("http://localhost:8080/bonita/portal/resource/process/Leave%20request/7.1/API/extension/test/leaveReasons");
			InputStream urlStream = null;
			def jsonContent = "null";
			try {
				urlStream = url.openStream();
				BufferedReader reader = new BufferedReader(new InputStreamReader(urlStream));
				JsonSlurper jsonSlurper = new JsonSlurper();
				List<LeaveType> result = jsonSlurper.parse(reader);
				Map<String, String> lTypes = new HashMap<String, String>()
				for (LeaveType current : result) {
					lTypes.put(current.id, current.label)
				}
				println 'get[CP] = ' + lTypes.get('CP')
				println 'get[CSS] = ' + lTypes.get('CSS')
				/*
				// lecture Reader.
				def lineNo = 1
				def line
				while ((line = reader.readLine())!=null) {
					println "${lineNo}. ${line}"
					lineNo++
				 }
				 */
			} finally {
				if (urlStream != null) {
					urlStream.close();
				}
				URL urlLogout = new URL("http://localhost:8080/bonita/logoutservice")
				urlLogout.openConnection()
				println 'logout'
			}
		}