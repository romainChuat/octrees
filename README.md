<h1 align="center">Octree</h1>

<p>Ce travail, réalisé dans un contexte universitaire, vise à acquérir des compétences dans le développement multiplateforme avec les outils de développement logiciel. L'objectif est de développer un projet Flutter et Dart permettant de travailler sur des objets 3D, dont la structure de données sous-jacente est un arbre, via une interface utilisateur. </p>

> Ce README fournit des informations sur l'application Octree, mettant en lumière les différentes fonctionnalités implémentées, la documentation essentielle à la compréhension, les étapes d'installation de l'environnement de travail, l'explication de ce dernier, l'exécution de l'application, ainsi que les commandes indispensables.

## 1. Fonctionnalité implémenté
<p>Lors du lancement de l'application, l'utilisateur a trois choix dans le menu principal :</p>



## 2. Documentations
 • [Documentation Flutter](https://docs.flutter.dev/) <br>
 • [Documentation Dart](https://dart.dev/guides)<br>
 • [Documentation packages Dart](https://pub.dev/)<br>

 ## 3. Installation

### 3.1 Prérequis 

<par>Avant de commencer à travailler sur ce projet, assurez-vous d'avoir installé les outils nécessaires :</par>

 • Installer Flutter : [Flutter](https://docs.flutter.dev/get-started/install) <br>
 • Obtenir le SDK pour Dart : [Dart SDK](https://dart.dev/get-dart)<br>
 
 ### 3.2. Mise en place de l'environnement de travail et execution

 • Cloner le projet à l'aide de la commande : 
 ```
 $git clone
```

• Installer les dépendances nécessaire à l'application : 
 ```
$ flutter pub get
```

• Executer l'application : 
 ```
$ flutter run
```

## 4. Environement de travaille
### 4.1. Arborescence



### 4.2 Architecture

<p>En plus des différents fichiers contenant l'ensemble du code Dart de l'application, nous avons également deux fichiers importants :</p>

 • *.gitignore* : Spécifie les fichiers et répertoires qui doivent être ignorés par Git lors d'un *commit*. <br>
 • *pubspec.yaml* : Défini les dépendances et les paramètres de configuration, 

### 4.3 Dépendance

<par> L'ensemble des dépendance ce situe dans le fichier *pubspec.yaml* dans les partie *dependencies* et *dev_dependencies*: </par> <br>

 • *cupertino_icons: ^1.0.2* : Fournit une collection d'icônes. <br>
 • *provider: ^6.0.5* : Bibliothèque de gestion d'état et de partage de données. <br>
 • *graphview: ^1.2.0* : Affiche des données dans des structures graphiques.<br>
 • *sqflite: ^2.3.0* : Permet d'intégrer et de gérer des bases de données SQLite.<br>
 • *flutter_lints: ^2.0.0* : Ccontient un ensemble recommandé de lints pour les applications, packages et plugins Flutter afin d'encourager de bonnes pratiques de codage.
 • *animated_text_kit: ^4.2.2* : Contient une collection d'animations de texte.
    

### 4.4 Base de donnée




## 5. Commande
  ### 5.1. Commande Flutter principal

 ``` $ flutter run ``` : Permet d'exécuter l'application Flutter.

``` $ flutter pub get ``` : Met à jour les dépendance du projet.

``` $ flutter doctor ``` : Vérifie si l'installation de Flutter est valide.

``` $ flutter emulators ``` : Liste des émulateurs disponibles.

``` $ flutter run -d <nom_emulateur> ``` : Execute l'application sur un émulateur spécifique.

``` $ flutter clean ``` : Supprime les fichiers temporaires et les artefacts de construction générés par Flutter.

``` $ flutter build ``` : Permet de compiler le projet.


### 5.2 Gestion du code source sur le dépot distant

Commande utile pour la gestion du code source sur le dépôt distant:

```$ git status ``` : Pour observer les changements entre le dépôt local et dépôt distant (le fichier texte créé est précédé d’un " ?", se qui veut dire que le fichier n’est pas connu du dépôt distant.

```$ git add nomDuFichier ``` : Versionner un fichier non suivi ou pour ajouter un fichier suivi et ayant été modifié au contenu du prochain commit à destination du dépôt distant.

```$ git commit -m "commit du fichier"``` : Vous permet d’envoyer la nouvelle version locale du
fichier sur le dépôt distant, avec un message (-m ...).

```$ git push origin <nom_branche>``` : Transmet le ou les commits que vous avez réalisés en local au dépôt distant.

```$ git pull origin <nom_branche>``` : Récupération des derniers changements du dépôt distant.

```$ git log``` : Pour afficher la chronologie des commits réalisés.



## 6. Auteurs
 Ce travail a été réalisé par Chuat Romain et Berthod Katty.

## 7. Remerciements
 Nous tenons à remercier notre encadrant pour ses conseils tout au long de ce travail.

