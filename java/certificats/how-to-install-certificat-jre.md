En ligne de commande

1. positionner le JAVA_HOME et copier le fichier "kircher-DER-2012.der" dans ce repertoire

2. keytool -import -trustcacerts -keystore "%JAVA_HOME%\jre\lib\security\cacerts" -file kircher-DER-2012.der

3. tapez le mot de passe du Keystore :  changeit
   PropriÚtaire : CN=laplace.citepro.cite-sciences.fr, O=CSI
   +metteur : OU=Organizational CA, O=CSI
   NumÚro de sÚrie : 21c11fab2382016ae69fdd6d453303a9db0c879c4abf63b6d4f89ccd3820202024e
   Valide du : Mon Nov 26 13:05:51 CET 2007 au : Wed Nov 25 13:05:51 CET 2009
   Empreintes de certificat :
			MD5 :  28:89:50:8D:EA:4F:6A:A5:E1:CC:10:C1:D0:31:1A:A9
			SHA1: 3A:61:03:92:62:73:F9:46:06:71:5F:69:D9:6D:1D:F0:19:29:09:F0
   Faire confiance Ó ce certificat ? [non] :  oui
   Certificat ajoutÚ au Keystore
                                               
</p>


## Paramétrage tomcat

<pre>
Pour Tomcat, il a fallut l'aider pour qu'il trouve le cacerts (ajouts dans la ligne de cmd):
----------------------------------------------------------------------------------------------
-Djavax.net.ssl.trustStore="D:\devs\tools\Java\jdk1.6.0_01\jre\lib\security\cacerts" 
-Djavax.net.ssl.trustStorePassword=changeit 
-Djavax.net.ssl.trustStoreType=jks
</pre>



