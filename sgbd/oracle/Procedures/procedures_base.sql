-- ===================== --
-- INTEGATION CERTIFICAT
-- =====================
set serveroutput on;
DECLARE

BEGIN
  DBMS_OUTPUT.ENABLE( 1000000 ) ;	
  INTEG_DECES_CERTIFICAT.traite_deces_certificat(sysdate);
  DBMS_OUTPUT.PUT_LINE('TEST OK');
END;

-- =========================
-- Call procedure in Package.
-- =========================
set serveroutput on;
DECLARE

BEGIN
  DBMS_OUTPUT.ENABLE( 1000000 ) ;	
  INTEG_DECES_CERTIFICAT.traiteDoublonsCertificat();
  DBMS_OUTPUT.PUT_LINE('TEST OK');
END;
