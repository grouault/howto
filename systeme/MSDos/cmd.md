
## kill
taskkill /PID <PID> /F
netstat -ano | findstr :4200

## ping
C:\>ping/all scel2.cite-sciences.fr

Envoi d'une requête 'ping' sur scel2.cite-scienceS.fr [192.168.21.217] avec 32 octets de données :

Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253
Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253
Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253
Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253

Statistiques Ping pour 192.168.21.217:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms

C:\>ping scel2.cite-sciences.fr
-------------------------------
Envoi d'une requête 'ping' sur scel2.cite-scienceS.fr [192.168.21.217] avec 32 octets de données :

Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253
Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253
Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253
Réponse de 192.168.21.217 : octets=32 temps<1ms TTL=253

Statistiques Ping pour 192.168.21.217:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms

## Commande d'identifiaction du nom du pc
C:\>nbtstat -A 172.19.76.89

Connexion au réseau local 2:
Adresse IP du noeud : [0.0.0.0] ID d'étendue : []

    Hôte introuvable.

Connexion au réseau local:
Adresse IP du noeud : [172.19.76.89] ID d'étendue : []

    Table de noms NetBIOS des ordinateurs distants

       Nom                Type         État
    ---------------------------------------------
    PC-00059598    <00>  UNIQUE      Inscrit
    CITEPRO        <00>  Groupe      Inscrit
    PC-00059598    <20>  UNIQUE      Inscrit

    Adresse MAC = 00-21-5A-69-11-D0
	
	
