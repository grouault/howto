# Promise

[retour](../es6-es9.md)

## Promise / Fonction asynchrone

<pre>
* Fonction qui se déroule de façon asynchrone
* permet d'évitéer les callbacks successifs et leur imbrication
</pre>

```
const promise = new Promise(function (resolve, reject) {
  resolve('Tout va bien');
});
console.log('Promise = ', promise);
promise.then(function (res) {
  console.log('res = ', res);
});
```

## Await / Async

<pre>
await/async: async renvoie une promesse
</pre>

<pre>
function generatePromise() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve(1);
    }, 1000);
  });
}

async function main() {
  var resultat = await generatePromise();
  console.log(resultat);
  var resultat2 = await generatePromise();
  console.log(resultat2);
  return resultat + resultat2;
}

main().then((res) => console.log(res));
</pre>

<pre>
* plusieurs éléments peuvent écouter la promesse.
const maPromise = new Promise();
maPromise.then( ... );
maPromise.then( ... );

* Important : quand une promise se termine, elle stocke
    le résultat en cache (pour une durée indéterminée)

</pre>
