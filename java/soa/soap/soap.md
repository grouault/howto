[home](../index-soa.md)

## Définition

- SOA: Architecture orientée Service
- ROA: Architecture orientée Ressource (REST)
- Architecture Java :
  > Architecture java dont les objets partagent la même mémoire. Il s'agit du schéma de base dans lequel une application est déployé sur une machine.
- Architecture Java Distribué (Java RMI) :
  > Architecture dont les objets java sont issus de plusieurs zones mémoires.
  > Deux applications installées sur des machines différentes par exemple et qui ont besoin de communiquer.
  > Les objets Javas sont issu de deux marchine virtuelle différentes.

## Service Synchrone / Asynchrone

- synchrone : communication bloquante entre deux tiers
- asynchrone : communication dans lequel un intermédiaire (un middleware) permet de garantir l'acheminement d'un message

## Middleware / mom

- mom : middleware orienté message
- broker qui permet de gérer une communication asynchrone entre deux tiers.
- File d'attente / topic (boîte aux lettre qui stocke des messages)
- Pour communiquer, deux tiers ont besoin de deux topics :
  - un tiers (1) envoie ses données vers son propre topic ; l'autre tiers (2) souscrit (subscribe) alors à ce topic.
  - inversement le tiers (2) envoie ses données vers son propre topic ; l'autre tiers (1) souscrit alors au topic (2).

## SOAP (HTTP / XML)

- est un protocole d'échange inter-applications, indépendant de toute plate-forme/langage, basé sur le langage XML.
- est un flux ASCII encadré des balies XMLs et tansporté dans le protocole HTTP (ou autre protocole)

### WebService SOAP

- Requête HTTP, qui envoie un message xml vers le serveur
- Réponse HTTP, qui envoie un message au format Xml également
  => échange de message XML entre les applications
- requête et réponse SOAP.

### WSDL

- Web Service Description Language : fichier xml qui permet de faire la description de l'interface du WebService
- Permet de décrire le Web Service (nom, adresse, les différentes méthode pouvant être invoquées, leurs signatures et le point d'accès)
- Elément le composant
  - types : Permet de déclarer le shéma xml qui permet de décrire l'interface du WebService, les types de données
  - message : un ensemble de messages
  - PortType : un élément qui décrit les opérations
  - binding : spécifie le codage utilisé et le protocole à utiliser pour transporter le message xml
  - service : décrit le nom et l'adresse du webservice

####

### UDDI (annuaire)

- WebService qui permet de publier d'autres WebServices

### Structure d'un message SOAP

- SOAP:Envelope : définit le document XML comme message SOAP
- SOAP: Header : Optionnelle, stockage des infos spécifiques à la transaction
- SOAP: Body : méthode, nom de l'opération / réponse ou exception
- SOAP: fault : pour reporter les erreurs

### JAX WS / JAXB

- permet de créer des WebServices de manières simples
- création de WebService avec des annotations
- JAXB permet de mapper des Objets Java dans un document XML et vice-versa
- JAX WS utilise JAXB

### SCHEMA XML

- Permet de définir la structure d'un fichier XML
- Permet de définir/décrire les objets, leur type, attribut.
- A partir du schéma, on peut créer la classe.
- WSDL = Schéma pour le web-service
- Le client a le WSDL et à partir du schéma, on génère les classes
- JAXB: xjc : permet de générer une classe

### TCPMON

https://ws.apache.org/tcpmon/tcpmontutorial.html
https://techdocs.broadcom.com/fr/fr/ca-enterprise-software/continuous-testing/devtest-solutions/8-0-2/installation/installation-des-outils-d-int_gration/ex_cution-de-tcpmon/utilisation-de-tcpmon-comme-interm_diaire-explicite.html
