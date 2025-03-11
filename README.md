# Guide d'utilisation du conteneur Ansible

## 📌  Construction de l'image Docker
Après avoir créé le fichier `Dockerfile`, construisez l'image Docker avec la commande suivante :

```sh
docker build -t ansible-container .
```

---

## 🔹 Ou Chargement de l'image avec le tar          
Copiez `ansible-container.tar` sur l'autre machine et exécutez :
```sh
docker load -i ansible-container.tar
```

Vérifiez que l'image est bien chargée avec :
```sh
docker images
```



## 📌 2. Exécution du conteneur
Lancez le conteneur avec les options nécessaires :

```sh
docker run -ti --rm --privileged --network host \
  --user $(id -u):$(id -g) \
  -v /your_folder:/workspace \
  ansible-container
```

### 🔹 Explication des options :
- `--rm` : Supprime le conteneur après son arrêt.
- `--privileged` : Donne un accès complet aux ressources système.
- `--network host` : Permet au conteneur d'utiliser la carte réseau de l'hôte.
- `--user $(id -u):$(id -g)` : Assure que le conteneur fonctionne avec les mêmes permissions que l'utilisateur hôte.
- `-v /your_folder:/workspace` : Monte le dossier local `/your_folder` dans `/workspace` du conteneur.

---

## 📌 3. Test de connectivité avec Ansible
Une fois dans le conteneur, vous pouvez tester Ansible :

### 🔹 Test de connexion locale
```sh
ansible -i localhost, -m ping all --connection=local
```

### 🔹 Test de connexion avec un inventaire
Si vous avez un fichier `inventory`, utilisez :
```sh
ansible -i inventory all -m ping
```


