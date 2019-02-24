
SELECT numero, page.query ('page/article/reference')
  FROM CATALOGUES;
GO
SELECT numero, 
	page.value('(page/article/reference)[1]','nvarchar(20)'),
	page.value('(page/article/prixttc)[1]','smallmoney')
  FROM CATALOGUES; 
GO
SELECT numero, 
	page.value('(page/article/reference)[1]','nvarchar(20)'),
	page.value('(page/article/prixttc)[1]','smallmoney')
  FROM CATALOGUES
 WHERE page.exist('(page/article/reference)[1]')=1;
GO
declare @test xml;
set @test='<page datecreation="26062014">
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
            </page>';

select resultats.x.query('.') from @test.nodes('/page/article') as resultats(x);
GO
declare @liste xml;
set @liste='<page><article>Aquabeat 2</article><article>YP-F3QB</article></page>';
declare @nouvelArticle xml;
set @nouvelArticle='<article>i10</article>'
set @liste.modify('insert sql:variable("@nouvelArticle") as last into (/page)[1]');
select @liste;