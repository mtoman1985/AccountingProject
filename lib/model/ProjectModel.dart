class ProjectModel {
  int _projectId = 1; //project_id
  String _projectName = "mo"; //project_name
  int _projectPersonNo = 1; //project_person_no
  String _projectStartDate = "2";

  int get projectId => _projectId;

  set projectId(int value) {
    _projectId = value;
  } //project_start_date

  int _projectValue = 500; //project_value
  String _projectCurrency = "شيكل"; //project_currency
  int _projectFirstPayment = 100; //project_first_payment
  int _projectCheckNo = 5; //project_check_no
  int _projectPenfit = 12; //project_penfit
  int _projectTotalValue = 500; //project_total_value

  ProjectModel(dynamic obj) {
    _projectId = obj["project_id"]; //project_id
    _projectName = obj["project_name"]; //project_name
    _projectPersonNo = obj["project_person_no"]; //project_person_no
    _projectStartDate = obj["project_start_date"]; //project_start_date
    _projectValue = obj["project_value"]; //project_value
    _projectCurrency = obj["project_currency"]; //project_currency
    _projectFirstPayment = obj["project_first_payment"]; //project_first_payment
    _projectCheckNo = obj["project_check_no"]; //project_check_no
    _projectPenfit = obj["project_penfit"]; //project_penfit
    _projectTotalValue = obj["project_total_value"]; //project_total_value
  }

  ProjectModel.fromMap(Map<String, dynamic> data) {
    _projectId = data["project_id"]; //project_id
    _projectName = data["project_name"]; //project_name
    _projectPersonNo = data["project_person_no"]; //project_person_no
    _projectStartDate = data["project_start_date"]; //project_start_date
    _projectValue = data["project_value"]; //project_value
    _projectCurrency = data["project_currency"]; //project_currency
    _projectFirstPayment =
        data["project_first_payment"]; //project_first_payment
    _projectCheckNo = data["project_check_no"]; //project_check_no
    _projectPenfit = data["project_penfit"]; //project_penfit
    _projectTotalValue = data["project_total_value"]; //project_total_value
  }

  Map<String, dynamic> toMap() => {
        'project_id': _projectId, //project_id
        'project_name': _projectName, //project_name
        'project_person_no': _projectPersonNo, //project_person_no
        'project_start_date': _projectStartDate, //project_start_date
        'project_value': _projectValue, //project_value
        'project_currency': _projectCurrency, //project_currency
        'project_first_payment': _projectFirstPayment, //project_first_payment
        'project_check_no': _projectCheckNo, //project_check_no
        'project_penfit': _projectPenfit, //project_penfit
        'project_total_value': _projectTotalValue //project_total_value
      };

  String get projectName => _projectName;

  set projectName(String value) {
    _projectName = value;
  }

  int get projectPersonNo => _projectPersonNo;

  set projectPersonNo(int value) {
    _projectPersonNo = value;
  }

  String get projectStartDate => _projectStartDate;

  set projectStartDate(String value) {
    _projectStartDate = value;
  }

  int get projectValue => _projectValue;

  set projectValue(int value) {
    _projectValue = value;
  }

  String get projectCurrency => _projectCurrency;

  set projectCurrency(String value) {
    _projectCurrency = value;
  }

  int get projectFirstPayment => _projectFirstPayment;

  set projectFirstPayment(int value) {
    _projectFirstPayment = value;
  }

  int get projectCheckNo => _projectCheckNo;

  set projectCheckNo(int value) {
    _projectCheckNo = value;
  }

  int get projectPenfit => _projectPenfit;

  set projectPenfit(int value) {
    _projectPenfit = value;
  }

  int get projectTotalValue => _projectTotalValue;

  set projectTotalValue(int value) {
    _projectTotalValue = value;
  }
}
