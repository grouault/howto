$instance='ARAVIS\FORCLAZ'
$base='Gescom'
$repertoire='c:\MesScripts'
set-psdebug -strict #options de mises au point
[System.Reflection.Assembly]::LoadWithPartialName( "Microsoft.SqlServer.SMO" )
$s=new-object("Microsoft.SqlServer.Management.Smo.Server") $instance
# Afficher erreur si l'instance n'est pas accessible
if ($s.Version -eq $null){Throw "Impossible de trouver l'instance $instance"}
$bdd=$s.Databases[$base]
if ($bdd.name -ne $base) {Throw "Impossible de trouver la base $base dans $instance"};

$parametres=new-object("Microsoft.SqlServer.Management.Smo.ScriptingOptions")
$parametres.ExtendedProperties=$true
$parametres.DRIALL=$true
$parametres.Triggers=$true
$parametres.Indexes=$false
$parametres.ScriptBatchTerminator=$true
$parametres.IncludeHeaders=$true
$parametres.ToFileOnly=$true
$parametres.Filename= "$($repertoire)\Script_$($base).sql";

$transfert=new-object ("Microsoft.SqlServer.Management.Smo.Transfer") $bdd
$transfert.Options=$parametres
$transfert.ScriptTransfer();
