[home](index.md)

## display

- block : occupe la ligne entière
- inline-block: est positionnable sur la ligne en gardant les propriétés block
- inline : met tous les éléments les uns à la suite des autres sur la ligne sans tenir compte des witdh
  - attention : cette propriété laisse souvent de la place au dessus et en dessous (pour le texte,...)

## position

- static : c'est la valeur par défaut quand elle n'est pas précisé.
  - affiche l'élément dans le flux de manière static
- relative : permet d'utiliser les propriétés top/bottom/right/left
  - permet de positionner l'élément par rapport à sa position dans le flux static
  - n'impact pas la postion des autres éléments siblings
  - permet d'utiliser la propriété "absolute" sur les éléments children
- absolute: permet de postionner un élément dans l'espace d'un élément parent "relative"
  - ne dispose donc pas de son propre espace dans le flux d'affichage

## couleur et opacity

- couleur : hexadecimal: #RRJJBBOO
  - RR: rouge
  - JJ: jaune
  - BB: bleu
  - OO: composante du niveau de transparence :
    - FF: pas de transparence
    - 00: 100% transparent
    - opacity => C0

## table td|th et alignement du text

- text-align : aligne le texte horizontalement
- vertical-align : aligne le texte verticalement dans la cellule
  - top: aligne texte vers le haut dans tous les cellules
  - bottom: aligne le texte vers le base dans tous les cellules

## Image : object-fit

- object-fit: cover
  - à utiliser quand on met une taille fixe sur la hauteur de l'image
  - l'image ne se rezise pas et l'image n'est donc pas déformer
  - C'est juste que l'on perd du contenu à l'affichage

### Body

#### taille

- adapter l'image de fond à la fenêtre
  (css body background adapt screen)
  <pre>
  body{
    background: url("images/menu_background.jpg") no-repeat center center fixed;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    color: #fff
  }  
  </pre>

#### scroll de l'image de fond:

  <pre>
  background-attachement: scroll;
  </pre>

#### overlay

- (css body background overlay)
- linear-gradient
<pre>
body{
  background: linear-gradient(0deg, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url("images/menu_background.jpg") no-repeat center center fixed;
}
</pre>

### center div on page

- (css center div on page)
<pre>
  position: fixed; /* or absolute */
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
</pre>