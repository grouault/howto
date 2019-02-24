
CREATE TABLE HISTO_FAC(
  numero_fac int identity(1000,1) not null,
  date_fac datetime,
  numero_cde int,
  montantht smallmoney,
  etat_fac char(2),
  constraint pk_histo_fac primary key(numero_fac)
);

GO
CREATE TABLE LIGNES_CDE(
  numero_cde int not null,
  numero_lig int not null,
  reference_art nvarchar(16) not null,
  qte_cde int default 1
);
GO

ALTER TABLE LIGNES_CDE
  ADD CONSTRAINT pk_lignes
  PRIMARY KEY NONCLUSTERED (numero_cde, numero_lig);