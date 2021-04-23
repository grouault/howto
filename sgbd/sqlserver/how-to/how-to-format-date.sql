-- convertir une date au format dd/mm/yyyy
CONVERT(char(10), co.date_cde, 103)  as date_cmd, 

-- convertir une date au format yyyy-MM-dd
SELECT CONVERT(NVARCHAR, GETDATE(), 23)

-- convertir une date au format dd/MM/yyyy
SELECT CONVERT(NVARCHAR, GETDATE(), 103)	