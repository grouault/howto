## Pipe

[structure](../structure.md)

### définition
<pre>
Les Pipes sont des filtres utilisables directement depuis la vue afin de transformer les valeurs lors du "binding".
</pre>

### pipe async
<pre>
* Le Pipe async est un Pipe capable de <b>consommer des Observables (ou Promise)</b> 
* en appelant <b>implicitement</b> la méthode <b>subscribe (ou then)</b> 
* afin de "binder" les valeurs contenus dans l'Observable (ou la Promise).
* Dans les cas des Observables, le Pipe est unsubscribe automatiquement à la destruction de la vue.
</pre>

#### exemple
```
    <tr *ngFor="let p of products | async">
      <td>{{p.id}}</td>
      <td>{{p.name}}</td>
      <td>{{p.price}}</td>
      <td>{{p.quantity}}</td>
      <td>{{p.selected}}</td>
      <td>{{p.available}}</td>
    </tr>
```

### Exemple

#### date
<pre>
export class Hero{
  id: number;
  name: string;
  birthday: Date;
}

birthday: new Date(1988, 3, 15)

<div><span>birthday:</span>{{hero.birthday | date:'dd/MM/yyyy'}}</div>

</pre>

#### uppercase
<pre>
<h2>{{hero.name | uppercase}} Details</h2>
</pre>