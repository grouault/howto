## keytool cmd


#### Chemin du du cacert dans la jdk
```
C:\\Services\\devs\\java\\jdk\\openjdk\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\jre\\lib\\security\\cacerts
```

#### importer un certificat avec alias
<pre>
keytool -importcert -alias "swet-tuf-cer" -file C:\\Services\\devs\\curl\\certificat\\swet-tuf-test.cer \
	-keystore C:\\Services\\devs\\java\\jdk\\openjdk\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\jre\\lib\\security\\cacerts
</pre>

#### voir le detail d'un certificat
<pre>
keytool -printcert -v -file swet-tuf-test.cer
</pre>

#### lister les certificats sans le détail dans le keystore
<pre>
keytool -list -keystore C:\\Services\\devs\\curl\\certificat\\swet-tuf-test.cer \
	-keystore C:\\Services\\devs\\java\\jdk\\openjdk\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\jre\\lib\\security\\cacerts
</pre>

#### lister les certificats avec detail dans le keystore
<pre>
keytool -list -v -keystore C:\\Services\\devs\\curl\\certificat\\swet-tuf-test.cer \
	-keystore C:\\Services\\devs\\java\\jdk\\openjdk\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\jre\\lib\\security\\cacerts
</pre>

#### lister avec alias
<pre>
keytool -list -keystore .keystore -alias foo

keytool -list -alias "swet-tuf-cer" -v -keystore C:\\Services\\devs\\curl\\certificat\\swet-tuf-test.cer \ 
	-keystore C:\\Services\\devs\\java\\jdk\\openjdk\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\jre\\lib\\security\\cacerts 
</pre>

#### supprimer avec alias
<pre>
keytool -delete -alias "swet-tuf-cer" \
	-keystore C:\\Services\\devs\\curl\\certificat\\swet-tuf-test.cer -keystore C:\\Services\\devs\\java\\jdk\\openjdk\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\java-1.8.0-openjdk-1.8.0.242-3.b08.redhat.windows.x86_64\\jre\\lib\\security\\cacerts
</pre>