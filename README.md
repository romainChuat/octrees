<h1 align="center">Octree</h1>

<p>Ce travail, réalisé dans un contexte universitaire, vise à acquérir des compétences dans le développement multiplateforme avec les outils de développement logiciel. L'objectif est de développer un projet Flutter et Dart permettant de travailler sur des objets 3D, dont la structure de données sous-jacente est un arbre, via une interface utilisateur. </p>

> Ce README fournit des informations sur l'application Octree, mettant en lumière les différentes fonctionnalités implémentées, la documentation essentielle à la compréhension, les étapes d'installation de l'environnement de travail, l'explication de ce dernier, l'exécution de l'application, ainsi que les commandes indispensables.

## 1. Fonctionnalité implémenté

<p>Cette application propose de nombreuses fonctionnalités, telles que la génération et la visualisation d'arbres représentés en 3D ou sous forme d'arborescence. Vous trouverez ci-dessous les différentes fonctionnalités pour chacune des parties de l'application.</p>
<p>Lors du lancement de l'application, l'utilisateur a trois choix dans le menu principal :</p>

- Générer un arbre
- Visualiser un arbre sauvegardé
- effectuer des opérations sur des arbres


### 1.1 Génération d’un arbre

&emsp;&emsp;&emsp;Vous pouvez générer un arbre à partir d'une chaîne spécifiée, où chaque nœud peut être Divisible (D), Plein (P) ou Vide (V). Les nœuds P et V sont des feuilles sans fils, tandis qu'un nœud D a huit nœuds fils. La racine de l'arbre est associée à une puissance de 2, représentant la taille initiale de l'univers, qui diminue à chaque niveau de l'arbre.

&emsp;&emsp;&emsp;L'application permet également la génération d'un arbre à partir d'une chaîne aléatoire, avec la possibilité de spécifier la longueur des côtésqui est forcément une puissance de 2.

&emsp;&emsp;&emsp;Une fois l'arbre généré, vous pouvez le visualiser en 3D ou sous forme d'arborescence. Sous l'affichage 3D, vous avez la possibilité de sauvegarder l'arbre avec un nom, de modifier les valeurs de phi, theta et rho pour ajuster la vue, de déplacer la forme grâce au tactile, et de zoomer ou dézoomer.

&emsp;&emsp;&emsp;L'application offre une transition fluide entre les affichages 3D et en arborescence. Sous l'affichage en arborescence, vous pouvez aussi sauvegarder l’arbre avec un nom. Vous avez également la possibilité de modifier la valeur de tous les nœuds, ajustant automatiquement les nœuds enfants en conséquence. Par exemple, vous pouvez mettre un D pour rendre les enfants vides et les éditer ultérieurement, ou bien ajouter un P ou un V à la place d’un D, ce qui supprimera l’ensemble des enfants.

### 1.2 Visualisation d’un arbre

&emsp;&emsp;&emsp;Vous pouvez sélectionner un arbre parmi ceux enregistrés après la génération, ainsi que supprimer les arbres sauvegardés existants. Une fois l'arbre choisi, vous avez la possibilité de le visualiser en 3D ou sous forme d'arborescence.

&emsp;&emsp;&emsp;Sous l'affichage 3D, vous pouvez ajuster la vue en modifiant les valeurs de phi, theta et rho. De plus, vous pouvez déplacer la forme en utilisant des commandes tactiles et effectuer des zooms in et out pour une expérience interactive complète, et enfin il est possible de supprimer l’arbre.

&emsp;&emsp;&emsp;L'application offre une transition fluide entre les affichages 3D et en arborescence, avec aussi une possibilité de supprimer l’arbre. Dans le mode arborescence, vous pouvez non seulement modifier la valeur de chaque nœud, mais aussi ajuster automatiquement les nœuds enfants en conséquence. Par exemple, vous pouvez attribuer la valeur "D" pour rendre les enfants vides et les éditer ultérieurement. De même, l'ajout de "P" ou "V" à la place d'un "D" supprimera l'ensemble des enfants, offrant ainsi une flexibilité totale dans la manipulation des structures arborescentes.

### 1.3 Opération sur des arbre

&emsp;&emsp;&emsp;Vous pouvez effectuer des opérations sur deux arbres pour ca entrer le premier arbre de l'opération en saisissant une chaîne (voir la partie 1.1 pour l'explication des chaînes à entrer), en sélectionnant un arbre existant ou en générant un arbre aléatoire en spécifiant la longueur des côtés, qui doit être une puissance de 2. De même, vous avez la possibilité de saisir le deuxième arbre avec les mêmes options.

&emsp;&emsp;&emsp;Après avoir saisi les arbres, l'application permet d'effectuer plusieurs opérations fondamentales telles que l'intersection, l'union et la différence entre ces arbres. Vous pouvez ensuite exécuter l'opération pour obtenir le résultat.

&emsp;&emsp;&emsp;Une fois l'opération réalisée, l'application offre la possibilité de visualiser le nouvel arbre en 3D ou sous forme d'arborescence. Dans l'affichage 3D, vous pouvez sauvegarder le nouvel arbre généré avec un nom, ajuster la vue en modifiant les valeurs de phi, theta et rho, déplacer la forme grâce à des interactions tactiles, et effectuer des zooms ou des dézooms.

&emsp;&emsp;&emsp;L'application offre une transition fluide entre les affichages 3D et en arborescence. Sous l'affichage en arborescence, vous pouvez également sauvegarder l'arbre avec un nom. Vous avez la possibilité de modifier la valeur de tous les nœuds, ajustant automatiquement les nœuds enfants en conséquence. Par exemple, vous pouvez remplacer un "D" pour rendre les enfants vides, éditant ainsi ultérieurement, ou ajouter un "P" ou un "V" à la place d'un "D", ce qui supprimera l'ensemble des enfants.




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

<par>Ci-dessous est présentée l'arborescence du projet Octree avec les fichiers importants.</par>


#### Application

<par>L'ensemble des fichiers contenant le développement se trouve dans le répertoire /lib, chacun ayant l'extension .dart. Voici leur contenu avec une explication de leur fonction:</par>

 ```
/lib

  /Cube.dart //Interface définit des opérations fondamentales pour les différents Voxels dans le contexte de la modélisation tridimensionnelle.

  /Database_helper.dart //Classe qui permet la gestion de la base de doonée.

  /DessinArbre.dart //Classe permettant d'effectuer le dessin en perspective d'une structure arborescente tridimensionnelle représentée par un octree.

  /Librairy.dart //Bibliotèque regroupant les fonctions fréquemment utilisées.

  /Main.dart //Contient la focntion main ainsi que la classe MyApp qui  sert à définir la configuration initiale de l'application.

  /MenuArbreGeneration.dart //Classe représentant un menu permettant à l'utilisateur de générer un arbre en spécifiant une chaîne de caractères ou en générant une longueur aléatoire.

  /MenuArbreSauvegarde.dart //Classe représentant un menu permettant à l'utilisateur de visualiser et gérer la liste des arbres sauvegardés.

  /MenuPrincipal.dart //Classe représentant la page d'accueil avec les différents choix possible.

  /ModelProvider.dart //Gestionnaire de modèle dans l'application, fournissant de nombreuses méthodes.

  /Octree.dart //Classe permettant de représenter une structure de données octree en 3D, avec de nombreuses méthodes en liens avec ces derniers.

  /Operation.dart //Classe permettant de représenter une interface utilisateur permettant à l'utilisateur d'effectuer des opérations (intersection, union, différence) sur des structures de données de type octree en 3D).

  /Visualisation.dart //Cette classe permet d'afficher une zone permettant de visualiser et d'interagir avec une structure de données de type Octree en 3D et en arborescence 2D.
 ```

#### Racine

<p>En plus des différents fichiers contenant l'ensemble du code Dart de l'application, nous avons également deux fichiers et un répertoire importants :</p>

 • *.gitignore* : Spécifie les fichiers et répertoires qui doivent être ignorés par Git lors d'un *commit*. <br>
 • *pubspec.yaml* : Défini les dépendances et les paramètres de configuration.<br>
  • _/assets_ : Contient l'image _.png_ du logo de l'application.



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

Une base de données sqlflite est stockée sous la forme d'un fichier enregistré sur l'appareil de l'utilisateur. La création de la base de données est faite dans le fichier `Database_helper.dart`
Si vous ouvrez l'explorateur de fichier de votre émulateur dans Android Studio, vous pourrez trouvrer le fichier `db_flutter.db` au chemin suivant : 
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

