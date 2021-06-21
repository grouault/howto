## Enjeu SSL / TLS
<pre>
* Chiffrer : cacher les informations afin que personne n'identifie ces informations
* Identifier : s'assurer que l'ordinateur avec lequel on cummunique est bien le bon
</pre>

## Chiffrement

### Type de Cryptographie


#### Cryptographie asym�trique
##### Principe 
<pre>
* �change entre un client et un serveur.
* le serveur poss�de
	* une <b>cl� publique</b>
	* une <b>cl� priv�e</b>
	
1- <i>Client vers Serveur</i>
* La cl� publique est envoy�e au client pour chiffrer les infos
* La cl� priv�e est utilis�e par le serveur pour d�chiffrer les infos chiffr�es avec la cl� publique

2- <i>Serveur vers Client</i>
* Le serveur chiffre avec sa cl� priv�e 
* le client d�chiffre avec sa cl� publique

<b>Probl�me</b>
	* Seul la s�curit� est garantie dans le sens Client vers Serveur
		* car seul la cl� priv�e connu simplement du serveur peut d�chiffrer
	* Dans l'autre sens, 
		* toute info envoy�e par le serveur peut �tre d�chiffrer 
			par tous ceux qui poss�dent la cl� publique
</pre>

#### Cryptographie sym�trique
##### Principe 
<pre>
Plut�t que d'avoir deux cl�s comme dans la crypto asym�trique :
	* seul <b>une seul cl� indentique</b> est partag�e entre le client et le serveur
	* cl� utilis� pour <b>chiffer</b> et <b>d�chiffrer</b> les informations
	* syst�me plus performant car il permet de chiffre plus rapidement
	
<b>Probl�matique : Comment �changer cette cl�</b>
1- le <b>navigateur</b> entre en <b>communication</b> avec le <b>serveur</b> en indiquant les param�tres suivants
	* clef : type de cl� qu'il supporte (RSA / DH-RSA / PSK)
	* cipher : algorithme de chiffrage
	* hash : permet de v�rifier l'int�grit� d'un message
		* (HMAC-MD5)
2- le <b>serveur</b> �tablit alors ses <b>priorit�s</b> :
	* je veux utiliser le couple [cle / cipher / hash]
	* de plus, le serveur enovie une <b>cl� publique</b> au client
		* pour qu'il puisse chiffer tous les infos � envoyer au serveur
		
3- g�n�ration d'une cl� <b>pr�-master-secret</b> par le <b>client</b>
	* le client et le serveur � ce stade se sont mis d'accord sur les propri�t�s de la cl�
	* le client g�n�re une cl� pre-master-secret qui sert � g�n�rer la cl� sym�tique
	* le pr�-mater-secret est <b>chiffr�</b> avec la <b>cl� publique</b> 
	* le pr�-mater-secret est <b>envoy� au serveur</b>
	
4- <b>serveur</b> : g�n�ration de la cl� sym�trique
	* le serveur d�chiffre le pr�-master-secret avec sa <b>cl� priv�e</b>
	* les deux ont le pr�-master-secret et peuvent alors obtenir la <b>cl� sym�trique</b>	

<b>Probl�me</b>
	* Ce syst�me permet de rem�dier au probl�me de chiffrage
	* <b>Ne r�souds pas</b> le <b>probl�me d'identification</b>, car n'importe qui peut 
		* g�n�rer une cl� publique et priv�e
		* donc se faire passer pour le serveur
	
</pre>


##### Sch�ma des cl� sym�trique
<pre>
* voila les infos que je veux envoy� :
	* infos que je souhaite post�es
	* url
	* header
	
<i>voir schma ci-dessous</i>	
</pre>

![img](img/cle-symetrique-0.PNG)

<pre>
* le navigateur 
	* utilise la cl� pour chiffrer le message
	* envoie le message au serveur

<i>voir schemas ci-dessous</i>
</pre>

![img](img/cle-symetrique-1.PNG)
![img](img/cle-symetrique-2.PNG)

<pre>
* le serveur utiliser :
	* la cl� sym�trique pour d�chfiffer le message
	* obtenir les infos demand�es par le client
<i>voir schema ci-dessous</i>
</pre>

![img](img/cle-symetrique-3.PNG)

<pre>
* le serveur utilise un langage de programmation pour g�n�rer la r�ponse au client
	* g�n�ration de la ressouce demand�es : html, image, ...

<i>voir schema ci-dessous</i>
</pre>

![img](img/cle-symetrique-4.PNG)

<pre>
* le serveur utilise :
	* la cl� sym�trique pour chiffrer les donn�es

<i>voir schema ci-dessous</i>
</pre>

![img](img/cle-symetrique-5.PNG)
![img](img/cle-symetrique-6.PNG)

<pre>
* le serveur envoie les donn�es chiffr�es aux clients

<i>voir schema ci-dessous</i>
</pre>

![img](img/cle-symetrique-7.PNG)


<pre>
* le client :
	* recoit les donn�es chiff�es 
	* utiliser la cl� sym�trique pour d�chiffrer
	
<i>voir schema ci-dessous</i>
</pre>

![img](img/cle-symetrique-8.PNG)
![img](img/cle-symetrique-9.PNG)

## Indentification

### Certificat

#### d�finition
<pre>
* <b>certificat </b> : on peut imaginer cela comme une <b>carte d'identit�</b> pour ton serveur
	* contient diverses informations
	* permet de s'assurer que vous �tes bien la personne que tu pr�tends �tre
</pre>	

#### g�n�ration
<pre>	
* <b>autorit� de certification (AC)</b> : comme pour une carte d'identit� o� on va en mairie,
	on passe par une autorit� de certification capable de d�livrer des certificats

* <i>mode op�ratoire</i>:
	1- envoie d'informations : domaine, nom, email, .... + <b>cl� publique</b>
	2- autorit� de certification
		* fait des v�rifications
		* envoie alors un certificat qui contient :
			* votre cl� publique
			* les infos communiqu�
			* une <b>signature</b> : combinaison [cl� publique  + infos]
				<b>chiffr� par la cl� priv�e de l'autorit� de certification</b>
	<b>Important</b> : 
		* Le seul moyen pour v�rifier le certificat est alors d'utiliser 
			<b>la cl� publique de l'autorit� de certification</b>
			
</pre>
 
![img](img/ac-0.PNG)
 
#### Certifcat interm�diaire et racine

##### Certificat interm�diaire
<pre>
* L'autorit� de certification envoie en g�n�ral
	* le certificat
	* plus son certificat � lui appel� : <b>certificat interm�diaire</b>
</pre>

##### Certificat racine
<pre>
* Probl�me : de nombreux organismes d�livrent des certificats
* il a fallu d�finir des autorit�s de certification racine limit�s et reconnue comme de confiance
* Ce sont eux qui donnent des certificats � d'autres organismes (autorit�s de certificat interm�diaire)
	qui vont d�livr�s des certificats � des individus ou organismes

* Dans le sch�ma ci-dessous:
	* AC interm�diaire renvoie
		* son certificat
		* le certificat du serveur demand� � �tre certifi�
	
	* le certificat de l'AC interm�diaire a �t� �tablit par une AC racine

<i>voir sch�ma ci-dessous</i>
</pre> 

 ![img](img/ac-1.PNG)

#### Principe de fonctionnement : chaine de confiance
<pre>
<i>Sc�nario</i>
* le serveur envoie au client : 
	* son certificat : certificat valid� par une AC interm�diaire
	* certificat de l'AC interm�diaire
</pre>

![img](img/certificat-0.PNG)

<pre>
<b>Comment fait alors le navigateur pour valider les certificats ?</b>

<i>Note:</i> 
* Le navigateur est �quip� par d�faut des cl�s publiques des diff�rentes autorit�s de certification racine. 
* Il pourra alors utiliser ces cl�s publiques pour v�rifier la signature du certificat interm�diaire	
	
1- <b>validation du certificat interm�diaire</b> avec <b>la cl� publique</b> de l'<b>AC racine</b>
	* le navigateur utilise alors la cl� publique de l'autorit� racine pour v�rifier la validit� du certificat interm�diaire 
	* utilisation de la cl� publique pour d�chiffer la signature : 
		* doit retrouver les m�mes infos chiffr�es avec la cl� priv�e de l'autorit� racine

	* Conclusion pour le navigateur
		* le <b>certificat interm�diaire</b> est un certificat <b>de confiance</b>
			car j'arrive � le d�chiffrer avec la cl� publique de l'AC racine

2- <b>validation du certificat</b> avec la <b>cl� publique</b> de l'<b>AC interm�diaire</b>
	* le navigateur utilise alors la cl� publique de l'AC interm�diaire pour valider le certificat
	* utilisation de cette cl� publique pour d�chiffrer la signature :
		* doit retrouver les m�mes infos chiffr�es avec la cl� priv�e de l'autorit� de certification
		
	* Conclusion pour le navigateur
		* le <b>certificat du serveur</b> est un certificat <b>de confiance</b>
			car j'arrive � le d�chiffrer avec la cl� publique d'un autre certificat de confiance
	
</pre>
	
#### Tentative d'usurpation d'identit�
<pre>

<i>Sc�nario</i> :
* un <b>pirate</b> prend le certificat et <b>modifie</b> la cl� publique

* le <b>probl�me</b> c'est que la <b>signature</b> ne va plus correspondre
	* utilisation de la cl� publique de l'AC pour d�chiffrer
	* les infos (notamment cl� publique) ne vont plus correspondre
	
* le seul moyen d'avoir une signature correcte, c'est d'avoir la cl� priv�e de l'AC (interm�diaire)
	* ce qui est impossible
	
</pre>
 
#### Handshake
<pre>
* handshake : 
	* �tapes mises en place avant le premier �change de donn�es 
	* serrage de main qui se fait avant la premi�re connection
	* but : �tablissement de la cl� sym�trique pour �changer les donn�es de mani�re s�curis�e	
	
1- Le client
	* informe le serveur qu'il souhaite utiliser le protocole SSL ou TLS 
	* indique quelle version du protocole il va utiliser 
	* ainsi que les syst�mes de chiffrement qu'il supporte

2- Le serveur 
	* envoie au client son certificat qui contient sa cl� publique
	* indique au client quel syst�me de chiffrement il a choisi parmi les choix propos�s

3- Le client 
	* tente alors de d�chiffrer la signature num�rique du certificat (ou du certificat interm�diaire) 
		� l'aide des cl�s publiques des AC int�gr�es par d�faut dans le navigateur.
	* Si le certificat interm�diaire est jug� de confiance, on utilise sa cl� publique pour v�rifier le certificat du serveur.
	* Si la signature du certificat interm�diaire, ou du certificat du serveur n'est pas d�chiffrable 
		alors le navigateur affichera une alerte comme quoi le certificat n'est pas valable et 
		l'utilisateur peut choisir de continuer � communiquer avec ce serveur malgr� tout ou de s'arr�ter l�.

<i>voir sch�ma ci-dessous</i>
</pre>

![img](img/certificat-1.PNG)

<pre>
4- Le client
	* g�n�re alors une cl� pemaster secret 
	* et la chiffre avec la cl� publique re�ue � l'�tape 2. 
	* Il envoie alors cette cl� chiffr�e au serveur 
	* le <b>client</b> utilise le <b>pre-master secret</b> pour g�n�rer la <b>cl� de session sym�trique</b>.

5- le serveur re�oit le pre-master-secret

<i>voir sch�ma ci-dessous</i>	
</pre>

![img](img/certificat-2.PNG)

<pre>
5- Le serveur 
	* d�chiffre le pre-master-secret � l'aide de sa cl� priv�e 
	* utilise le <b>pre-master-secret</b> aussi pour g�n�rer la <b>cl� de session sym�trique</b>

6- Le serveur et le client disposent alors maintenant qu'une cl� sym�trique qui permettra de chiffrer les futurs �changes.
	
7- Une fois la connexion termin�e (apr�s un temps d'inactivit� pr�d�finie ou par l'envoi d'un signal de d�connexion) 
	* le serveur va r�voquer la cl� de session. 
	* et il faudra alors repasser par toutes les �tapes pr�c�dentes pour entamer une nouvelle connexion.	
	
<i>voir sch�ma ci-dessous</i>
</pre>

![img](img/certificat-3.PNG)
