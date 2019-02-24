
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
          </bibliotheque>';
select @doc
GO
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
          </bibliotheque>';
-----------> Requete 1
select @doc.query('bibliotheque/auteur');
-----------> Requete 2
select @doc.query('bibliotheque/auteur/*');
-----------> Requete 3
select @doc.query('bibliotheque/auteur/livre/*');
GO
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
          </bibliotheque>';
-----------> Requete 1
select @doc.query('bibliotheque/auteur[1]/*');
-----------> Requete 2
select @doc.query('bibliotheque/auteur[2]/*');
GO
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
          </bibliotheque>';
------------> Requete 1
select @doc.value('bibliotheque[1]/auteur[1]/@prenom','nvarchar(30)');
------------> Requete 2
select @doc.value('bibliotheque[1]/auteur[2]/@nom','nvarchar(30)');
GO
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
          </bibliotheque>';
------------> Requete 1
select @doc.query('bibliotheque/auteur[@prenom=''Jules'']/*');
GO
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
            <auteur nom="Renard" prenom="Jules">
              <livre classique="Oui">Poil de carotte</livre>
            </auteur>
          </bibliotheque>';

select @doc.query('
  for $element in /bibliotheque/auteur[@prenom=''Jules'']/*
    where $element/@classique="Oui"
    return <classique>{data($element)}</classique>');
GO
declare @doc xml;
set @doc='<bibliotheque>
            <auteur nom="Verne" prenom="Jules">
              <livre>Voyage au centre de la terre</livre>
              <livre>De la terre à la lune</livre>
            </auteur>
            <auteur nom="Hofstadter" prenom="Douglas">
              <livre>Gödel, Escher, Bach</livre>
            </auteur>
            <auteur nom="Renard" prenom="Jules">
              <livre classique="Oui">Poil de carotte</livre>
            </auteur>
          </bibliotheque>';
select @doc.query('
  <analyse>{
	for $element in /bibliotheque/auteur
		let $nombre:=count($element/livre)
		return
			<auteur>
				{$element/@nom}
				<nombreLivres>{$nombre}</nombreLivres>
			</auteur>
  }</analyse>');
