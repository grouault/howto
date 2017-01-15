-- =========================================
-- Tableau des produits commandés par client
-- =========================================
select co.numero_cde as 'Numéro cde', CONVERT(char(10), co.date_cde, 103) as 'Date cde', cli.nom as 'Nom Client',
	lco.reference_art as 'Réf. article', a.prixht as 'Prix HT', lco.qte_cde as 'Qtté commandée'
	from CLIENTS cli 
		join COMMANDES co on co.numero_cli=cli.numero
		join LIGNES_CDE lco on lco.numero_cde=co.numero_cde
		join ARTICLES a on a.reference = lco.reference_art; 
