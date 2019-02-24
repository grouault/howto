SELECT reference_art, depot, qte_stk
  FROM stocks;
GO
SELECT reference_art, [N] as "dépot1", [P1] as "dépot2", [P2] as "dépot3"
  FROM STOCKS
  PIVOT (sum(qte_stk) FOR depot in ([N],[P1],[P2])) as p;
GO
SELECT p.reference_art, 
	   [N] as "dépot1", [P1] as "dépot2", [P2] as "dépot3",
	   designation_art
  FROM STOCKS
  PIVOT (sum(qte_stk) FOR depot in ([N],[P1],[P2])) as p
  INNER JOIN ARTICLES 
  ON ARTICLES.reference_art=p.reference_art;