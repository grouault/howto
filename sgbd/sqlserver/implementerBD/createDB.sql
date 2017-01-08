CREATE DATABASE GESCOM_DEMO
ON PRIMARY(
  name=gescom_data,
  filename='D:\datas\sqlserver\gescom_demo\gescom_data.mdf',
  size= 6MB,
  maxsize= 15MB,
  filegrowth= 1MB)
LOG ON(
  name=gescom_log,
  filename='D:\datas\sqlserver\gescom_demo\gescom_log.ldf',
  size= 2MB,
  maxsize= 2Mb,
  filegrowth= 0MB
)
COLLATE French_CI_AI;
