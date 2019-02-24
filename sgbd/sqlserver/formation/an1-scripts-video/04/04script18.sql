
CREATE SEQUENCE seq_clients
  AS int
  START WITH 100
  INCREMENT BY 1;
GO
INSERT INTO CLIENTS(numero, nom, prenom, telephone, coderep)
SELECT next value FOR seq_clients,'SANGE','Isidore','0100100100','AB';