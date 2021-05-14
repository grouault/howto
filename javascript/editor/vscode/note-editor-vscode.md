Visual Studio Code Configuration

## Espace de travail
<pre>
* correspond � un workspace Eclipse
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
* pour faire tourner @angular/cli => ng sous VSCode, il faut ex�cuter VSCode en tant qu'administrateur
	1- Right click the shortcut or app/exe
	2- Go to properties
	3- Compatibility tab
	4- Check "Run this program as an administrator
</pre>

## Raccourci clavier

# Param�tre
ctrl '+' : 

# Correction automatique
alt 'F8' : voir la consigne de correcton
ctrl ';' : voir la correction proposer par le linter

ctrl '�' : terminal
ctrl shift p : commande palette
ctrl shift 'k' : supprimer une ligne
ctrl 'g' : acc�der � la ligne/colonne

## Fichier de configuration
.vscode/settings.json
C:\Users\grouault\AppData\Roaming\Code\User\settings.json

## Linter ==> Standardjs

## Snippet ==> Standardjs - snippet

## Emmet
- Permet d'obtenir des raccourcis de code. 
- Activer pour 'React'
	Param�tre/workspace/Extensions/Emmet
	include languate : javascript:javascriptreact
	
	
	    "javascript.validate.enable": false,
    "standard.enable": true