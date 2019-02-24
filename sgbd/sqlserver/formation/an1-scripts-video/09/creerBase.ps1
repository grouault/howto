$instance='ARAVIS\FORCLAZ';
$base='GescomSMO';

set-psdebug -strict ;
[System.Reflection.Assembly]::LoadWithPartialName( "Microsoft.SqlServer.SMO" );
$serveur=new-object("Microsoft.SqlServer.Management.Smo.Server") $instance;
# Afficher erreur si l'instance n'est pas accessible
if ($serveur.Version -eq $null){Throw "Impossible de trouver l'instance $instance";}
$bdd=new-object("Microsoft.SqlServer.Management.Smo.Database");
$bdd.Parent=$serveur;
$bdd.Name=$base;
$bdd.Create();
