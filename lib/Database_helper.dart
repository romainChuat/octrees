import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Cette classe permet la création et la gestion de la base de donnees
class DatabaseHelper  {

 DatabaseHelper._Constructor();

  static const _databaseName = "db_flutter.db";
  static const _databaseVersion = 1;
  var dbPath;
  var path;

 static final DatabaseHelper  _dbhelper =  DatabaseHelper._Constructor();

  static DatabaseHelper get dbhelper {
     return _dbhelper;
  }

  static Database? _db;

  /// get de db
 /// si db n'est pas encore instancié on cree une nouvelle instance
  Future<Database> get db async {
    if (_db != null) return _db! ;
    _db = await initDatabase() ;
    return _db! ;
  }

  /// initialisation de la base de donnees
  Future<Database> initDatabase() async {
    /// chemin de la base donnee
    dbPath = await getDatabasesPath();
    path = join(dbPath, _databaseName);
    /// ouverture de la base de donnees
    return openDatabase( path, version: _databaseVersion,onCreate: _create,);
  }

  /// cree la base de donnees
 /// la base contient une unique table tree
 /// un tree est identifie par son id unique,
 /// son nom et la chaine de l'univers que le represente
 Future _create (Database db, int version) async {
   await db.execute('''
    create table tree (
      id integer primary key autoincrement,
      tree_name text,
      tree_string text
      )
   '''
   );
 }

 /// utile a la fermeture de la base de donnees
  Future close() async => await _db!.close() ;

  /// insertion d'un nouvel arbre dans la base de donne
 /// la map octree contient un nom et la chaine representant l'univers de l'octree
  Future<int> insertTree(Map<String,String> octree) async{
    Database db = await _dbhelper.db ;
    int? id =  await db.insert('tree', octree);
    return id;
  }

  /// suppression d'un arbre identifie par son nom
 /// retourne
  Future<int> deleteTreeByName(String name) async{
    Database db = await _dbhelper.db ;
    return await db.delete('tree', where: 'tree_name = ?', whereArgs: [name]);
  }

  /// retounre l'arbre identifie par name
 /// retourne null si l'arbre recherche n'existe pas
  Future<String?> getByName(String name) async{
   Database db  = await _dbhelper.db;
   String res = (await db.query("SELECT tree_string FROM tree WHERE tree_name = '$name' ",)) as String;
   return res;
 }

 /// retourne une map contenant tout les octrees de la base de donnees
 /// on retourne leurs nom et leurs univers uniquement
  Future<List<Map<String,dynamic>>> getAllTree() async{
    Database db  = await _dbhelper.db;
    var res  = await db.query("tree", columns: ["tree_name","tree_string"]);
    if(res.isEmpty){
      return [];
    }
    return res;
 }





}
