## Appel d'url en CURL

### Exemple
```
curl --trace-ascii - --location --request POST 'http://localhost:8080/swet/opc/batch/launch' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'login=opcon' \
--data-urlencode 'password=672795a51017863978e1a189ef0c492ca76347e349acbe403f919e27df958bdfa96acbf7dbb43496dca514c2827591c9' \
--data-urlencode 'code=cache-maintenance'
```

### En HTTPS

#### Processus de mise place du certificat

* récupérer le certificat sur le browser par exemple dans le format : DER encoded binary x.509
* convertir le format .cer en .pem avec la commande suivante

```
	* $ openssl x509 -inform DES -in swet-tuf.cer -out swet-tuf.pem -text
````

#### Lancer la commande en intégran le certificat

```
curl --location --request POST 'https://swet-tuf.pomona-fr.grp/swet-tuf/opc/batch/launch' \
--cacert pomona-fr-subca.pem \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'login=opcon' \
--data-urlencode 'password=672795a51017863978e1a189ef0c492ca76347e349acbe403f919e27df958bdfa96acbf7dbb43496dca514c2827591c9' \
--data-urlencode 'code=cache-maintenance'
````

* Avec commentaires
```
curl --trace-ascii - --location --request POST 'https://swet-tuf.pomona-fr.grp/swet-tuf/opc/batch/launch' \
--cacert file1.pem \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'login=opcon' \
--data-urlencode 'password=672795a51017863978e1a189ef0c492ca76347e349acbe403f919e27df958bdfa96acbf7dbb43496dca514c2827591c9' \
--data-urlencode 'code=cache-maintenance'
```


* Lien util

https://stackoverflow.com/questions/10079707/https-connection-using-curl-from-command-line
