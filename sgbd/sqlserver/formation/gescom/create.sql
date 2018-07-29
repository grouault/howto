CREATE DATABASE GESCOM
ON PRIMARY(
	name=gescom_data,
	filename='C:\datas\sqlserver\gescom\gescom_data.mdf',
	size=6MB,
	maxsize=15MB,
	filegrowth=1MB)
LOG ON(
	name=gescom_log,
	filename='C:\datas\sqlserver\gescom\gescom_log.ldf',
	size=2MB,
	maxsize=2MB,
	filegrowth=0MB
)
COLLATE French_CI_AI;
