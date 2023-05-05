import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbJawal {
  // CREATE TABLE "jawals" (
  // "jawal_id"	INTEGER NOT NULL,
  // "jawal_start_date"	TEXT,
  // "jawal_type"	INTEGER,
  // "jawal_value"	INTEGER,
  // "jawal_currency"	TEXT,
  // "jawal_first_payment"	INTEGER,
  // "jawal_penfit_value"	INTEGER,
  // "jawal_total_value"	INTEGER,
  // "jawal_note"	TEXT,
  // PRIMARY KEY("jawal_id" AUTOINCREMENT)
  // );
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allJawals() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from jawals ORDER by jawal_id ASC';
    return db!.rawQuery(sql);
  }
  Future<List<Map<String, Object?>>> searchJawalsById( int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from jawals WHERE jawal_id=$id';
    return db!.rawQuery(sql);
  }

  deleteJawal(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM jawals  WHERE jawal_id=$id';
    db!.rawQuery(sql);
  }

  Future<void> addJawal(
      String jawal_start_date,
      String jawal_type,
      int jawal_value,
      String jawal_currency,
      int jawal_first_payment,
      int jawal_penfit_value,
      int jawal_total_value,
      String jawal_note) async {
    Database? db = await dbHelper.openDb();
    // "jawal_start_date"	TEXT,// "jawal_type"	String,// "jawal_value"	INTEGER, // "jawal_currency"	TEXT,
    // "jawal_first_payment"	INTEGER,// "jawal_penfit_value"	INTEGER, // "jawal_total_value"	INTEGER,
    // "jawal_note"	TEXT,
        return db!.execute(
        'INSERT INTO jawals (jawal_start_date, jawal_type, jawal_value , jawal_currency, jawal_first_payment, jawal_penfit_value, jawal_total_value, jawal_note ) VALUES ("$jawal_start_date","$jawal_type","$jawal_value","$jawal_currency","$jawal_first_payment","$jawal_penfit_value","$jawal_total_value","$jawal_note" );');
  }
}
