
# En mode brouillon 

# Déployer wordpress sous forme de conteneur docker

=> Prérequis: 
- Installer docker

Installation à partir des repo Docker :

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

Install Docker Engine
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

If prompted to accept the GPG key, verify that the fingerprint matches 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35, and if so, accept it.
This command installs Docker, but it doesn't start Docker. It also creates a docker group, however, it doesn't add any users to the group by default.

Start Docker
sudo systemctl start docker

Vérifier que tout est ok
sudo docker run hello-world