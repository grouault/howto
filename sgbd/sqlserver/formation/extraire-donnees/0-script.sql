-- ================= --
-- == SELECTION   == --
-- ================= --
SELECT * FROM ARTICLES;
GO
SELECT CODE_CAT, REFERENCE_ART FROM ARTICLES;
GO
SELECT Catégorie=CODE_CAT, 
       'Désignation de l''article'=DESIGNATION_ART 
       FROM ARTICLES;
