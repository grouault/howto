$instance='ARAVIS\FORCLAZ';
$base='GescomSMO';

set-psdebug -strict ;
[System.Reflection.Assembly]::LoadWithPartialName( "Microsoft.SqlServer.SMO" );
$serveur=new-object("Microsoft.SqlServer.Management.Smo.Server") $instance;
if ($serveur.Version -eq $null){Throw "Impossible de trouver l'instance $instance";}
$bdd=$serveur.Databases[$base];
$table=new-object("Microsoft.SqlServer.Management.Smo.Table");
$table.Parent=$bdd;
$table.Schema='dbo';
$table.Name='Personnes';

$colonne1=new-object("Microsoft.SqlServer.Management.Smo.Column");
$colonne1.Parent=$table
$colonne1.Name='id'
$colonne1.DataType = new-object Microsoft.SqlServer.Management.Smo.DataType([Microsoft.SqlServer.Management.Smo.SqlDataType]::Int);

$colonne2=new-object Microsoft.SqlServer.Management.Smo.Column(
	$table, 
	"Nom", 
	[Microsoft.SqlServer.Management.Smo.DataType]::NVarChar(80));

$table.Columns.Add($colonne1);
$table.Columns.Add($colonne2);

$table.Create();