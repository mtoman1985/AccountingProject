import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbPicture {
// CREATE TABLE "pictures" (
// 	"picture_id"	INTEGER NOT NULL UNIQUE,
// 	"picture_name"	TEXT,
// 	"picture_location"	TEXT,
// 	"picture_location_id"	TEXT,
// 	PRIMARY KEY("picture_id" AUTOINCREMENT)
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allPictures() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from pictures ORDER by picture_name ASC';
    return db!.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> lastPicture() async {
    Database? db = await dbHelper.openDb();
    String sql =
        'SELECT MAX(picture_id)+1 as maxno FROM  pictures';
    return db!.rawQuery(sql);
  }

  deletePicture(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM pictures WHERE picture_id=$id';
    db!.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>?> searchPictureByProject(
      String projectId, String pictureLocation) async {
    Database? db = await dbHelper.openDb();
    String sql = "SELECT * from  pictures WHERE picture_location_id="
        '"${projectId.trim()}"'
        " and picture_location="
        '"$pictureLocation"'
        " ";
    return db?.rawQuery(sql);
  }

  Future<Future<List<Map<String, Object?>>>?> searchingPicture(
      String name) async {
    Database? db = await dbHelper.openDb();
    String sql = "";
    if (name.isNotEmpty) {
      sql =
          'SELECT * from  pictures	 WHERE picture_name like "$name%"  or picture_name like "%$name"  or picture_name like "%$name%" ORDER by picture_name ASC';
    } else {
      sql = 'SELECT * from  pictures ORDER by picture_name ASC';
    }
    return db?.rawQuery(sql);
  }

  Future<void> addPicture(String pictureName, String pictureLocationId) async {
    Database? db = await dbHelper.openDb();
    return db!.execute(
        'INSERT INTO pictures (picture_name,picture_location_id, picture_location ) VALUES ("$pictureName","$pictureLocationId","project");');
  }
}
