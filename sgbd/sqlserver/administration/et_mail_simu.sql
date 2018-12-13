select * from [msdb].[dbo].[sysmail_account];
SELECT * FROM [msdb].[dbo].[sysmail_profile];
select * from [msdb].[dbo].[sysmail_profileaccount];

-- creation compte-- Create a Database Mail account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'ET_SIMU',
    @email_address = 'sql-et-simu@groupe-pomona.fr',
    @replyto_address = 'no_reply@groupe-pomona.fr',
    @display_name = 'Mail_automatique',
    @mailserver_name = 'relaissmtp';

-- création profil
EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'ET_SIMU',
	@description = 'ET_SIMU';

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'ET_SIMU',
    @account_name = 'ET_SIMU',
    @sequence_number = 2;
