
## Link
<a href="https://docs.spring.io/spring-boot/reference/features/external-config.html#features.external-config.typesafe-configuration-properties.relaxed-binding" target="_blank">spb externalized configuration<a/>

<a href="https://docs.spring.io/spring-boot/appendix/application-properties/index.html">common application.properties</a>

## Principe de la substitution
Dans une application **Spring Boot**, lorsque tu utilises des variables dans ton fichier YAML avec la syntaxe `${...}`, comme :

```yaml
pdc:
  adapters:
    outbound:
      ms:
        customers:
          base-path: ${URL_WS_CUSTOMERS}

```

… Spring Boot **essaie automatiquement de substituer** cette valeur avec une variable d’environnement **au moment du lancement de l'application** (et **non** lors du build Maven).
✅ Il faut que la variable d’environnement soit définie **au moment où tu démarres l'application**.

 🔁 **Quand et comment se fait la substitution ?**
Spring Boot utilise un mécanisme appelé **Property Resolution**. Il suit cet ordre de priorité (simplifié ici) pour résoudre `${URL_WS_CUSTOMERS}` :
1. **Arguments de la ligne de commande** (`--URL_WS_CUSTOMERS=...`)
2. **Variables d'environnement du système**
3. **Propriétés dans `application.properties` ou `application.yml`**
4. **Fichiers `.properties` dans le classpath**
5. **Valeur par défaut dans le YAML si fournie** : `${URL_WS_CUSTOMERS:default-value}`
-----
❌ Ce que ça ne fait pas
> **Le fichier YAML n’est pas modifié au moment du build Maven.**  
> Le plugin Maven ne remplace pas automatiquement `${...}` par des variables d'environnement sauf si tu utilises un plugin spécifique comme le Maven `resource filtering`, ce qui **n’est pas le comportement par défaut**.

---
 ✅ Ce que ça fait
> Si les variables d'environnement **existent** dans l’environnement **au moment où l’application est lancée**, elles seront utilisées.

Donc, **si ton application est lancée dans un environnement Docker, Kubernetes, GitLab CI, etc.**, et que tu y exportes les bonnes variables (`export URL_WS_CUSTOMERS=...` ou via le `env` dans un Dockerfile/compose), **la valeur sera bien substituée**.

---

🧪 Exemple concret

`application.yml`

```yaml
customers:
  url: ${URL_WS_CUSTOMERS}
```

Dockerfile ou shell
``` bash
export URL_WS_CUSTOMERS=https://api.mycompany.com
java -jar myapp.jar
```
→ Spring Boot injectera `https://api.mycompany.com` à la place de `${URL_WS_CUSTOMERS}`.

---
 🛠 Pour forcer la substitution au build ?

Si tu veux que la substitution ait lieu **lors du build Maven**, il faut utiliser un plugin comme `maven-resources-plugin` avec filtering, mais ce n’est pas recommandé dans le contexte Spring Boot car cela empêche la flexibilité d’environnement à l’exécution.


---

## Docker / Dockefile
## 1️⃣ **WORKDIR**

✅ **Pourquoi l’utiliser ?**
- Meilleure lisibilité : tous les chemins deviennent relatifs    
- Évite d’avoir à écrire des chemins absolus partout (`/app.jar` → `app.jar`)
- Certaines applications (scripts, frameworks) supposent un répertoire de travail bien défini
---
 🟢 **Bonnes pratiques avec Spring Boot**
- Placer ton `WORKDIR` dans un dossier dédié (`/app`)
- Copier ton `.jar` **dans ce dossier**
- Lancer `java -jar` sans chemin absolu
- Cela rend aussi plus facile le `docker exec` pour inspecter le conteneur :
    
``` bash
    `docker exec -it myapp ls   # déjà dans /app`
```
---
🔹 **Sans WORKDIR** : tu es dans `/` par défaut  
🔹 **Avec WORKDIR /app** : ton jar et fichiers liés sont centralisés et le conteneur est plus propre.

👉 **Docker crée automatiquement le répertoire spécifié dans `WORKDIR` s’il n’existe pas déjà.**
- Si tu fais plusieurs `WORKDIR` successifs, Docker crée toute l’arborescence manquante
🔹 Tu n’auras besoin de faire un `RUN mkdir /app` **que** si tu veux créer d’autres sous-dossiers spécifiques avec des droits particuliers avant le `WORKDIR`.

## 2️⃣  ENTRYPOINT - CMD
	 
Dans un Dockerfile Spring Boot, pour lancer l’application, la **bonne pratique** est généralement :

```dockerfile
ENTRYPOINT ["java", "-jar", "/app.jar"]
```
- **ENTRYPOINT** → Utilisé quand ton conteneur a **un but unique** (ici : exécuter ton appli Java).
    
- **CMD** → Fournit des **arguments par défaut** à `ENTRYPOINT` mais peut être facilement écrasé lors du `docker run`.
- `WORKDIR` définit le **répertoire de travail par défaut** dans le conteneur (équivalent à un `cd` permanent).
    
Exemple optimisé :
```dockerfile
FROM openjdk:8-jdk-alpine
WORKDIR /app
ENV URL_CUSTOMERS=http://localhost:8080/customers
VOLUME /tmp
COPY target/demo*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
CMD ["--spring.profiles.active=prod"]
EXPOSE 8080
```

✅ Avantages :
- Tu peux **changer le profil ou d’autres arguments** facilement :
```bash
docker run myapp --spring.profiles.active=dev
```
- Ton conteneur reste focalisé sur un seul process (`java -jar`).

---

  **Pourquoi définir un `VOLUME /tmp` ?**

Spring Boot (surtout avec **Tomcat embedded**) utilise souvent `/tmp` pour :
- Créer des fichiers temporaires
- Extraire certains fichiers de `.jar` au runtime (par ex. des fichiers JSP ou librairies natives)
    

En déclarant :
```dockerfile
VOLUME /tmp
```
- Tu crées un **volume Docker anonyme** → les fichiers temporaires ne polluent pas le système de fichiers du conteneur. 
- Facilite aussi l’écriture si l’image est en mode lecture seule.
- **Java n’en a pas toujours besoin**, mais c’est un vieux pattern recommandé par l’équipe Spring Initializr.
---

 🟢 **Bonnes pratiques Docker Spring Boot**

- Utiliser `ENTRYPOINT` + `CMD`
- Minimiser l’image (par ex. `adoptopenjdk:11-jre-hotspot` ou `eclipse-temurin`)
- Ajouter `VOLUME /tmp` (sauf si tu es sûr que ton app n’utilise pas `/tmp`)
- Éviter `ADD` → préférer `COPY`
- Exposer uniquement le port nécessaire (`EXPOSE 8080`)
