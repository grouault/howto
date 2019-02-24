
RAISERROR ('! Le stock est négatif !',12,12);
GO
DECLARE @numero int;
SELECT @numero=1;
RAISERROR ('Erreur Grave sur le client %d!!',21,1,@numero)
	WITH LOG;
GO

EXEC sp_addmessage @msgnum=50006, @severity=12,
				   @msgtext='Minimun stock is over maximum stock',
				   @lang='us_english',
				   @replace='replace';
go
EXEC sp_addmessage @msgnum=50006, @severity=12,
				   @msgtext='Stock minimun supérieur au stock maximum',
				   @lang='french',
				   @replace='replace';
go
RAISERROR(50006,12,1);
GO
exec sp_helplanguage
GO

exec sp_addmessage @msgnum=50007, @severity=12,
				   @msgtext='Error for customer: %s on invoice: %d',
				   @lang='us_english',
				   @replace='replace';
go
exec sp_addmessage @msgnum=50007, @severity=12,
				   @msgtext='Erreur sur la commande %2! du client %1!',
				   @lang='french',
				   @replace='replace';
go
RAISERROR(50007,12,1,'Dupond',153);
GO