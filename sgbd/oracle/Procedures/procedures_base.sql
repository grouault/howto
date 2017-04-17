-- Call procedure in Package.
set serveroutput on;
DECLARE

BEGIN
  DBMS_OUTPUT.ENABLE( 1000000 ) ;	
  INTEG_DECES_CERTIFICAT.traiteDoublonsCertificat();
  DBMS_OUTPUT.PUT_LINE('TEST OK');
END;
