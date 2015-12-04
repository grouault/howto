-- ============================================================
--   Nom de la base   :  Sequence
--   Nom de SGBD      :  ORACLE 
--   Date de création :  10/09/2009  09:00 
--   Author           :  Gildas ROUAULT
-- ============================================================

-- ============================================================
--  Une sequence est une table permettant d'incrémenter un 
--  numéro.
--  Une sequence est souvent associé à une clé primaire
-- ============================================================

-- ============================================================
--   Création d'une séquence 
-- ============================================================
CREATE SEQUENCE FICHEEXP.TEST_TMA_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCACHE 
NOCYCLE 
NOORDER 

-- ============================================================
--   Incrémenter la séquence
-- ============================================================
SELECT TEST_TMA_SEQ.nextval from dual;

-- ============================================================
--   Récupérer la valeur de la séquence
-- ===========================================================
SELECT TEST_TMA_SEQ.currval from dual;

-- ============================================================
--   Changer la valeur courante d'une séquence.
--   Changer le pas vers la prochaine valeur de la sequence.
-- ============================================================
ALTER SEQUENCE FICHEEXP.LIEUX_SEQ INCREMENT BY 205;
SELECT FICHEEXP.LIEUX_SEQ.NEXTVAL
FROM dual;
-- Modification de la sequence au pas + 1:
ALTER SEQUENCE FICHEEXP.LIEUX_SEQ INCREMENT BY 1;
SELECT FICHEEXP.LIEUX_SEQ.NEXTVAL
FROM dual;