# Réaliser le déploiement de Ansible

## 1. Installation du master Ansible
CentOs Stream 9
<code>
dnf config-manager --set-enabled crb
dnf install epel-release epel-next-release
</code>

CentOS Stream 8
<code>
dnf config-manager --set-enabled powertools
dnf install epel-release epel-next-release
</code

To install the full ansible package run:
<code>sudo dnf install ansible</code>

To install the minimal ansible-core package run:
<code>sudo dnf install ansible-core</code>

Several Ansible collection are also available from the Fedora repositories as standalone packages that users can install alongside ansible-core. For example, to install the community.general collection run!
<code>sudo dnf install ansible-collection-community-general</code>

### Créer la clé ssh pour le user ansible
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub user@ip_add -p port

*** génération de la clé ssh ***
- name: Generate SSH key
  hosts: 127.0.0.1
  connection: local
  vars:
    ssh_key_filename: id_rsa_ansible
  tasks:
    - name generate SSH Key "{{ ssh_key_filename }}"
      openssh_keypair:
        #path: "~/.ssh/{{ ssh_key_filename }}"
        path: "/home/{{ ssh_key_filename }}"
        type: rsa
        size: 4096
        state: present
        force: no

## 2. Déployer 2 clients
## 3. Créer mon inventaire

Création de l'inventaire au format ini puis visualisation au format yml
<code>ansible-inventory --list -y</code>

Test de connexion
<code> ansible all -m ping</code>

## 4. Créer un user ansible ayant les droits sudo mais étant nologin

*** Vérifier la présence du groupe wheel ***
  - name: Make sure we have a 'wheel' group
    group:
      name: wheel
      state: present
*** Autoriser wheel dans sudoers sans password ***
  - name: Allow 'wheel' group ti have passwordless sudo
    lineinfile:
      dest: /etc/sudoers
      state: present
      regexp: '^%wheel'
      line: '%wheel ALL=(ALL) NOPASSWD: ALL'
      validate: visudo -cf %s
*** Ajout du user ansible ***
  - name: Add the user 'ansible', appending the group 'wheel'
    ansible.builtin.user:
      name: ansible
      comment: "Ansible nologin user"
      uid: 9000
      shell: /sbin/nologin
      groups: wheel
      append: yes
      state: present
*** Copie sur les clients de la clé ssh créé en amont ***
  - name: Set authorized key taken from file
    ansible.posix.authorized_key:
      user: ansible
      state: present
      #key: "{{ lookup('file', '/home/ansible/.ssh/id_rsa_ansible.pub') }}"
      key: "{{ lookup('file', '/home/id_rsa_ansible.pub') }}"


## 5. Créer un rôle requirements
<code>ansible-galaxy init requirements</code>

## 6.Créer un rôle Apache / Nginx
## 7.Créer un rôle Docker pour déployer des containeurs et charger une image wordpress
## 8.Créer un rôle pour déployer Node Exporter & Prometheus
## 9.Installer AWX
## 10.Lancer un playbook via AWX



