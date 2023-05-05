import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbCheckWallet {
// "checkWallet_id"	INTEGER NOT NULL,
// "checkWallet_fromperson_id"	INTEGER,
// "checkWallet_toperson_id"	INTEGER,
// "checkWallet_value"	INTEGER,
// "checkWallet_date"	TEXT,
// "checkWallet_exdate"	TEXT,
// "checkWallet_currency"	TEXT DEFAULT 'شيكل',
// "checkWallet_done"	TEXT DEFAULT 'لا',
// "checkWallet_direction"	TEXT DEFAULT 'بنك',
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allCheckWallet() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from checkWallet ORDER by checkWallet_id ASC';
    return db!.rawQuery(sql);
  }
  Future<List<Map<String, Object?>>> allCheckWalletNotEnded() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from Un_CheckWallet_names';
    return db!.rawQuery(sql);
/*    String value="لا";
    String sql = 'SELECT * from checkWallet where checkWallet_done= "$value" ORDER by checkWallet_id ASC';
    return db!.rawQuery(sql);*/
  }

  deleteCheckWallet(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM checkWallet  WHERE checkWallet_id=$id';
    db!.rawQuery(sql);
  }
// Delete
  Future<Future<List<Map<String, Object?>>>?> searchingInstallments(
      String name) async {
    Database? db = await dbHelper.openDb();
    String sql = "";
    if (name.isNotEmpty) {
      sql =
          'SELECT * from  project	 WHERE project_name like "$name%"  or person_name like "%$name"  or person_name like "%$name%" ORDER by person_name ASC';
    } else {
      sql = 'SELECT * from  project ORDER by project_name ASC';
    }
    return db?.rawQuery(sql);
  }

  Future<void> addCheckWallet(
      int checkWalletFromPerson,
      int checkWalletToPerson,
      int checkWalletValue,
      String checkWalletDate,
      String checkWalletExDate,
      String checkWalletCurrency,
      String checkWalletDone,
      String checkWalletDirection ) async {
    Database? db = await dbHelper.openDb();
// "checkWallet_id"	INTEGER NOT NULL,
// "checkWallet_fromperson_id"	INTEGER,
// "checkWallet_toperson_id"	INTEGER,
// "checkWallet_value"	INTEGER,
// "checkWallet_date"	TEXT,
// "checkWallet_exdate"	TEXT,
// "checkWallet_currency"	TEXT DEFAULT 'شيكل',
// "checkWallet_done"	TEXT DEFAULT 'لا',
// "checkWallet_direction"	TEXT DEFAULT 'بنك',
    return db!.execute(
        'INSERT INTO checkWallet ( checkWallet_fromperson_id, checkWallet_toperson_id , checkWallet_value, checkWallet_date, checkWallet_exdate, checkWallet_currency, checkWallet_done, checkWallet_direction ) VALUES ("$checkWalletFromPerson","$checkWalletToPerson","$checkWalletValue","$checkWalletDate","$checkWalletExDate","$checkWalletCurrency","$checkWalletDone","$checkWalletDirection" );');
  }
}
