# html

[retour](../index-howto.md)

## html

### fonctionnement du web
<pre>
<a href="https://developer.mozilla.org/fr/docs/Learn/Getting_started_with_the_web/How_the_Web_works" target="_blank">
le fonctionnement du web</a>

<pre>

Le navigateur commence par l'analyse du fichier HTML, ce qui lui permet de reconnaître 
les éventuels éléments < link > (pour les feuilles de style CSS externes) et < script >
 (pour les scripts).

Pendant l'analyse du fichier HTML, le navigateur envoie des requêtes au serveur pour 
les différents fichiers CSS indiqués par les éléments < link > et pour les fichiers JavaScript 
indiqués par les éléments < script >. 

Lorsque le navigateur a reçu ces fichiers, il analyse alors leur contenu CSS et JavaScript.
En mémoire vive, le navigateur génère une structure à partir du document HTML analysé : 
un arbre, qu'on appelle le DOM. Pour le CSS, il génère en mémoire une structure
 qu'on appelle le CSSOM. Le code JavaScript analysé est compilé et exécuté.

Quand le navigateur 
* construit l'arbre du DOM, 
* lui applique les styles à partir de l'arbre du CSSOM 
* et exécute le JavaScript, 
une représentation visuelle de la page est affichée à l'écran : 
l'utilisatrice ou l'utilisateur peut alors voir le contenu de la page 
et commencer à interagir avec.
</pre>


</pre>


## style

[css](./cours/css/notes-css.md)

[bootstrap](./cours//bootstrap/notes-bootstrap.md)
