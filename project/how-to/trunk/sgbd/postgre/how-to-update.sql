--
-- PostGre :
-- http://www.postgresql.org/docs/8.1/static/ddl-alter.html
--

--
-- How to update
--
ALTER TABLE estim_Evenement ADD COLUMN afficheid bigint;
ALTER TABLE estim_Evenement ADD COLUMN vignetteid bigint;

--
-- Creation des sequences.
--
create sequence estim_alerte_seq START 5000;
create sequence estim_demandecreatstruct_seq START 5000;
create sequence estim_demanderattachement_seq START 5000;
create sequence estim_evenement_seq START 5000;
create sequence estim_servicedeporte_seq START 5000;

--
-- Questionner la sequence
-- http://www.postgresql.org/docs/8.1/static/sql-createsequence.html
--
SELECT nextval('estim_alerte_seq');