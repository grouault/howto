-- connexion

--
-- affiche les connexion par defaut
--
SELECT pid,
	usename AS username,
	datname AS database,
	client_addr AS client_address,
	client_port,
	application_name,
	state,
	backend_start,
	state_change
FROM pg_stat_activity
WHERE datname IS NOT NULL;