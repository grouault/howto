
data-fetching and useEffect

[retour](./index-datafetching.md)
## fetching on mount

Mais... utiliser `useEffect` pour **fetch on mount** est une _mauvaise pratique_, comme [la doc React le dit](https://react.dev/learn/synchronizing-with-effects#what-are-good-alternatives-to-data-fetching-in-effects) :

Écrire des appels fetch à l'intérieur des Effects est une manière populaire de récupérer des données, particulièrement dans les applications entièrement côté client. Cependant, cette approche est très manuelle et présente des inconvénients significatifs :

- **Les Effects ne s'exécutent pas sur le serveur**. Cela signifie que le HTML initial généré par le serveur n'inclura qu'un état de chargement sans données. L'ordinateur client devra télécharger tout le JavaScript et afficher ton application seulement pour découvrir qu'il doit maintenant charger les données. Ce n'est pas très efficace.
- **Récupérer directement dans les Effects facilite la création de "cascades réseau"**. Tu affiches le composant parent, ils récupèrent des données, affichent les composants enfants, et ensuite ils commencent à récupérer leurs données. Si le réseau n'est pas très rapide, cela est nettement plus lent que de récupérer toutes les données en parallèle.
- **Récupérer directement dans les Effects signifie généralement que tu ne précharges pas ou ne mets pas en cache les données.** Par exemple, si le composant se démonte puis se remonte, il devra récupérer les données à nouveau.
- **Ce n'est pas très ergonomique.** Il y a pas mal de code standard impliqué lors de l'écriture d'appels fetch d'une manière qui ne souffre pas de bugs comme les conditions de concurrence.

(traduction de ce qui est expliqué dans le lien)