import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbCow {
  // CREATE TABLE "cows" (
  // "cow_id"	INTEGER NOT NULL,
  // "cow_whight"	INTEGER DEFAULT 2000,
  // "cow_price_killo"	INTEGER DEFAULT 30,
  // "cow_total_price"	INTEGER DEFAULT 6000,
  // "cow_total"	INTEGER,
  // "cow_currency"	TEXT DEFAULT 'شيكل',
  // "cow_person_id"	TEXT DEFAULT '1-2-3',
  // "cow_person_name"	TEXT,
  // "cow_paymentMethod"	TEXT,
  // "cow_note"	TEXT,
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allCows() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from cows ORDER by cow_id ASC';
    return db!.rawQuery(sql);
  }
  Future<List<Map<String, Object?>>> searchJawalsById( int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from cows WHERE cow_id=$id';
    return db!.rawQuery(sql);
  }

  deleteCow(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM cows  WHERE cow_id=$id';
    db!.rawQuery(sql);
  }

  Future<void> addJawal(
      int cow_whight,
      int cow_price_killo,
      int cow_total_price,
      int cow_total,
      String cow_currency,
      String cow_person_id,
      String cow_person_name,
      String cow_paymentMethod,
      String cow_note) async {
    Database? db = await dbHelper.openDb();
    // "cow_id"	INTEGER NOT NULL,// "cow_whight"	INTEGER DEFAULT 2000,
    // "cow_price_killo"	INTEGER DEFAULT 30, // "cow_total_price"	INTEGER DEFAULT 6000,
    // "cow_total"	INTEGER, // "cow_currency"	TEXT DEFAULT 'شيكل',
    // "cow_person_id"	TEXT DEFAULT '1-2-3', // "cow_person_name"	TEXT,
    // "cow_paymentMethod"	TEXT,// "cow_note"	TEXT,
        return db!.execute(
        'INSERT INTO project (cow_whight, cow_price_killo, cow_total_price , cow_total, cow_currency, cow_person_id, cow_person_name, cow_paymentMethod,cow_note ) VALUES ("$cow_whight","$cow_price_killo","$cow_total_price","$cow_total","$cow_currency","$cow_person_id","$cow_person_name","$cow_paymentMethod","$cow_note" );');
  }
}
