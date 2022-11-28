[home](../../index-js.md)

## Introduction

### Principe

![principe](formation/img/0-react-native.PNG)

### Composants

![c1](formation/img/1-composant-react-native.PNG)
![c2](formation/img/2-composant-react-native.PNG)
![c3](formation/img/3-composant-react-native.PNG)

### Style

[lien-utile](https://github.com/vhpoet/react-native-styling-cheat-sheet#flexbox)

#### Mise en place

<pre>
* Passage de style sous-forme de tableau
	* permet de concaténer plusieurs souces de style
< View style="{[{background-color: this.props.color}, styles.container]}" >

const styles = StyleSheet.create({
	container: {height: 50, width: 50}
});
</pre>

### Composant

<pre>
* FlatList

* Image

* TextInput

* Button
</pre>

### les touchables

<pre>
* rendre les éléments cliquables d'un point vue visuel (feedback)
* ressenti utilisateur
</pre>

![](formation/img/touchables.PNG)
