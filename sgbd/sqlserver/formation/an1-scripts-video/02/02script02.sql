ALTER DATABASE GESCOM
MODIFY FILE (
  name=gescom_data,
  size= 20MB);

ALTER DATABASE GESCOM
ADD FILE (
  name=gescom_data2,
  filename='C:\donnees\gescom_data2.ndf',
  size=20MB);