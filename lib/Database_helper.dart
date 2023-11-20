import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Octree.dart';

class Database_helper {


 Database_helper._Constructor();

  static const _databaseName = "db_flutter.db";
  static const _databaseVersion = 1;
  var dbPath;
  var path;

 static final Database_helper  _dbhelper =  Database_helper._Constructor();

  static Database_helper get dbhelper {
     return _dbhelper;
  }

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db! ;
    _db = await initDatabase() ;
    return _db! ;
  }

  Future<Database> initDatabase() async {
    dbPath = await getDatabasesPath();
    print(dbPath);
    path = join(dbPath, _databaseName);
    print(path);
    return openDatabase( path, version: _databaseVersion,onCreate: _create,);
  }

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

 Future close() async => await _db!.close() ;

  Future<int> insertTree(Map<String,String> octree) async{
    Database db = await _dbhelper.db ;
    int? id =  await db.insert('tree', octree);
    return id;
  }

  Future<int> deleteByName(String name) async{
    Database db = await _dbhelper.db ;
    return await db.delete('tree', where: 'tree_name = ?', whereArgs: [name]);
  }

  Future addTree() async{

  }


}
