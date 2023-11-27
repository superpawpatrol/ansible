
# Pour chiffre le fichier vault
ansible-vault encrypt [nom du fichier]

# Pour exécuter le playbook et qu'il demande le mot de passe vault
ansible-playbook playbook.yml --ask-vault-pass

# Pour déchiffer le fichier vault en cas de modification
ansible-vault decrypt [nom du fichier]