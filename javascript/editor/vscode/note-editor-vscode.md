# Visual Studio Code Configuration

[retour](../../index-js.md)

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
* pour faire tourner @angular/cli => ng sous VSCode, il faut ex�cuter VSCode en tant qu'administrateur
	1- Right click the shortcut or app/exe
	2- Go to properties
	3- Compatibility tab
	4- Check "Run this program as an administrator
</pre>

## Raccourci clavier

### general

<pre>
ctrl shift ù : terminal
ctrl shift p : commande palette
ctrl shift 'k' : supprimer une ligne
ctrl 'g' : accéder à la ligne/colonne
</pre>

### Paramètre

<pre>
ctrl '+' : paramètre
</pre>

### Correction automatique

<pre>
alt 'F8' : voir la consigne de correcton
ctrl ';' : voir la correction proposer par le linter
</pre>

### duplication code

<pre>
maj + alt + flèche bas : duplication de la ligne vers le bas
alt click click => actions multi-ligne
alt shift => selection multi-ligne
</pre>

### Formatage du code

<pre>
alt + shift + f : formatter le code
</pre>

### commentaires

<pre>
ctrl k c
ctrl /
</pre>

## Fichier de configuration

<pre>
.vscode/settings.json
C:\Users\grouault\AppData\Roaming\Code\User\settings.json
</pre>

### tabulation

<pre>
editor.tabSize => 2
</pre>

## Linter ==> Standardjs

## Snippet ==> Standardjs - snippet

## Emmet

<a href="https://code.visualstudio.com/docs/editor/emmet" target="_blank">reference</a>

<pre>
- Permet d'obtenir des raccourcis de code.

- Activer pour 'React'
  Paramètre/workspace/Extensions/Emmet
  include language : javascript:javascriptreact

-Faire fonctionner Emmet avec React sous VS Code
  Si emmet ne fonctionne pas avec React, il vous faut rajouter cette ligne dans votre "setting.json" :
  "emmet.includeLanguages": { "javascript": "javascriptreact" },
  "javascript.validate.enable": false,
  "standard.enable": true
</pre>

## extension react/redux

## ES7-React/Redux extension

<pre>
rfc-tab ==> création d'un composant fonctionnelle
</pre>
