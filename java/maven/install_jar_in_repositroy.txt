mvn -X install:install-file -Dfile=path/to/mly/jar -DgroupId=j<groupname> -DartifactId=<artifactname> -Dversion=<version> -Dpackaging=jar -DgeneratePom=true

mvn -X install:install-file -Dfile=astre-client-0.1 -DgroupId=fr.inria -DartifactId=astre-client -Dversion=0.1 -Dpackaging=jar -DgeneratePom=true
mvn install:install-file -Dfile=astre-client-0.1.jar -DgroupId=fr.inria -DartifactId=astre-client -Dversion=0.1 -Dpackaging=jar
mvn install:install-file -Dfile=D:\services\INRIA\GEF\lib\astre-client-0.1.jar -DgroupId=fr.inria -DartifactId=astre-client -Dversion=0.1 -Dpackaging=jar

Install des jars INRIA:
-----------------------
mvn install:install-file -Dfile=astre-client-0.1.jar -DartifactId=astre-client -DgroupId=fr.inria -Dversion=0.1 -Dpackaging=jar
mvn install:install-file -Dfile=opsfClient-1.1.0.jar -DartifactId=opsfClient -DgroupId=fr.inria -Dversion=1.1.0 -Dpackaging=jar
mvn install:install-file -Dfile=inria-util-1.0.0.jar -DartifactId=inria-util -DgroupId=fr.inria -Dversion=1.0.0 -Dpackaging=jar
mvn install:install-file -Dfile=gef-api-2.5.7.jar -DartifactId=gef-api -DgroupId=fr.inria -Dversion=2.5.7 -Dpackaging=jar

#
##
javax.servlet / servlet-api

# ojdbc.jar
mvn install:install-file -Dfile=ojdbc14-10.2.jar -DartifactId=ojdbc14 -DgroupId=com.oracle -Dversion=10.2 -Dpackaging=jar

## azure
mvn install:install-file -Dfile=azure-storage-8.4.0.jar -DartifactId=azure-storage -DgroupId=com.microsoft.azure -Dversion=8.4.0 -Dpackaging=jar
mvn install:install-file -Dfile=azure-keyvault-core-1.0.0.jar -DartifactId=azure-keyvault-core -DgroupId=com.microsoft.azure -Dversion=1.0.0 -Dpackaging=jar
mvn install:install-file -Dfile=im4java-1.4.0.jar -DartifactId=im4java -DgroupId=org.im4java -Dversion=1.4.0 -Dpackaging=jar
mvn install:install-file -Dfile=tika-core-1.22.jar -DartifactId=tika-core -DgroupId=org.apache.tika -Dversion=1.22 -Dpackaging=jar
mvn install:install-file -Dfile=jackson-datatype-jsr310-2.8.11.jar -DartifactId=jackson-datatype-jsr310 -DgroupId=com.fasterxml.jackson.datatype -Dversion=2.8.11 -Dpackaging=jar
mvn install:install-file -Dfile=olap4j-0.9.7.309-JS-3.jar -DartifactId=olap4j-0.9.7.309-JS-3 -DgroupId=org.olap4j.olap4j -Dversion=0.9.7.309-JS-3 -Dpackaging=jar


C:\Users\grouault\.m2\repository\org\olap4j\olap4j\0.9.7.309-JS-3





im4java-1.4.0.jar


C:\Users\grouault\.m2\repository\org\im4java\im4java\1.4.0\im4java-1.4.0.jar

Description	Resource	Path	Location	Type
Archive for required library: 'C:/Users/grouault/.m2/repository/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.8.11/jackson-datatype-jsr310-2.8.11.jar' in project 'grape-core' cannot be read or is not a valid ZIP file	grape-core		Build path	Build Path Problem


