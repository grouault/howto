##########
## FEDORA
##########
# lancé le service ssh
systemctl start sshd
# verifier le status
systemctl status sshd

# machine distante
ssh user@nom-machine
ssh user@ip ==> ssh root@192.168.0.1

# url
http://doc.fedora-fr.org/wiki/SSH_:_Authentification_par_cl%C3%A9#Pr.C3.A9sentation
http://forum.ubuntu-fr.org/viewtopic.php?id=241905
http://www.cyberciti.biz/faq/howto-restart-ssh/

# installer le serveur ssh
yum install openssh-server
/etc/init.d/sshd restart
/sbin/service sshd start
/sbin/service sshd status

# configurer ssh
aller dans le folder ssh.config
/etc/ssh/sshd_config
==> autorisé le root et le port 22

# ouvrir le port 22
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
service iptables status
service iptables save

# ssh-principe
Clé publique / clé privée.
1- Générée à partir du client
2- clé publique diffusée au serveur
3- client chiffre avec clé privée / déchiffré avec clé publique donnée au serveur.


