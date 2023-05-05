import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbOutcome {
  // CREATE TABLE "outcomes" (
  // "outcome_id"	INTEGER NOT NULL,
  // "outcome_date"	TEXT DEFAULT '22/03/2023',
  // "outcome_person_id"	INTEGER DEFAULT 1,
  // "outcome_project_id"	INTEGER DEFAULT 1,
  // "outcome_value"	NUMERIC DEFAULT 3000,
  // "outcome_currency"	TEXT DEFAULT 'شيكل',
  // "outcome_currencyValue"	NUMERIC DEFAULT 3.5,
  // "outcome_paymentMethod"	TEXT DEFAULT 'نقدي',
  // "outcome_note"	TEXT,
  // PRIMARY KEY("outcome_id" AUTOINCREMENT)
  // );
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allOutcome() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from outcomes ORDER by outcome_id ASC';
    return db!.rawQuery(sql);
  }

  deleteOutcome(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM outcomes  WHERE outcome_id=$id';
    db!.rawQuery(sql);
  }

  Future<void> addOutcome(
      String outcome_date,
      int outcome_person_id,
      String outcome_person_name,
      int outcome_project_id,
      String outcome_project_type,
      String outcome_project_name,
      int outcome_value,
      String outcome_currency,
      int outcome_currencyValue,
      String outcome_paymentMethod,
      String outcome_note  ) async {
    Database? db = await dbHelper.openDb();

    return db!.execute(                                                                                                                                                                    //outcome_date, outcome_person_id , outcome_project_id, outcome_value, outcome_currency, outcome_currencyValue, outcome_paymentMethod, outcome_note
        'INSERT INTO outcomes ( outcome_date,outcome_person_id,outcome_person_name,outcome_project_id,outcome_project_type,outcome_project_name,outcome_value,outcome_currency,outcome_currencyValue,outcome_paymentMethod,outcome_note ) VALUES ("$outcome_date","$outcome_person_id","$outcome_person_name","$outcome_project_id","$outcome_project_type","$outcome_project_name","$outcome_value","$outcome_currencyValue","$outcome_paymentMethod","$outcome_note" );');
  }
}
