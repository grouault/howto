
## kill
taskkill /PID <PID> /F
netstat -ano | findstr :4200

## ping
C:\>ping/all scel2.cite-sciences.fr

Envoi d'une requ�te 'ping' sur scel2.cite-scienceS.fr [192.168.21.217] avec 32 octets de donn�es�:

R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253
R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253
R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253
R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253

Statistiques Ping pour 192.168.21.217:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
Dur�e approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms

C:\>ping scel2.cite-sciences.fr
-------------------------------
Envoi d'une requ�te 'ping' sur scel2.cite-scienceS.fr [192.168.21.217] avec 32 octets de donn�es�:

R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253
R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253
R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253
R�ponse de 192.168.21.217�: octets=32 temps<1ms TTL=253

Statistiques Ping pour 192.168.21.217:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
Dur�e approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms

## Commande d'identifiaction du nom du pc
C:\>nbtstat -A 172.19.76.89

Connexion au r�seau local 2:
Adresse IP du noeud�: [0.0.0.0] ID d'�tendue�: []

    H�te introuvable.

Connexion au r�seau local:
Adresse IP du noeud�: [172.19.76.89] ID d'�tendue�: []

    Table de noms NetBIOS des ordinateurs distants

       Nom                Type         �tat
    ---------------------------------------------
    PC-00059598    <00>  UNIQUE      Inscrit
    CITEPRO        <00>  Groupe      Inscrit
    PC-00059598    <20>  UNIQUE      Inscrit

    Adresse MAC = 00-21-5A-69-11-D0
	
	
