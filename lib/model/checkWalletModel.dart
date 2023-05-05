// "checkWallet_id"	INTEGER NOT NULL,
// "checkWallet_fromperson_id"	INTEGER,
// "checkWallet_toperson_id"	INTEGER,
// "checkWallet_value"	INTEGER,
// "checkWallet_date"	TEXT,
// "checkWallet_exdate"	TEXT,
// "checkWallet_currency"	TEXT DEFAULT 'شيكل',
// "checkWallet_done"	TEXT DEFAULT 'لا',
// "checkWallet_direction"	TEXT DEFAULT 'بنك',
class CheckWalletModel {
  int _id = 1;
  int _fromperson_id = 1;
  int _toperson_id = 1;
  String _type = "شيك";
  String _no = "G57656";
  int _value = 7000;
  String _date = "21/12/2022";
  String _exdate = "21/12/2022";
  String _currency = "شيكل";
  String _done = "لا";
  String _direction = 'بنك';
  String _picture = 'mohamed';

  CheckWalletModel(dynamic obj) {
    _id = obj["checkWallet_id"];
    _fromperson_id = obj["checkWallet_fromperson_id"];
    _toperson_id = obj["checkWallet_toperson_id"];
    _type = obj["checkWallet_type"];
    _no = obj["checkWallet_no"];
    _value = obj["checkWallet_value"];
    _date = obj["checkWallet_date"];
    _exdate = obj["checkWallet_exdate"];
    _currency = obj["checkWallet_currency"];
    _done = obj["checkWallet_done"];
    _direction = obj["checkWallet_direction"];
    _picture = obj["checkWallet_picture"];

// "checkWallet_id"	INTEGER NOT NULL,
// "checkWallet_fromperson_id"	INTEGER,
// "checkWallet_toperson_id"	INTEGER,
// "checkWallet_value"	INTEGER,
// "checkWallet_date"	TEXT,
// "checkWallet_exdate"	TEXT,
// "checkWallet_currency"	TEXT DEFAULT 'شيكل',
// "checkWallet_done"	TEXT DEFAULT 'لا',
// "checkWallet_direction"	TEXT DEFAULT 'بنك',
  }
  CheckWalletModel.fromMap(Map<String, dynamic> data) {
    _id = data["checkWallet_id"] as int;
    _fromperson_id = data["checkWallet_fromperson_id"];
    _toperson_id = data["checkWallet_toperson_id"];
    _type = data["checkWallet_type"];
    _no = data["checkWallet_no"];
    _value = data["checkWallet_value"] as int;
    _date = data["checkWallet_date"];
    _exdate = data["checkWallet_exdate"];
    _currency = data["checkWallet_currency"];
    _done = data["checkWallet_done"];
    _direction = data["checkWallet_direction"];
    _picture = data["checkWallet_picture"];
  }
  Map<String, dynamic> toMap() => {
        'checkWallet_id': _id,
        'checkWallet_fromperson_id': _fromperson_id,
        'checkWallet_toperson_id': _toperson_id,
        'checkWallet_value': _value,
        'checkWallet_type': _type,
        'checkWallet_no': _no,
        'checkWallet_date': _date,
        'checkWallet_exdate': _exdate,
        'checkWallet_currency': _currency,
        'checkWallet_done': _done,
        'checkWallet_direction': _direction,
        'checkWallet_picture': _picture
      };

  String get picture => _picture;

  set picture(String value) {
    _picture = value;
  }

  String get direction => _direction;

  set direction(String value) {
    _direction = value;
  }

  String get done => _done;

  set done(String value) {
    _done = value;
  }

  String get currency => _currency;

  set currency(String value) {
    _currency = value;
  }

  String get exdate => _exdate;

  set exdate(String value) {
    _exdate = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get value => _value;

  set value(int value) {
    _value = value;
  }

  int get toperson_id => _toperson_id;

  set toperson_id(int value) {
    _toperson_id = value;
  }

  int get fromperson_id => _fromperson_id;

  set fromperson_id(int value) {
    _fromperson_id = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get no => _no;

  set no(String value) {
    _no = value;
  }
}
