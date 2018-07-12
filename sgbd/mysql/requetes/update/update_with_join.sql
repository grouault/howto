--
-- Deux requêtes de mise à jour qui font le meme travaille.
--

--
-- Suppression en créant une table temporaire.
-- Avec MySql, il est impossible de faire une modificaiton quand dans la sous-requêtre, la même table est référencé.
-- Il faut passer par une table temporaire créer par le Select id From ( ... )
--
update Budget 
    set temoinSuppression = true
where id in(
    select id 
    from (
        select b1.id as id
        from Budget b
            right outer join Budget b1 
            on b.departement_id = b1.departement_id
            and b.exercice_id = b1.exercice_id
            and b.sujet_id = b1.sujet_id
            and b.typeProjet_id = b1.typeProjet_id
            and b.domaineBudgetaire_id = b1.domaineBudgetaire_id
        where b.nbJours > 0 and b1.nbJours = 0
        and b.id > b1.id
    ) as tmp_to_delete
);

--
--  Suppression sans table temporaire
--  Mais avec une jointure
--
update Budget b2
    right outer join (
        select b1.id as id
        from Budget b
            right outer join Budget b1 
            on b.departement_id = b1.departement_id
            and b.exercice_id = b1.exercice_id
            and b.sujet_id = b1.sujet_id
            and b.typeProjet_id = b1.typeProjet_id
            and b.domaineBudgetaire_id = b1.domaineBudgetaire_id
        where b.nbJours > 0 and b1.nbJours = 0
        and b.id > b1.id
    ) as b3 on b3.id = b2.id
 set b2.temoinSuppression = true;
