mysql -u manageo_user -p manageo_pwd -h fipuser -P 3306

00:06:19 Dumping Manageo (all tables)
Running: mysqldump.exe --defaults-file="c:\users\grouault\appdata\local\temp\tmplba04g.cnf"  --user=fipuser --host=devfip --protocol=tcp --port=3306 --default-character-set=utf8 --single-transaction=TRUE --skip-triggers "Manageo"
00:07:08 Export of C:\Users\grouault\Documents\dumps\Dump20171024.sql has finished

00:13:37 Dumping Manageo (all tables)
Running: mysqldump.exe --defaults-file="c:\users\grouault\appdata\local\temp\tmpegj8mz.cnf"  --user=fipuser --host=devfip --protocol=tcp --port=3306 --default-character-set=utf8 --routines --events "Manageo"
00:14:35 Export of C:\Services\projects\bsm\databases\dumps\devs\from-workbench\Dump20171024-1.sql has finished

00:21:55 Restoring C:\Services\projects\bsm\databases\dumps\devs\from-workbench\Dump20171024-1.sql
Running: mysql.exe --defaults-file="c:\users\grouault\appdata\local\temp\tmpsrluby.cnf"  --protocol=tcp --host=127.0.0.1 --user=root --port=3306 --default-character-set=utf8 --comments  < "C:\\Services\\projects\\bsm\\databases\\dumps\\devs\\from-workbench\\Dump20171024-1.sql"
00:21:59 Import of C:\Services\projects\bsm\databases\dumps\devs\from-workbench\Dump20171024-1.sql has finished
