
SELECT DISTINCT ville FROM CLIENTS;
-- OU
SELECT ville FROM CLIENTS GROUP BY ville;
GO
SELECT ville, codepostal 
	FROM CLIENTS
	GROUP BY ville, codepostal;