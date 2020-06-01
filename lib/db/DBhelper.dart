import 'dart:async';
import 'package:argument/domain/usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{

  Database _database;

  Future<Database> getDatabase() async{
    if(_database == null){
      return openDatabase(
        join(await getDatabasesPath(), 'argument.db'),
        onCreate: (db, version){
          return db.execute(
            "CREATE TABLE ${Usuario.TABLE_NAME}(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT, senha TEXT, admin BOOLEAN)",
          );
        },
        version: 1,
      ).then((value){
        this._database = value;
        return value;
      });
    }else{
      return Future.value(_database);
    }
  }



 
}