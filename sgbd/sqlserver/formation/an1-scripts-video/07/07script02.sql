
INSERT INTO CATALOGUES(numero,page)
  VALUES(1,'<page datecreation="19032012">
              <article>
                <reference>SONYMP3</reference>
                <designation>Lecteur MP3</designation>
                <prixttc>66.90</prixttc>
              </article>
              <article>
                <reference>LPYO</reference>
                <designation>Lecteur MP3, blanc</designation>
                <prixttc>45.50</prixttc>
              </article>
              <numero>1</numero>
            </page>');
GO
INSERT INTO CATALOGUES(numero,page)
  SELECT 2, informations
    FROM (SELECT *
          FROM OPENROWSET(BULK 'c:\test\formatxml.xml', SINGLE_BLOB) AS informations)
    AS fichierXML(informations);
