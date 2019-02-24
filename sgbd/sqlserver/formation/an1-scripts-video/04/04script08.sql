SELECT Client=cli.numero, nom, cde.numero_cde
  FROM CLIENTS cli LEFT OUTER JOIN COMMANDES cde
  ON cli.numero=cde.numero_cli;
  GO
SELECT Client=cli.numero, nom, cde.numero_cde
  FROM CLIENTS cli ,COMMANDES cde
  WHERE cli.numero *= cde.numero_cli;