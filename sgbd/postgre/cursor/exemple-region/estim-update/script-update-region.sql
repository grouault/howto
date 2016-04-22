--
-- Script permettant :
--  - de désactiver les anciennes régions
--  - changer le nom des nouvelles régions
--
-- 
-- desactive les anciennes régions
-- 3008 : champagne ardennes ==> 3001
-- 3017 : Lorraine ==> 3001
-- 3016 : Limousin ==> 3002
-- 3023 : Poitou charente ==> 3002
-- 3026 : Rhône-Alpes ==> 3003
-- 3013 : Haute-Normandie ==> 3004
-- 3011 : Franche-comté ==> 3005
-- 3019 ! Midi-Pyrénées ==> 3015
UPDATE region 
	SET active_=false
	WHERE regionid IN (3008, 3017, 3016, 3023, 3026, 3013, 3011, 3019);
--
-- mise à jour des noms
UPDATE region SET name='Alsace-Champagne-Ardenne-Lorraine' WHERE regionid=3001;
UPDATE region SET name='Aquitaine Limousin Poitou-Charentes' WHERE regionid=3002;
UPDATE region SET name='Auvergne Rhône-Alpes' WHERE regionid=3003;
UPDATE region SET name='Normandie' WHERE regionid=3004;
UPDATE region SET name='Bourgogne Franche-Comté' WHERE regionid=3005;
UPDATE region SET name='Bretagne' WHERE regionid=3006;
UPDATE region SET name='Centre' WHERE regionid=3007;
UPDATE region SET name='Corse' WHERE regionid=3009;
UPDATE region SET name='Guyane' WHERE regionid=3010;
UPDATE region SET name='Guadeloupe' WHERE regionid=3012;
UPDATE region SET name='Île-de-France' WHERE regionid=3014;
UPDATE region SET name='Languedoc-Roussillon Midi-Pyrénées' WHERE regionid=3015;
UPDATE region SET name='Martinique' WHERE regionid=3018;
UPDATE region SET name='Nord Pas de Calais' WHERE regionid=3020;
UPDATE region SET name='Pays de la Loire' WHERE regionid=3021;
UPDATE region SET name='Picardie' WHERE regionid=3022;
UPDATE region SET name='Provence-Alpes-Côte-d''Azur' WHERE regionid=3024;
UPDATE region SET name='Réunion' WHERE regionid=3025;










