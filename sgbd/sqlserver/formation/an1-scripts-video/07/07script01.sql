CREATE TABLE CATALOGUES(
  numero int CONSTRAINT pk_catalogues PRIMARY KEY,
  page xml);
GO
CREATE XML SCHEMA COLLECTION schemaClient AS
N'<?xml version="1.0" encoding="UTF-16"?>'+
'<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">'+
'<xs:complexType name="Client">'+
'<xs:sequence>'+
'<xs:element name="Nom"/>'+
'<xs:element name="Prenom"/>'+
'<xs:element name="Adresse"/>'+
'<xs:element name="CodePostal"/>'+
'<xs:element name="Ville"/>'+
'</xs:sequence>'+
'</xs:complexType>'+
'</xs:schema>';
GO
CREATE TABLE VENDEURS(
  id int constraint pk_vendeurs primary key,
  nom nvarchar(50),
  prenom nvarchar(50),
  telephone nvarchar(14),
  email nvarchar(80),
  prospect xml (schemaClient)
);
GO
CREATE XML SCHEMA COLLECTION schemaClientEtendu AS
N'<?xml version="1.0" encoding="UTF-16"?>'+
'<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">'+
'<xs:complexType name="Client">'+
'<xs:sequence>'+
'<xs:element name="Nom"/>'+
'<xs:element name="Prenom"/>'+
'<xs:element name="Adresse"/>'+
'<xs:element name="CodePostal"/>'+
'<xs:element name="Ville"/>'+
'<xs:any namespace="##other" processContents="skip" minOccurs="0" maxOccurs="unbounded"/>'+
'</xs:sequence>'+
'</xs:complexType>'+
'</xs:schema>';
GO
CREATE XML SCHEMA COLLECTION schemaDistance AS
N'<?xml version="1.0" encoding="UTF-16"?>'+
'<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">'+
'<xs:simpleType name="Unite">'+
'	<xs:union>'+
'		<xs:simpleType>'+
'			<xs:list>'+
'				<xs:simpleType>'+
'					<xs:restriction base="xs:string">'+
'						<xs:enumeration value="cm"/>'+
'						<xs:enumeration value="m"/>'+
'						<xs:enumeration value="km"/>'+
'					</xs:restriction>'+
'				</xs:simpleType>'+
'			</xs:list>'+
'		</xs:simpleType>'+
'		<xs:simpleType>'+
'			<xs:list>'+
'				<xs:simpleType>'+
'					<xs:restriction base="xs:string">'+
'						<xs:enumeration value="inch"/>'+
'						<xs:enumeration value="foot"/>'+
'						<xs:enumeration value="yard"/>'+
'					</xs:restriction>'+
'				</xs:simpleType>'+
'			</xs:list>'+
'		</xs:simpleType>'+
'	</xs:union>'+
'</xs:simpleType>'+
'</xs:schema>';