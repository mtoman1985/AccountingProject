// CREATE TABLE "pictures" (
// 	"picture_id"	INTEGER NOT NULL UNIQUE,
// 	"picture_name"	TEXT,
// 	"picture_location"	TEXT,
class PictureModel {
  int pictureId = 1; //picture_id
  String pictureName = "mo"; //picture_name
  String pictureLocation = "2"; //picture_location
  String pictureLocationId = "1"; //	"picture_location_id"	TEXT,

  PictureModel(dynamic obj) {
    pictureId = obj["picture_id"]; //picture_id
    pictureName = obj["picture_name"]; //picture_name
    pictureLocation = obj["picture_location"]; //picture_location
    pictureLocationId = obj["picture_location_id"]; //picture_location_id
  }

  PictureModel.fromMap(Map<String, dynamic> data) {
    pictureId = data["picture_id"]; //picture_id
    pictureName = data["picture_name"]; //picture_name
    pictureLocation = data["picture_location"]; //picture_location
    pictureLocationId = data["picture_location_id"]; //picture_location_id
  }

  Map<String, dynamic> toMap() => {
        'picture_id': pictureId, //picture_id
        'picture_name': pictureName, //picture_name
        'picture_location': pictureLocation, //picture_location
        'picture_location_id': pictureLocationId, //picture_location_id
      };
}
