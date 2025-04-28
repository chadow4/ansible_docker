# 🚀 Guide d'utilisation du conteneur **Ansible**

## 📌 1. Construction de l'image Docker

Le fichier `Dockerfile` utilisé pour construire l'image installe :
- **Python 3.11** (via `python:3.11-slim` comme base légère)
- **Ansible** : outil principal pour l'automatisation.
- **sshpass** : pour la connexion SSH automatisée 
- **bash**, **coreutils** : pour les opérations système courantes.
- **iputils-ping**, **net-tools** : pour les outils réseau de diagnostic.
- **Modules Python supplémentaires** :
  - `PyYAML` : manipulation de fichiers YAML.
  - `requests` : requêtes HTTP.
  - `pyvmomi`, `pyvim` : interaction avec VMware vSphere.
  - `jmespath` : manipulation de JSON.
  - `paramiko` : connexion SSH Python.
- **Collection Ansible `community.vmware`** : pour gérer VMware vSphere/ESXi via Ansible.

👉 Après l'installation, le système est nettoyé (`apt clean` et suppression de caches) pour garder l'image **aussi légère que possible**.

👉 Le dossier de travail par défaut est `/workspace` (où ton contenu sera monté).

👉 Le conteneur démarre directement dans un shell **bash**.

---

### 🔹 Construction de l'image

Pour construire l'image Docker :

```sh
docker build -t ansible-container .
```

---

### 🔹 Ou chargement d'une image existante (format `.tar.xz`)

Si tu as une image exportée, copie-la sur ta machine et exécute :

```sh
xz -d ansible-container.tar.xz
docker load -i ansible-container.tar
docker images  # Vérifier que l'image est bien disponible
```

---

## 📌 2. Exécution du conteneur

Lance un conteneur basé sur l'image avec les options suivantes :

```sh
docker run -ti --rm --privileged --network host \
  --user $(id -u):$(id -g) \
  -v /your_folder:/workspace \
  ansible-container
```

### 🔹 Détail des options :
- `-ti` : Mode interactif (terminal attaché).
- `--rm` : Le conteneur est supprimé automatiquement après arrêt.
- `--privileged` : Nécessaire pour certaines opérations réseau ou accès bas niveau.
- `--network host` : Partage la pile réseau de l’hôte (utile pour tester Ansible sans bridge réseau).
- `--user $(id -u):$(id -g)` : Utilise ton propre UID/GID pour éviter les problèmes de permissions.
- `-v /your_folder:/workspace` : Monte un dossier local dans `/workspace` à l’intérieur du conteneur.

---

## 📌 3. Utilisation d'Ansible dans le conteneur

Une fois dans le conteneur :

### 🔹 Test de connectivité locale

Pour tester qu'Ansible fonctionne correctement en local :

```sh
ansible -i localhost, -m ping all --connection=local
```

### 🔹 Test avec un inventaire personnalisé

Si tu as un fichier `inventory`, utilise :

```sh
ansible -i inventory all -m ping
```

---

## 📂 Résumé du contenu du Dockerfile

| Élément              | Description |
|----------------------|-------------|
| **Base**             | `python:3.11-slim` |
| **Packages installés** | `ansible`, `sshpass`, `bash`, `coreutils`, `iputils-ping`, `net-tools` |
| **Python packages**   | `PyYAML`, `requests`, `pyvmomi`, `pyvim`, `jmespath`, `paramiko` |
| **Ansible Collection** | `community.vmware` |
| **Répertoire de travail** | `/workspace` |
| **Commande par défaut** | `/bin/bash` |
