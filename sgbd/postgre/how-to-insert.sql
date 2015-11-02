Liste contenus : 
"DAM00000748;DAM00000745"

Keywords :
"Mathematica;casemate"

Thematiques : 
"94002;94004"

Publics-cibles : 
"84051"

Reginos : 
"3002"

Delete
FROM estim_portail_servicedeporte sdep
where sdep.servicedeporteid < 80000

/* 
All.
*/
INSERT INTO estim_portail_servicedeporte (uuid_, servicedeporteid, createdby, createddate, modifiedby, modifieddate, deletedby, deleteddate, nature, titre, liste_contenus, mots_cles, thematiques, publics_cibles, regions, structures, hauteur, largeur, bg_color, region, type_doc, date_creation, niveau_scolaire, exploitation, support, types_d_evenement, categorie_d_evenement, datefinevenement, evenement_national, accessibilite, source, type_de_structure, duree, lieu, domaines_d_activite, domaines_d_expertise, forme_exposition, companyid, groupid)
VALUES ('3372c22e-bcbe-40ef-8bd7-e39931f18eb2', 60001, 10195, '2014-01-01 11:08:59.931', 10195, '2014-09-23 11:09:13.884', 0, NULL, 'widget', 'test-9', '', '', 'toto', '', '', '', 350, 300, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 10153, 83802);
INSERT INTO estim_portail_servicedeporte (uuid_, servicedeporteid, createdby, createddate, modifiedby, modifieddate, deletedby, deleteddate, nature, titre, liste_contenus, mots_cles, thematiques, publics_cibles, regions, structures, hauteur, largeur, bg_color, region, type_doc, date_creation, niveau_scolaire, exploitation, support, types_d_evenement, categorie_d_evenement, datefinevenement, evenement_national, accessibilite, source, type_de_structure, duree, lieu, domaines_d_activite, domaines_d_expertise, forme_exposition, companyid, groupid)
VALUES ('3372c22e-bcbe-40ef-8bd7-e39931f18eb2', 60003, 10195, '2014-01-01 11:08:59.931', 10195, '2014-09-23 11:09:13.884', 0, NULL, 'widget', 'test-9', '', '', '94002;94004', '94006;84057', '3002;3003', '18406;27602', 350, 300, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 10153, 83802);


/* 
Avec thematiques
*/
INSERT INTO estim_portail_servicedeporte (uuid_, servicedeporteid, createdby, createddate, modifiedby, modifieddate, deletedby, deleteddate, nature, titre, liste_contenus, mots_cles, thematiques, publics_cibles, regions, structures, hauteur, largeur, bg_color, region, type_doc, date_creation, niveau_scolaire, exploitation, support, types_d_evenement, categorie_d_evenement, datefinevenement, evenement_national, accessibilite, source, type_de_structure, duree, lieu, domaines_d_activite, domaines_d_expertise, forme_exposition, companyid, groupid)
VALUES ('3372c22e-bcbe-40ef-8bd7-e39931f18eb2', 60003, 10195, '2014-01-01 11:08:59.931', 10195, '2014-09-23 11:09:13.884', 0, NULL, 'widget', 'test-9', '', '', '94002;94004', '', '', '', 350, 300, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 10153, 83802);

/* 
Avec Liste de contenus du DAM 
*/
INSERT INTO estim_portail_servicedeporte (uuid_, servicedeporteid, createdby, createddate, modifiedby, modifieddate, deletedby, deleteddate, nature, titre, liste_contenus, mots_cles, thematiques, publics_cibles, regions, structures, hauteur, largeur, bg_color, region, type_doc, date_creation, niveau_scolaire, exploitation, support, types_d_evenement, categorie_d_evenement, datefinevenement, evenement_national, accessibilite, source, type_de_structure, duree, lieu, domaines_d_activite, domaines_d_expertise, forme_exposition, companyid, groupid)
VALUES ('18ce9ac5-bc8b-4b13-8f36-68a40bf22c66', 54501, 10195, '2014-04-02 10:21:05', 10195, '2014-04-02 10:38:56', 0, NULL, 'widget', 'carrousel des ressources', 'DAM00000005;DAM00000011', 'science', '94004', '84046', '', '', 350, 300, 'color-blue', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 10153, 83802);
