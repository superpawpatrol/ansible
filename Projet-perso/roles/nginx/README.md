# Rôle d'installation Apache

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