SELECT IP, NB_VOTES, TO_CHAR(PREMIER_VOTE_TS , 'DD/MM/YYYY HH:MI:SS')
FROM TRACK_SUSPECT 
WHERE IP='172.19.76.89' AND ID_CONTENU=123145641321;


# ORACLE
##
to_date('2010/10/15', 'yyyy/mm/dd')
to_date('2010/10/15', 'YYYY/MM/DD HH:MI:SS'')