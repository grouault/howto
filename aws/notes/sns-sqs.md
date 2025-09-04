SQS => consommateur
SNS => producteur
publish <==> suscribe


KAFKA <==> SQS : lambda peut écouter de matière automatique

AWS => SQS => TAMPON

### pricing 
Le MS écoute une queue SQS qu'il lui indique qu'une commande est arrivée.
Cela permet notamment d'invalider le cache de TARIFS Redis AWS. 
La commande est créer quand terminer dans SalesCart ; le message kafka part pour création de la commande. Un message sera envoyé sur SNS pour nettoyer le cache Pricing.
	=> cela permet de nettoyer le contexte utilisateur
	=> kafka pour dire que commande terminer
	=> MS s'occupe de ca
	
Dans le cas d'abandon de panier, pas possible de nettoyer le cache pricing car on ne termine pas le panier et on ne créé pas de commande.

### LocalStack
Conteneur qui permet de simuler des services AWS
localstack ==> simuler les service cloud usuel (mutlizone mal géré par localStack => us-east-1)
	==> sns, sqs, s3
	==> conteneur
	==> script shell pour démarrer le topic et qui s'exécute au démarrage du conteneur
	
PARAMETRAGE de profils
- coginito int
- cognito rec ==> application-local-idp-rec.yaml
	=> permet de définir les variables d'environnement non setté
	
Prise en compte des tests d'intégration :
Lancement de container éphèmère
Il faut créer un LocalStack
	waitingFort ==> on s'attend à recevoir ce message sur la sortie Standard...
	port affecté au dessus du port 30000
		dire à spring le contenu de la variable : aws.sns.endpoint=
		==> TestITConfig
		
		Communication applicatif <==> conteneur pour que les 2 communiquent
		
Config wsl :

Docker ==> LocalStack
java.testcontainers.org/modules/localstack
https://docs.localstack.cloud/aws/services/sns/

localhost:4566/_localstack/swagger