UPDATE CLIENTS SET nom=DEFAULT, adresse=NULL, ville='Nantes'
  WHERE numero=25;
SELECT * FROM CLIENTS WHERE numero=25;
go
UPDATE ARTICLES SET PRIXHT_ART=PRIXHT_ART*1.01
  WHERE PRIXHT_ART<20;
go
UPDATE STOCKS
  SET qte_stk=qte_stk-(SELECT SUM(QTE_CDE)
      FROM LIGNES_CDE
	  WHERE LIGNES_CDE.reference_art=STOCKS.reference_art)
  WHERE STOCKS.REFERENCE_ART='CLE25'
    AND STOCKS.DEPOT='P2';
