class BuildingModel {
  // CREATE TABLE "P_buildings" (
  // "building_id"	INTEGER NOT NULL UNIQUE,
  // "building_first_payment"	INTEGER,
  // "project_id"	INTEGER,
  // "building_check_no"	NUMERIC,
  // "building_penfit"	INTEGER,
  // "building_total_value"	INTEGER
  // );
  int _buildingId = 1; //building_id
  int _projectFirstPayment = 100; //project_first_payment
  int _projectId = 1; //project_id
  int _projectCheckNo = 5; //project_check_no
  int _projectPenfit = 12; //project_penfit
  int _projectTotalValue = 500;

  int get buildingId => _buildingId;

  set buildingId(int value) {
    _buildingId = value;
  } //project_total_value


  BuildingModel(dynamic obj) {
    _projectId = obj["project_id"]; //project_id
    _buildingId = obj["building_id"]; //building_id
    _projectFirstPayment = obj["project_first_payment"]; //project_first_payment
    _projectCheckNo = obj["project_check_no"]; //project_check_no
    _projectPenfit = obj["project_penfit"]; //project_penfit
    _projectTotalValue = obj["project_total_value"]; //project_total_value
  }

  BuildingModel.fromMap(Map<String, dynamic> data) {
    _projectId = data["project_id"]; //project_id
    _buildingId = data["building_id"]; //building_id
    _projectFirstPayment = data["project_first_payment"]; //project_first_payment
    _projectCheckNo = data["project_check_no"]; //project_check_no
    _projectPenfit = data["project_penfit"]; //project_penfit
    _projectTotalValue = data["project_total_value"]; //project_total_value
  }

  Map<String, dynamic> toMap() => {
        'project_id': _projectId, //project_id
        'project_name': _buildingId, //building_id
        'project_first_payment': _projectFirstPayment, //project_first_payment
        'project_check_no': _projectCheckNo, //project_check_no
        'project_penfit': _projectPenfit, //project_penfit
        'project_total_value': _projectTotalValue //project_total_value
      };

  int get projectFirstPayment => _projectFirstPayment;

  int get projectTotalValue => _projectTotalValue;

  set projectTotalValue(int value) {
    _projectTotalValue = value;
  }

  int get projectPenfit => _projectPenfit;

  set projectPenfit(int value) {
    _projectPenfit = value;
  }

  int get projectCheckNo => _projectCheckNo;

  set projectCheckNo(int value) {
    _projectCheckNo = value;
  }

  int get projectId => _projectId;

  set projectId(int value) {
    _projectId = value;
  }

  set projectFirstPayment(int value) {
    _projectFirstPayment = value;
  }
}
