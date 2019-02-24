
CREATE TRIGGER update_commandes ON COMMANDES
AFTER UPDATE AS
IF UPDATE(etat_cde) BEGIN
	DECLARE @etat AS char(2)
	DECLARE @numero AS int
	DECLARE cUpdated CURSOR FOR
		SELECT numero_cde, etat_cde FROM inserted;
	OPEN cUpdated;
	FETCH cUpdated INTO @numero, @etat;
	WHILE (@@FETCH_STATUS=0) BEGIN
		IF (@etat='LI')
			INSERT INTO HISTO_FAC(numero_cde, date_fac)
				VALUES (@numero, GETDATE());
		FETCH cUpdated INTO @numero, @etat;
	END;
	CLOSE cUpdated;
	DEALLOCATE cUpdated;
END;
GO
CREATE TRIGGER ins_cde_date ON COMMANDES
AFTER INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE @numero AS int
	DECLARE cInserted CURSOR FOR
		SELECT numero_cde FROM inserted;
	OPEN cInserted;
	FETCH cInserted INTO @numero;
	WHILE (@@FETCH_STATUS=0) BEGIN
		UPDATE COMMANDES SET date_cde=GETDATE() WHERE numero_cde=@numero;
		FETCH cInserted INTO @numero;
	END;
	CLOSE cInserted;
	DEALLOCATE cInserted;
END;
GO
CREATE TRIGGER ins_cde_taux ON COMMANDES
AFTER INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE @numero_cde int
	DECLARE @numero_cli int
	DECLARE @nombre_commandes int
	DECLARE cInserted CURSOR FOR
		SELECT numero_cde,numero_cli FROM inserted;
	OPEN cInserted;
	FETCH cInserted INTO @numero_cde, @numero_cli;
	WHILE (@@FETCH_STATUS=0) BEGIN
		SELECT @nombre_commandes=COUNT(*)
			FROM COMMANDES
			WHERE numero_cli=@numero_cli;
		IF (@nombre_commandes>10 )
			UPDATE COMMANDES SET taux_remise=5 WHERE numero_cde=@numero_cde;
		FETCH cInserted INTO @numero_cde, @numero_cli;
	END;
	CLOSE cInserted;
	DEALLOCATE cInserted;
END;
GO
exec sp_helptrigger 'dbo.commandes'
GO
exec sp_settriggerorder 'ins_cde_taux', 'FIRST','INSERT'
exec sp_settriggerorder 'ins_cde_date','LAST','INSERT'
