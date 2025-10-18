GitHubCopilot est un assisant qui utilise l'IA.
Comment fonctionne-t-il ?
Plus le contexte este bon, meilleure sera la réponse.
GithubCopilot utilise plusieurs grands modèles de langage (LLM) afin de faire des prédictions ou d'analyser et de vous donner des suggestions sur votre code ou sur vos questions de programmation.
Il utilise des modèles fournit par les grand fournisseurs : OpenAI, modèles GPT, Anthopic (claude).
Github Copilot et ses modèles sont formés sur du code gratuit disponible sur GitHub.
Plus les données sont nombreuses, meilleurs sont les résultats ; c'est pour cela que les langages populaires auront plus de succès avec cet assisant.

Que permet il de faire : améliorer la productivité.
- fonction d'autocomplétion très rapide et puissante
- solutions simples à vos questions très rapidement
- il connait le contexte de votre question  ; il n'y a pas besoin de l'expliquer
- expliquer et documenter le code, les messages d'erreurs et les corriger parfois
- générer des tests ou du code standard

Comment cela marche:
* contexte : peut être le ficher ouvert ou tout le workspace
* en fonction du context et du prompt fournit, GC renverra des suggestions
* il y a alors 3 options possibles:
	* accepter la suggestion
	* la rejeter
	* itérer en clarifiant la question pour une meilleure réponse

Limitation
* c'est un outils
* il ne remplace pas l'expérience
* il dépend du contexte
* limité avec une grande code base (les LLMs sont limités)

Diagnostic dans VS Code
ctrl + shift + p => GitHub Copilot Diagnosic
	=> voir la partie réseau.

## GitHub Copilot Chat

ctrl + Alt + I : ouvre le chat
Ask Mode
Add Context : permet d'ajouter du context à la demande
Sélectionner du text dans le fichier ouvert permet d'affiner le contexte
	* permet de demander toute information générale relative à la programmation
	* interroger copilot sur les fichiers et la structure des données de notre projet

Edit Mode:
* Copilot modifier directement les fichiers
* il faut se po

Agent Mode:
* Copilot a la possibilité d'éditer les fichiers mais aussi d'invoquer les commandes à l'intérieur du terminal

Modèles:
Certains modèles sont plus performants que d'autres pour certaines tâches
GPT 4.1 sont asses puissants
Claude sonnet plus puissant pour générer du code

Chat Vocal: VC Code speech

### Modifier un fichier :
ctrl + i dans le fichier ou je veux faire la modif et mode ask
il faut alors enregistrer la modif pour la prendre en compte

mode Edit avec sélection dans le fichier ; 
* Copilot va alors éditer le fichier et faire la mise à jour ; on peut observe le résultat.
* il faut alors accepter ou refuser la modif propopsé.

### Tools
#### Participants: @
Indique à Copilot la portée de la question
@workspace, @GitHub, @Terminal

### Commande Slash
Commande utilitaire :
/seach
/clear:
/help: information

### HashTags
Liste d'outils intégrés dans Copilot qui permette d'orienter la recherche
Avec des outils, les modèles peuvent même prendre des mesures ou autres actions que sur les données surlesquelles elles sont entraînées.
#fetch : permet de donner une url cible sur lequel copilot va faire sa recherche. Cela est utile pour analyser de grosse documentation.