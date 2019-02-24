$instance='ARAVIS\FORCLAZ'
$base='Gescom'
$repertoire='c:\MesScripts'
$schema='dbo'
$listeDesTables='Clients;Articles'
set-psdebug -strict #options de mises au point
[System.Reflection.Assembly]::LoadWithPartialName( "Microsoft.SqlServer.SMO" )

$serveur=new-object("Microsoft.SqlServer.Management.Smo.Server") $instance
# Afficher erreur si l'instance n'est pas accessible
if ($serveur.Version -eq $null){Throw "Impossible de trouver l'instance $instance"}
$bdd=$serveur.Databases[$base]
if ($bdd.name -ne $base) {Throw "Impossible de trouver la base $base dans $instance"};

$scripter=new-object("Microsoft.SqlServer.Management.Smo.Scripter") $serveur
$scripter.Options.ScriptSchema=$true;
$scripter.Options.ScriptData=$true;
$scripter.Options.NoCommandTerminator=$false;
$scripter.Options.FileName="$($repertoire)\Donnees_$($base).sql"
$scripter.Options.ToFileOnly=$true;
$scriptUrn=new-object ("Microsoft.SqlServer.Management.Smo.UrnCollection");
$serveurUrn=$serveur.Urn;
foreach($uneTable in $listeDesTables -split ';'){
	$urn="$serveurUrn/Database[@Name='$base']/Table[@Name='$uneTable' and @Schema='$schema']"
	$urn;
	$scriptUrn.add($urn)
}
$scripter.EnumScript($scriptUrn);
