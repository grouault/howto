# keytool cmd

## Définition

### fichier cacerts / keystore

<a href="http://blog.nouveauxterritoires.fr/fr/2013/11/21/gestion-des-certificats-ssl-avec-java/" target="\_blank"> url</a>

<pre>
Contient les certificats

nous devons générer une paire de clés cryptographiques, les utiliser pour
- produire un certificat SSL l
- le stocker dans un keystore.
La documentation keytool définit un keystore comme une base de données de
"clés cryptographiques,
chaînes de certificats X.509
et certificats de confiance
</pre>

## Général

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

#### lister les certificats sans le d�tail dans le keystore

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

## SpringBoot / React

### url

<a href="https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#howto.security.enable-https" target="_blank">doc</a>
<a href="https://www.thomasvitale.com/https-spring-boot-ssl-certificate/" target="_blank">tomas vitale</a>
<a href="https://mkyong.com/spring-boot/spring-boot-ssl-https-examples/" target="_blank">spb mykong</a>
<a href="https://letsencrypt.org/fr/getting-started/" target="_blank">let's encrypt</a>

#### tomcat

<a href="https://mkyong.com/tomcat/how-to-configure-tomcat-to-support-ssl-or-https/" target="_blank">tomcat mykong</a>
<a href="https://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html#Configuration" target="_blank">tomcat mykong</a>

### principe / certificat auto-signé

<pre>
L'idée est de créer un certificat.
Le certificat sera mis dans les ressources de Spring-Boot.
Une configuration est nécessaire dans le fichier application.properties 
</pre>

### chrome

<pre>
chrome://flags/#allow-insecure-localhost
</pre>

### Format

<pre>
Format : 
- common format : JKS
- industry-standard format: PKCS12
Depuis Java9, il est recommandé d'utiliser PKCS12

Le format PKCS12:
Le fichier qui contient 
- le certificat : file.crt
- le clés

pem: format populaire pour Apache et Nginx.
Mais n'est pas supporter en Java
</pre>

### créer un certificat

#### principe

<pre>
Permet de créer un certificat à un endroit ciblé.
</pre>

#### attributs

</pre>
genkeypair: generates a key pair;
alias: the alias name for the item we are generating;
keyalg: the cryptographic algorithm to generate the key pair;
keysize: the size of the key;
storetype: the type of keystore;
keystore: the name of the keystore;
validity: validity number of days;
storepass: a password for the keystore.
</pre>

#### Commandes

##### PKCS12

```
keytool -genkeypair -alias springboot -keyalg RSA -keysize 4096 -storetype PKCS12 -keystore c:\\tmp\\springboot.p12 -validity 3650 -storepass password
keytool -list -v -keystore springboot.p12
```

###### Conversion

```
## fichier .crt
openssl.exe pkcs12 -in springboot.p12 -clcerts -nokeys -out spb-publicCert.crt

## fichier .pem
openssl.exe pkcs12 -in springboot.p12 -nocerts -out spb-privateKey.pem

## retirer le pass phrase
openssl.exe rsa -in spb-publicCert.pem -out nopass.pem
```

##### JKS KeyStore

```
keytool -genkeypair -alias springboot -keyalg RSA -keysize 4096 -storetype JKS -keystore springboot.jks -validity 3650 -storepass password
keytool -list -v -keystore springboot.jks
```

##### Convert a JKS keystore into PKCS12

```
keytool -importkeystore -srckeystore springboot.jks -destkeystore springboot.p12 -deststoretype pkcs12
```

##### Use an existing SSL certificate

<pre>
Exemple: après avoir générer un certificat 'Let’s Encrypt'
Il faut l'importer dans le keystore
</pre>

```
keytool -import -alias springboot -file myCertificate.crt -keystore springboot.p12 -storepass password
```

### SpB: mise en place

### application.properties

<pre>
## SSL
server.port=8443
server.ssl.key-store=classpath:springboot.p12
server.ssl.key-store-password=password
server.ssl.key-store-type=pkcs12
server.ssl.key-alias=springboot
server.ssl.key-password=password
</pre>

####définition

<pre>
server.port: the port on which the server is listening. We have used 8443 rather than the default 8080 port.
server.ssl.key-store: the path to the key store that contains the SSL certificate. In our example, we want Spring Boot to look for it in the classpath.
server.ssl.key-store-password: the password used to access the key store.
server.ssl.key-store-type: the type of the key store (JKS or PKCS12).
server.ssl.key-alias: the alias that identifies the key in the key store.
server.ssl.key-password: the password used to access the key in the key store.
</pre>

### React

#### principe

<pre>
Mettre le / les fichiers de certificatis au niveau de package.json
</pre>

#### package.json

<pre>
"start": "set HTTPS=true&&set SSL_CRT_FILE=spb-publicCert.crt&&set SSL_KEY_FILE=spb-privateKey-nopwd.pem&&react-scripts start",
"start": "set HTTPS=true&&set SSL_CRT_FILE=spb-publicCert.crt&&react-scripts start",
</pre>
