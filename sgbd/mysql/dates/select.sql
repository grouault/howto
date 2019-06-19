SELECT sum(nbJoursConsommees) 
FROM (
    select s.libelle, oi.code, nbHeures, case when nbHeures < 5 then (case when nbHeures = 0 then 0 else 0.5 end) else 1 end as nbJoursConsommees
    from SaisieTemps st
        inner join Sujet s on s.id = st.sujet_id
        inner join OrdreInterne oi on oi.id = s.ordreInterne_id    
    where 
        st.utilisateur_identifiant='grouault'
        and oi.code = 'OPTIPLAN'
        and st.jour between '2018-04-03' and '2018-04-04'
    -- group by s.libelle, oi.code	

) as test
