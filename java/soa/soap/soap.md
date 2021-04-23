## D�finition
* SOA: Architecture orient�e Service
* ROA: Architecture orient�e Ressource (REST)
* Architecture Java : 
> Architecture java dont les objets partagent la m�me m�moire. Il s'agit du sch�ma de base dans lequel une application est d�ploy� sur une machine.
* Architecture Java Distribu� (Java RMI) : 
> Architecture dont les objets java sont issus de plusieurs zones m�moires. 
> Deux applications install�es sur des machines diff�rentes par exemple et qui ont besoin de communiquer.
> Les objets Javas sont issu de deux marchine virtuelle diff�rentes.

## Service Synchrone / Asynchrone
* synchrone : communication bloquante entre deux tiers
* asynchrone : communication dans lequel un interm�diaire (un middleware) permet de garantir l'acheminement d'un message

## Middleware / mom
* mom : middleware orient� message
* broker qui permet de g�rer une communication asynchrone entre deux tiers.
* File d'attente / topic (bo�te aux lettre qui stocke des messages)
* Pour communiquer, deux tiers ont besoin de deux topics :
	- un tiers (1) envoie ses donn�es vers son propre topic ; l'autre tiers (2) souscrit (subscribe) alors � ce topic.
	- inversement le tiers (2) envoie ses donn�es vers son propre topic ; l'autre tiers (1) souscrit alors au topic (2).

## SOAP (HTTP / XML)
* est un protocole d'�change inter-applications, ind�pendant de toute plate-forme/langage, bas� sur le langage XML.
* est un flux ASCII encadr� des balies XMLs et tansport� dans le protocole HTTP (ou autre protocole)

### WebService SOAP
- Requ�te HTTP, qui envoie un message xml vers le serveur
- R�ponse HTTP, qui envoie un message au format Xml �galement
=> �change de message XML entre les applications
- requ�te et r�ponse SOAP.

### WSDL
- Web Service Description Language : fichier xml qui permet de faire la description de l'interface du WebService
- Permet de d�crire le Web Service (nom, adresse, les diff�rentes m�thode pouvant �tre invoqu�es, leurs signatures et le point d'acc�s)
- El�ment le composant
	* types : Permet de d�clarer le sh�ma xml qui permet de d�crire l'interface du WebService, les types de donn�es
	* message : un ensemble de messages
	* PortType : un �l�ment qui d�crit les op�rations 
	* binding : sp�cifie le codage utilis� et le protocole � utiliser pour transporter le message xml
	* service : d�crit le nom et l'adresse du webservice

#### 

### UDDI (annuaire)
- WebService qui permet de publier d'autres WebServices

### Structure d'un message SOAP
- SOAP:Envelope : d�finit le document XML comme message SOAP
- SOAP: Header : Optionnelle, stockage des infos sp�cifiques � la transaction
- SOAP: Body : m�thode, nom de l'op�ration / r�ponse ou exception
- SOAP: fault : pour reporter les erreurs

### JAX WS / JAXB
- permet de cr�er des WebServices de mani�res simples
- cr�ation de WebService avec des annotations
- JAXB permet de mapper des Objets Java dans un document XML et vice-versa
- JAX WS utilise JAXB

### SCHEMA XML
- Permet de d�finir la structure d'un fichier XML
- Permet de d�finir/d�crire les objets, leur type, attribut.
- A partir du sch�ma, on peut cr�er la classe.
- WSDL = Sch�ma pour le web-service
- Le client a le WSDL et � partir du sch�ma, on g�n�re les classes
- JAXB: xjc : permet de g�n�rer une classe

### TCPMON
https://ws.apache.org/tcpmon/tcpmontutorial.html
https://techdocs.broadcom.com/fr/fr/ca-enterprise-software/continuous-testing/devtest-solutions/8-0-2/installation/installation-des-outils-d-int_gration/ex_cution-de-tcpmon/utilisation-de-tcpmon-comme-interm_diaire-explicite.html