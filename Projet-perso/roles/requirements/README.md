# Rôle pour mise en place des prérequis ansible

### Création d'un rôle à partir de ansible-galaxy
<code>ansible-galaxy init [nom_du_role]

Note pour moi:
Nous supprimons ensuite le dossier tests, defaults, vars et handlers qui ne nous serviront à rien pour le moment.
rm -rf roles/web/{tests,defaults,handlers,vars}

<p>Ce rôle sera joué avec le user root. Nous allons donc chiffrer le fichier de vars pour évité de montrer en claire le mdp root de nos serveurs</p>
<code>ansible-vault encrypt mon-fichier-non-chiffre.yml</code>

### Caractéristiques de l'arborescence d'un rôle

* tasks: contient la liste principale des tâches à exécuter par le rôle.
* handlers: contient les handlers, qui peuvent être utilisés par ce rôle ou même en dehors de ce rôle.
* defaults: variables par défaut pour le rôle.
* vars: d'autres variables pour le rôle.
* files: contient des fichiers qui peuvent être déployés via ce rôle.
* templates: contient des modèles (jinja2) qui peuvent être déployés via ce rôle.
* meta: définit certaines métadonnées pour ce rôle.
* README.md: inclut une description générale du fonctionnement de votre rôle.
* test: contient notre playbook (on peut cependant déposer notre playbook à la racine du projet ou dans un dossier sous un nom différent).