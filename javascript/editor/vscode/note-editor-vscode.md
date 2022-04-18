Visual Studio Code Configuration

## Espace de travail
<pre>
* correspond à un workspace Eclipse
* on peut configurer VSCode pour un espace de travail
	* fichier de conf dans l'espace de travail
* on peut ajouter des 'projets | dossier' dans l'espace de travail
</pre>

<pre>
{
	"folders": [
		{
			"path": "..\\react-project\\premier-projet"
		},
		{
			"path": "..\\react-project\\react-2020-mg"
		},
		{
			"path": "..\\..\\ecmascipt\\es6es9"
		},
		{
			"path": "..\\..\\angular"
		}
	],
    "workbench.colorCustomizations":{
        "activityBarBadge.background": "#000",
        "editor.background": "#000"
    }	
}
</pre>

### Angular
<pre>
* pour faire tourner @angular/cli => ng sous VSCode, il faut exécuter VSCode en tant qu'administrateur
	1- Right click the shortcut or app/exe
	2- Go to properties
	3- Compatibility tab
	4- Check "Run this program as an administrator
</pre>

## Raccourci clavier

# Paramètre
ctrl '+' : 

# Correction automatique
alt 'F8' : voir la consigne de correcton
ctrl ';' : voir la correction proposer par le linter

ctrl 'ù' : terminal
ctrl shift p : commande palette
ctrl shift 'k' : supprimer une ligne
ctrl 'g' : accéder à la ligne/colonne

maj + alt + flèche bas : duplication de la ligne vers le bas
alt click click => actions multi-ligne
alt shift => selection multi-ligne

## commentaires
ctrl k c
ctrl /


## Fichier de configuration
.vscode/settings.json
C:\Users\grouault\AppData\Roaming\Code\User\settings.json

## Linter ==> Standardjs

## Snippet ==> Standardjs - snippet

## Emmet
- Permet d'obtenir des raccourcis de code. 
- Activer pour 'React'
	Paramètre/workspace/Extensions/Emmet
	include languate : javascript:javascriptreact
-Faire fonctionner Emmet avec React sous VS Code
	Si emmet ne fonctionne pas avec React, il vous faut rajouter cette ligne dans votre "setting.json" :
	"emmet.includeLanguages": {  "javascript": "javascriptreact"   },
Puis enregistrez, et c'est bon.	
	
	"javascript.validate.enable": false,
    "standard.enable": true
	
## extension react/redux
rfc-tab ==> création d'un composant fonctionnelle
