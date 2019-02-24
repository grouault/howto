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
$transfert=new-object ("Microsoft.SqlServer.Management.Smo.Transfer") $bdd
$transfert.Options.ScriptBatchTerminator=$true
$transfert.Options.TofileOnly=$true	#redirection unique vers un fichier
$transfert.Options.Filename= "$($repertoire)\Script_$($base).sql";
$transfert.ScriptTransfer();
