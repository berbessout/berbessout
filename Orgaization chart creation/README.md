# 📊 Générateur d'Organigramme

Un outil web intelligent qui transforme automatiquement une description textuelle d'une organisation en organigramme visuel interactif.

## 🚀 Fonctionnalités

- **Analyse de texte intelligente** : Parse automatiquement les descriptions d'organisation
- **Génération d'organigramme** : Crée des diagrammes hiérarchiques avec Mermaid.js
- **Interface web moderne** : Interface utilisateur intuitive et responsive
- **Mise à jour en temps réel** : L'organigramme se met à jour automatiquement quand le texte change

## 🛠️ Technologies utilisées

- **Backend** : Python + Flask
- **Frontend** : HTML5 + CSS3 + JavaScript
- **Génération de diagrammes** : Mermaid.js
- **Analyse de texte** : Regex + NLP basique
- **Gestion des graphes** : NetworkX

## 📦 Installation

### Prérequis

- Python 3.13 ou supérieur
- pip (gestionnaire de paquets Python)

### Étapes d'installation

1. **Cloner le projet** (si ce n'est pas déjà fait) :
   ```bash
   git clone <url-du-repo>
   cd projet-red
   ```

2. **Créer un environnement virtuel** :
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # Sur macOS/Linux
   # ou
   .venv\Scripts\activate     # Sur Windows
   ```

3. **Installer les dépendances** :
   ```bash
   pip install -e .
   ```

## 🚀 Lancement

### Méthode 1 : Via le script Python
```bash
python src/app.py
```

### Méthode 2 : Via la commande installée
```bash
organigramme
```

### Méthode 3 : Avec Flask directement
```bash
export FLASK_APP=src.app
export FLASK_DEBUG=true
flask run
```

L'application sera accessible à l'adresse : **http://localhost:5000**

## 📝 Utilisation

### 1. Saisie du texte
Dans l'interface web, saisissez une description de votre organisation. Par exemple :

```
Alice est PDG et supervise Bob (Directeur Technique) et Claire (Directrice Marketing). 
Bob supervise David et Emma qui sont développeurs dans l'équipe technique. 
Claire dirige Sophie qui est responsable marketing.
```

### 2. Génération de l'organigramme
Cliquez sur le bouton "🚀 Générer l'organigramme" pour créer automatiquement l'organigramme.

### 3. Visualisation
L'organigramme s'affiche instantanément dans la section de droite avec :
- Les noms des personnes
- Leurs rôles
- Les relations hiérarchiques

## 🔧 Structure du projet

```
projet-red/
├── src/
│   ├── __init__.py
│   ├── app.py              # Application Flask principale
│   ├── parser.py           # Module d'analyse de texte
│   ├── templates/
│   │   └── index.html      # Interface utilisateur
│   └── static/             # Fichiers statiques (CSS, JS)
├── pyproject.toml          # Configuration du projet
└── README.md              # Ce fichier
```

## 🧠 Comment ça fonctionne

### 1. Analyse du texte
Le module `parser.py` analyse le texte fourni pour :
- Extraire les noms des personnes
- Identifier leurs rôles
- Détecter les relations hiérarchiques

### 2. Génération du graphe
Les informations extraites sont converties en structure de graphe utilisant NetworkX.

### 3. Création du diagramme
Le graphe est converti en syntaxe Mermaid.js pour générer l'organigramme visuel.

## 📋 Exemples de syntaxe

### Relations hiérarchiques reconnues
- "Alice supervise Bob"
- "Bob rapporte à Alice"
- "Alice est le chef de Bob"
- "Alice dirige Bob"

### Rôles reconnus
- PDG, CEO
- Directeur, Directrice
- Manager, Chef
- Développeur, Ingénieur
- Analyste, Designer
- Marketing, Commercial

## 🔮 Améliorations futures

- [ ] Support pour les équipes et départements
- [ ] Export en PDF/PNG
- [ ] Édition interactive de l'organigramme
- [ ] Historique des modifications
- [ ] Support multilingue
- [ ] Intégration avec des bases de données
- [ ] API REST pour intégration externe

## 🐛 Dépannage

### Problème : "Module not found"
```bash
# Vérifiez que l'environnement virtuel est activé
source .venv/bin/activate
pip install -e .
```

### Problème : Port déjà utilisé
```bash
# Changez le port
export PORT=5001
python src/app.py
```

### Problème : Erreur de génération d'organigramme
- Vérifiez que le texte contient des noms propres (commençant par une majuscule)
- Assurez-vous d'utiliser des mots-clés de relation (supervise, dirige, etc.)

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
1. Fork le projet
2. Créer une branche pour votre fonctionnalité
3. Commiter vos changements
4. Pousser vers la branche
5. Ouvrir une Pull Request

## 📞 Support

Pour toute question ou problème, n'hésitez pas à ouvrir une issue sur GitHub.
