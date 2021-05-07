# Dates

## UTC
```
L'UTC est la r�f�rence par rapport on calcule la bonne date en fonction de la TimeZone.
L'UTC est par d�faut align� sur le m�ridient GreenWich.
```

### parser une date � l'UTC

#### Pr�alable
```
* Par d�faut, quand on parse une date en Java, le parsing se fait avec la Timezone System.
* Quand on cr�e une date, la cr�ation se fait avec la Timezone System.
```

#### Probl�matique
```
* Les donn�es d'un serveur distant sont envoy�es � l'UTC et sur le syst�me h�te on est en TimeZone(Europe/Paris)
	* La donn�es peut-�tre transmise � l'UTC
	* il faut alors la parser � l'UTC, pour que java nous donne la bonne heure pour la TimeZone system.
	* sinon elle sera pars�e avec la TimeZone System et il y aura un d�calage au niveau de l'heure surtout.
```

#### Explication
```	
* Exemple
	* distant renvoie l'heure et date : 17/04/2013 03/33/33
	* si on parse dans la time zone syst�me (Europe/Paris), la date sera 17/04/2013 03/33/33 dans cette timezone
	* si on parse dans la time zone syst�me (UTC) :
		* la date sera 17/04/2013 03/33/33 dans cette timezone
		* la date sera donc 17/04/2013 05/33/33 dans la time zone Europe/Paris.
```

#### Code
```

String strDateInit = "20130417033333";

SimpleDateFormat dateFormatParis = new SimpleDateFormat("yyyyMMddHHmmss");
SimpleDateFormat dateFormatUTC = new SimpleDateFormat("yyyyMMddHHmmss");

TimeZone timeZoneParis = TimeZone.getTimeZone("Europe/Paris");
TimeZone timeZoneUTC = TimeZone.getTimeZone("UTC"); // UTC

dateFormatParis.setTimeZone(timeZoneParis);
dateFormatUTC.setTimeZone(timeZoneUTC);

try {

	Date modificationTimeUTC = dateFormatUTC.parse(strDateInit);
	System.out.println("File modification time UTC: " + modificationTimeUTC);
	
	Date modificationTime = dateFormatParis.parse(strDateInit);
	System.out.println("File modification time PARIS: " + modificationTime);	
	
} catch (ParseException ex) {
	ex.printStackTrace();
}

```

## Urls
```
// 
// urls
//
// Local Date Time
// https://stackoverflow.com/questions/34626382/convert-localdatetime-to-localdatetime-in-utc
// https://stackoverflow.com/questions/56361337/localdatetime-to-specific-timezone
// https://www.codebyamir.com/blog/add-a-timezone-to-localdatetime-with-zoneddatetime-in-java-8
// https://www.baeldung.com/java-zoneddatetime-offsetdatetime
// https://www.baeldung.com/java-zone-offset
//

// Date
// https://stackoverflow.com/questions/6543174/how-can-i-parse-utc-date-time-string-into-something-more-readable
// https://stackoverflow.com/questions/36915822/how-to-get-time-zone-from-date#:~:text=A%20java.,a%20pure%20time%20in%20UTC.
```