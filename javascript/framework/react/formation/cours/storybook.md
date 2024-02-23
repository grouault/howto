## StoryBook

### Définition
<pre>
Storybook s'éxécute parallèlement à votre application en mode développement. 
Il vous aide à construire des composants UI(User Interface) qui sont isolés
* de la logique applicative 
* et du contexte de votre application.
</pre>

### Principe : Component Driven Development (CDD)
<pre>
Bas en haut :
construction des interfaces utilisateurs en commançant par les composants et
en terminant par les écrans.

* écriture des test d'états (tient compte du state du composant)
  dans un fichier de story
  ==> Classe : Composant.stories.js

* utilisation de StoryBook pour contruire le composant
  de façon isolée en utilisant les données simulées.
* on test manuellement l'apparence du composant en fonction de 
  chaque état

</pre>

### Configuration

#### .storybook/main.js
<pre>
module.exports = {
  //👇 Location of our stories
  stories: ['../src/components/**/*.stories.js'],
  addons: [
    '@storybook/addon-links',
    '@storybook/addon-essentials',
    '@storybook/preset-create-react-app',
  ],
};
</pre>

#### .storybook/preview.js
<pre>
* permet de prendre en compte les CSS
* permet de définir de manière générale les actions
</pre>

```
import '../src/index.css'; //👈 The app's CSS file goes here

//👇 Configures Storybook to log the actions( onArchiveTask and onPinTask ) in the UI.
export const parameters = {
  actions: { argTypesRegex: '^on[A-Z].*' },
};

parameters: 
* sont généralement utilisés pour contrôler le comportement des fonctionnalités 
  et des addons de Storybook. Dans notre cas
* utiliser pour configurer la manière dont les actions 
  (les callbacks simulés) sont gérées.
</pre>

```

### Eléments de StoryBook
<pre>
* composant

* story

* Actions:
  Actions vous aident à vérifier les interactions lors de la construction des 
  composants de l'UI en isolation. 
  Souvent, vous n'aurez pas accès aux fonctions et à l'état dont 
  vous disposez dans le contexte de l'application. 
  Utilisez action() pour les simuler.

  * permettent de créer des callbacks qui apparaissent dans le panneau actions 
    du UI de Storybook lorsqu'on clique dessus. 

</pre>

### Component.stories.js
<pre>
Il y a deux niveaux d'organisation de base dans Storybook : 
* le composant
* ses story enfants. 
Considérez chaque story comme une permutation d'un composant. 
Vous pouvez avoir autant de story par composant que vous en voulez.

Composant
  Story
  Story
  Story

<b>Composant</b>:
Pour informer Storybook sur le composant que nous documentons, nous créons un default export qui contient:
  * component -- le composant lui-même,
  * title -- comment faire référence au composant dans la barre latérale de l'application Storybook,

<i>
export default {
  component: Task,
  title: 'Task',
};
</i>

<b>Story</b>:
Pour définir nos story, nous exportons une fonction pour chacun de nos 
états tests afin de générer un story. 
Le story est une fonction qui renvoie un élément qui a été rendu 
(c'est-à-dire un composant avec un ensemble de props) 
dans un état donné--exactement comme un Functional Component.

<i>
// Template par default.
const Template = (args) => <Task {...args} />;

// Copie et création d'un contexte
// export const Default = Template.bind({});
export const Default = {...Template};
Default.args = {
  task: {
    id: '1',
    title: 'Test Task',
    state: 'TASK_INBOX',
    updatedAt: new Date(2018, 0, 1, 9, 0),
  },
};
</i>

</pre>