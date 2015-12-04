-- ============================================================
--   Nom de la base   :  Sequence
--   Nom de SGBD      :  ORACLE 
--   Date de cr�ation :  10/09/2009  09:00 
--   Author           :  Gildas ROUAULT
-- ============================================================

-- ============================================================
--  Une sequence est une table permettant d'incr�menter un 
--  num�ro.
--  Une sequence est souvent associ� � une cl� primaire
-- ============================================================

-- ============================================================
--   Cr�ation d'une s�quence 
-- ============================================================
CREATE SEQUENCE FICHEEXP.TEST_TMA_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCACHE 
NOCYCLE 
NOORDER 

-- ============================================================
--   Incr�menter la s�quence
-- ============================================================
SELECT TEST_TMA_SEQ.nextval from dual;

-- ============================================================
--   R�cup�rer la valeur de la s�quence
-- ===========================================================
SELECT TEST_TMA_SEQ.currval from dual;

-- ============================================================
--   Changer la valeur courante d'une s�quence.
--   Changer le pas vers la prochaine valeur de la sequence.
-- ============================================================
ALTER SEQUENCE FICHEEXP.LIEUX_SEQ INCREMENT BY 205;
SELECT FICHEEXP.LIEUX_SEQ.NEXTVAL
FROM dual;
-- Modification de la sequence au pas + 1:
ALTER SEQUENCE FICHEEXP.LIEUX_SEQ INCREMENT BY 1;
SELECT FICHEEXP.LIEUX_SEQ.NEXTVAL
FROM dual;