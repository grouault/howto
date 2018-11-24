--
-- Pour pouvoir envoyer des mail, on doit:
-- 1- creer un compte d'envoi de mail
-- 2- creer un profil
-- 3- associer le profil au compte

-- Drop a Database Mail account
EXECUTE msdb.dbo.sysmail_delete_account_sp  
    @account_name = 'AdminMail' ;  


EXECUTE msdb.dbo.sysmail_add_profile_sp @profile_name = 'ET_DEV' ;

SELECT * FROM [msdb].[dbo].[sysmail_profile] 
--delete from [msdb].[dbo].[sysmail_profile] where [profile_id]=2 and [name]='ET_DEV2PES'

select * from [msdb].[dbo].[sysmail_account]
--delete from [msdb].[dbo].[sysmail_account] where account_id=3 and name='ET_DEV2PES'

select * from [msdb].[dbo].[sysmail_profileaccount]
--delete from [msdb].[dbo].[sysmail_profileaccount] where [profile_id]=2   and [account_id]=3

--
-- Creer le compte mail et le profil
--
-- Create a Database Mail account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'ET_INT',
    @email_address = 'sql-et-int@groupe-pomona.fr',
    @replyto_address = 'no_reply@groupe-pomona.fr',
    @display_name = 'Mail_automatique',
    @mailserver_name = 'relaissmtp';

EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'ET_INT',
	@description = 'ET_INT';

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'ET_INT',
    @account_name = 'ET_INT',
    @sequence_number =1;
	
		
'==> ???
'	
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = 'ET_INT',
    @principal_name = 'testMail',
    @is_default = 1 ;

--
-- envoyer le mail
--
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'ET_DEV',
    @recipients = 'a.bouaraba@groupe-pomona.fr', 
    @subject='V000118\ET-DEV-2PES - ECHEC EXECUTION PACKAGE SSIS',
    @body = 'test ET';

