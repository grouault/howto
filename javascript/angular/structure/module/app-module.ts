/*
src/app
app.module.ts
Module principale de l'application
*/
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';


import { AppComponent } from './app.component';
import { MonComposantComponent } from './components/mon-composant/mon-composant.component'

@NgModule({
  declarations: [
    AppComponent,
    MonComposantComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent] /*  qu'est ce que je dois bootstraper / démarrer pour initialiser le module */
})
export class AppModule { }
