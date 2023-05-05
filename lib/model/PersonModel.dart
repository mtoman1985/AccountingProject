class PersonModel {
  int _id = 1;
  String _name = "mo";
  String _mobile = "0599453796";

  PersonModel(dynamic obj) {
    _id = obj["person_id"];
    _name = obj["person_name"];
    _mobile = obj["person_mobile"];
  }

  PersonModel.fromMap(Map<String, dynamic> data) {
    _id = data["person_id"] as int;
    _name = data["person_name"];
    _mobile = data["person_mobile"];
  }
   void fg ( String person_name ){
     _name = person_name;
 }

  Map<String, dynamic> toMap() =>
      {'person_id': _id, 'person_name': _name, 'person_mobile': _mobile};
  int get id => _id;
  String get name => _name;
  String get mobile => _mobile;
}
