<h1 align="center">Octree</h1>

<p>Ce travail, réalisé dans un contexte universitaire, vise à acquérir des compétences dans le développement multiplateforme avec les outils de développement logiciel. L'objectif est de développer un projet Flutter et Dart permettant de travailler sur des objets 3D, dont la structure de données sous-jacente est un arbre, via une interface utilisateur. </p>

> Ce README fournit des informations sur l'application Octree, mettant en lumière les différentes fonctionnalités implémentées, la documentation essentielle à la compréhension, les étapes d'installation de l'environnement de travail, l'explication de ce dernier, l'exécution de l'application, ainsi que les commandes indispensables.

## 1. Fonctionnalité implémenté
<p>Lors du lancement de l'application, l'utilisateur a trois choix dans le menu principal :</p>



## 2. Documentations
 • [Documentation Flutter](https://docs.flutter.dev/) <br>
 • [Documentation Dart](https://dart.dev/guides)<br>
 • [Documentation packages Dart](https://pub.dev/)<br>

 ## 3. Installation et exécution de l’application

### 3.1 Prérequis 

<par>Avant de commencer à travailler sur ce projet, assurez-vous d'avoir installé les outils nécessaires :</par>

 • Installer Flutter : [Flutter](https://docs.flutter.dev/get-started/install) <br>
 • Obtenir le SDK pour Dart : [Dart SDK](https://dart.dev/get-dart)<br>
 • Installer un environnement de dévelompement, favoriser l’IDE : [Android Studio](https://developer.android.com/codelabs/basic-android-kotlin-training-install-android-studio?hl=fr#0)<br>
 
 ### 3.2. Mise en place de l'environnement de travail et execution

 <par>Pour commencer, vous devez obtenir une copie de l'application en clonant le dépôt sur GitHub ou en téléchargeant une version compressée au format ZIP sur votre ordinateur. Pour ce faire suivez les étape suivante : </par>

**• Cloner le projet à l'aide avec Git :** 

 1. Créez un dossier où vous souhaitez stocker le projet<br>
 2. Exécutez la commande suivante dans le dossier nouvellement créé :<br>

 ```
$ git clone https://github.com/romainChuat/octrees.git
```

**• Ou bien installer en téléchargeant un fichier compresser (_.zip_)**

1. Décompressez le fichier à l'aide de l'interface graphique ou en utilisant la commande suivante : 
 ```
$ unzip /[chemin vers votre fichier]/nom_du_fichier.zip
```

**• Ouverture du code à l’aide d’une environnement de développement :**

<par>Maintenant que le projet a été cloné ou décompressé localement, ouvrez-le dans un éditeur de code, en privilégiant un IDE dédié comme Android Studio, spécialement conçu pour les applications mobiles. Bien que Visual Studio Code soit également une option fonctionnelle. Pour ce faire, accédez à Fichier > Ouvrir le dossier dans l'IDE. Une fois ouvert, vous pouvez utiliser un terminal intégré ou externe pour les étapes suivantes.</par>

**• Installation des dépendances nécessaires à l'éxécution de l'application :**

<par>Réaliser cette commande:</par>
 ```
$ flutter pub get
```

**• Connexion d'un appareil ou utilisation d'un émulateur :**

<par>Connectez un appareil Android à votre ordinateur via USB ou utilisez un émulateur Android. En haut à gauche, choisissez la cible (device) du projet : linux ou chrome. Générez et exécutez le programme pour ces deux cibles. Si vous n'avez pas d'émulateur, créez-en un en utilisant l'icône Device Manager, choisissez un téléphone, et téléchargez le SDK correspondant.</par>

**• Exécution de l'application :**

<par>Cliquez sur le bouton "run" (flêches vertes) en haut à gauche de l'écran. Android Studio compilera votre application et la lancera sur l'appareil ou l'émulateur choisi.</par>

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
 • *flutter_lints: ^2.0.0* : Ccontient un ensemble recommandé de lints pour les applications, packages et plugins Flutter afin d'encourager de bonnes pratiques de codage.<br>
 • *animated_text_kit: ^4.2.2* : Contient une collection d'animations de texte.
    

### 4.4 Base de donnée

L'ensemble des arbres enregistré par l'utilisateur sont sauvegardés dans une base de données locale au téléphone grâce à *sqflite*. Ainsi, si un utilisateur quitte l'application, il pourra retrouver les arbres qu'il a 
crée lors de sa prochaine utilisation de l'application.

Une base de données sqlflite est stockée sous la forme d'un fichier enregistré sur l'appareil de l'utilisateur. La création de la base de données est faite dans le fichier *Database_helper.dart*
Si vous ouvrez l'explorateur de fichier de votre émulateur dans Android Studio, vous pourrez trouvrer le fichier db_flutter.db au chemin suivant : 
- *data/user/0/com.example.octrees/databases/db_flutter.db*


Les arbres sont les seules données à être enregistrés dans la base de données *sqflite*, ils sont enregistrés dans la table octree. Dans la table octree, un arbre est identifié par un entier id, un nom sous forme de chaîne de caractères
et la chaîne de caractères représentant l'univers de l'octree.


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

