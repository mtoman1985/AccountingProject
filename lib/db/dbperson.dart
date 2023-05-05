import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbPerson {
  DbHelper dbHelper = DbHelper();
  Future<List<Map<String, Object?>>> allPersons() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from  persons ORDER by person_name ASC';
    return db!.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> searchPersonById(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from  persons WHERE person_id=$id ORDER by person_name ASC';
    return db!.rawQuery(sql);
  }

  deletePerson(int id) async {
    Database? db = await dbHelper.openDb();
    // return db!.delete('persons', where: 'id = ?', whereArgs: [id]);
    String sql = 'DELETE FROM persons  WHERE person_id=$id';
    db!.rawQuery(sql);
  }

  Future<Future<List<Map<String, Object?>>>?> searchingPersons(
      String name) async {
    Database? db = await dbHelper.openDb();
    String sql = "";
    if (name.isNotEmpty) {
      sql =
          'SELECT * from  persons	 WHERE person_name like "$name%"  or person_name like "%$name"  or person_name like "%$name%" ORDER by person_name ASC';
    } else {
      sql = 'SELECT * from  persons ORDER by person_name ASC';
    }
    return db?.rawQuery(sql);
  }

  Future<void> addPersons(String name, String mobile) async {
    Database? db = await dbHelper.openDb();
    return db!.execute(
        'INSERT INTO persons (person_name, person_mobile) VALUES ("$name", "$mobile");');
  }
}
