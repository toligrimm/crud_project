import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

class DatabaseHelper{
  static const _databaseName = 'Contact.db';
  static const _databaseVersion = 1;


  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Database get database{
    if(_database != null) return _database;
    _database = _initDatabase();
    return _database;
  }
  _initDatabase() async{
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path,_databaseName);
    return await openDatabase(dbPath, version: _databaseVersion, onCreate: _onCreateDB);
  }
  _onCreateDB(Database db, int version) async {
    
    await db.execute('''
    CREATE TABLE ${Contact}
    ''')
  }
}