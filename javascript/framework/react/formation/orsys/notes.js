var a = 1;
var b = a; // Passage par copie



/*
b = 42;
console.log(a); // 1
console.log(b); // 42
*/



var c = {a: 1, b: 2};
var d = c; // Passage par référence
d.a = 42;
console.log(c.a); // 42
console.log(d.a); // 42

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


// En JavaScript, le mot-clé this représente l'appelant et non pas le déclarantclass User {
constructor(firstname) {
this._firstname = firstname;
}
sayMyName() {
// SOLUTION 1
var that = this;
setTimeout(function() {
that._sayName();
}, 1000);

// SOLUTION 2
setTimeout(function(context) {
context._sayName();
}, 1000, this)

// SOLUTION 3
setTimeout(function() {
this._sayName();
}.bind(this), 1000);

// SOLUTION 4
setTimeout(() => {
this._sayName();
}, 1000);
}
_sayName() {
    console.log("Bonjour, je m'appelle " + this._firstname);
}

const joe = new User('Joe');
joe.sayMyName();

const [a, b,, d, [f, g]] = [1, 2, 3, 4, [5, 6]];
console.log(f, g); // 5 6

