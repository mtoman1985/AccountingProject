import 'package:belal_pro/db/dbcheckwallet.dart';
import 'package:belal_pro/db/dbperson.dart';
import 'package:belal_pro/model/PersonModel.dart';
import 'package:belal_pro/model/checkWalletModel.dart';
import 'package:belal_pro/model/installmentsModel.dart';
import 'package:belal_pro/themes/custom_theme.dart';
import 'package:flutter/material.dart';
class IncomeAddDialog extends StatefulWidget {
  final String title, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;
  IncomeAddDialog({
    super.key,
    required this.title,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.positiveBtnPressed,
  });
  @override
  State<StatefulWidget> createState() => _IncomeAddDialogState();
}

class _IncomeAddDialogState extends State<IncomeAddDialog> {
  List<String> listPersons = [];
  List<String> listChecks = [];
  List<PersonModel> allPersons_Check = [];
  List<CheckWalletModel> allCheckWalletModel = [];
  List<InstallmentsModel> allInstallmentsModel = [];
  List checks_list = [];
  final String positiveBtnText = "حفظ";
  final String negativeBtnText = "إلفاء الأمر";
  final String title = "إضافة وارد جديد";
  int selectedIndex=0;
  int selected_checkWallet=0;
  int selected_installments=0;
  late final GestureTapCallback positiveBtnPressed;

  final _projectPersonName = GlobalKey<FormState>();
  final _projectName = GlobalKey<FormState>();
  final _projectCurrency = GlobalKey<FormState>();

  final TextEditingController _projecatName = TextEditingController();
  final TextEditingController _projectValue = TextEditingController();
  final TextEditingController _projectFirstPayment = TextEditingController();
  final TextEditingController _projectCheckNo = TextEditingController();
  final TextEditingController _projectPenfit = TextEditingController();
  final TextEditingController _projectTotalValue = TextEditingController();
  final currnceyList = ['شيكل', 'دولار', 'دينار'];
  String projectCurrency = "شيكل";
  String selectNameList = "";
  DateTime projectStartDate = DateTime.now();
  String projectName = "";
  String projecatName = "";
  double projectFirstPayment = 0;
  int projectCheckNo = 0;
  int projectPenfit = 0;
  double projectTotalValue = 0;
  double projectValue = 0;
  double totalTaqsset = 0;
  double onlyTaqsset = 0;

  void selecedtCurrnceyList() {
    projectCurrency = currnceyList[0];
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selecedtNameList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.focused,
    };
    const Set<MaterialState> interactiveStates1 = <MaterialState>{
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    if (states.any(interactiveStates1.contains)) {
      return Colors.grey;
    }
    return Colors.white;
  }
  @override
  Widget build(BuildContext context) {
    if (listPersons.isNotEmpty) selectNameList = listPersons[0];
    selecedtCurrnceyList();
    if (listPersons.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      selectNameList = listPersons[0];
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(context),
        ),
      );
    }
  }

  Widget _buildDialogContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                // Bottom rectangular box
                margin: const EdgeInsets.only(
                  top: 40,
                ), // to push the box half way below circle
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(
                  top: 45,
                  left: 12,
                  right: 12,
                ), // spacing inside the box
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      title,
                      style: CustomTheme.lightTheme.textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const TabBar(
                      //onTap:(_) => FocusManager.instance.primaryFocus?.unfocus(),
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.home,
                            color: Colors.black,
                            size:35,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.info,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 500,
                      child: GestureDetector(
                        onTap:(){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: TabBarView(
                          children: [
                            Container(
                              child: textEditFisrtPage(context),
                            ),
                            Container(
                              child: textEditSecondPage(context),
                            ),
                            Container(
                              child: textEditThirdPage(context),
                            ),
                          ],
                        ),
                      ),
                      //listTextEdit(context),
                      //  bottomButtns(context),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                // Top Circle with icon
                maxRadius: 40.0,
                child: Icon(
                  Icons.monetization_on_outlined,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // int _id = 1;
  // String _date = "21/12/2022";
  // int _person_id = 1;
  // String _person_name = 'بلال حرب';
  // int _project_id = 1;
  // String _project_type='مشاريع';
  // String _project_name= 'كلية الرباط الجامعية';
  // int _value = 300;
  // String _currency = "شيكل";
  // double _currencyValue = 1.0;
  // String _paymentMethod = "نقدي";
  // String _note = 'الصادر';
  Widget textEditFisrtPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        // Date
        TextButton(
          onPressed: () async {
            final date = await pickDate(context);
            if (date == null) return;
            // projectStartDate = date;
            setState(() => projectStartDate = date);
            // print(date);
          },
          child: SizedBox(
            height: 30,
            child: Row(
              children: [
                const Text(
                  'التاريخ  :  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${projectStartDate.year}/${projectStartDate.month}/${projectStartDate.day}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //  " صاحب المشروع"
        DropdownButtonFormField(
          key: _projectPersonName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 18,
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
            size:30,
          ),
          alignment: AlignmentDirectional.centerEnd,
          decoration: const InputDecoration(
            labelText: "  الاسم ",
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blue,
              size: 35,
            ),
          ),
          value: selectNameList,
          items: listPersons.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  minHeight: 48.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      e,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onTap: () {},
          onChanged: (val) {
            selectNameList = val as String;
          },
        ),
        const SizedBox(
          height: 20,
        ),

        //  " صاحب المشروع"
        DropdownButtonFormField(
          key: _projectName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 18,
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
            size:30,
          ),
          alignment: AlignmentDirectional.centerEnd,
          decoration: const InputDecoration(
            labelText: "  الاسم ",
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
            prefixIcon: Icon(
              Icons.work,
              color: Colors.blue,
              size: 35,
            ),
          ),
          value: selectNameList,
          items: listPersons.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  minHeight: 48.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      e,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onTap: () {},
          onChanged: (val) {
            selectNameList = val as String;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        // اسم المشروع
        TextFormField(
          controller: _projecatName,
          onEditingComplete: () {
            projecatName = _projecatName.text.toString();
          },
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 18,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.business,
              size: 30,
              color: Colors.blue,
            ),
            border: UnderlineInputBorder(),
            labelText: 'اسم المشروع',
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.always,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'يجب أن لا يكون فارغاً';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        //  "عملة المشروع"
        DropdownButtonFormField(
          key: _projectCurrency,
          alignment: AlignmentDirectional.center,
          value: projectCurrency,
          items: currnceyList.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      e,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (val) {
            projectCurrency = val as String;
          },
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
            size: 35,
          ),
          decoration: const InputDecoration(
            labelText: "عملة المشروع",
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
            prefixIcon: Icon(
              Icons.currency_exchange_sharp,
              color: Colors.blue,
              size: 30,
            ),
            //   contentPadding: EdgeInsets.only(top: 20),
          ),
        ),

        const SizedBox(
          height: 20,
        ),
        Flexible(
          flex: 4,
          child: Container(
            //color:Colors.green ,
            height: 100,
            alignment: Alignment.center,
            child: TextFormField(
              controller: _projectValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  projectValue = double.parse(value);
                  calculateTaqsset();
                }
              },
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.monetization_on,
                  size: 35,
                  color: Colors.blue,
                ),
                // border: UnderlineInputBorder(),
                labelText: 'قيمة المشروع',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                errorStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'يجب أن لا يكون فارغاً';
                }
                if (text.length < 2) {
                  return 'الرقم صغير يجب أن لا يقل عن 2';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget textEditSecondPage(BuildContext context) {
    // FocusManager.instance.primaryFocus?.hasFocus;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _projectFirstPayment,
          textDirection: TextDirection.rtl,
          onChanged: (value) {
            if (value.isNotEmpty) {
              projectFirstPayment = double.parse(value);
              calculateTaqsset();
            }
          },
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 18,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.money_outlined,
              size: 30,
              color: Colors.blue,
            ),
            // border: UnderlineInputBorder(),
            labelText: 'قيمة الدفعة الأولى',
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          autovalidateMode: AutovalidateMode.always,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'يجب أن لا يكون فارغاً';
            }
            if (text.length < 2) {
              return 'الرقم صغير يجب أن لا يقل عن 2';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _projectCheckNo,
          onChanged: (value) {
            setState(() {
              if (value.isNotEmpty) {
                projectCheckNo = int.parse(value);
                // print(value);
                calculateTaqsset();
              }
            });
          },
          textDirection: TextDirection.rtl,
          onEditingComplete: () {
            projectCheckNo = _projectCheckNo.text as int;
          },
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 18,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.numbers,
              size: 30,
              color: Colors.blue,
            ),
            // border: UnderlineInputBorder(),
            labelText: 'عدد الدفعات',
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          autovalidateMode: AutovalidateMode.always,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'يجب أن لا يكون فارغاً';
            }
            if (text.length > 3) {
              return 'الرقم  يجب أن لا يزيد عن 3';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _projectTotalValue,
          readOnly: true,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 18,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.golf_course,
              size: 30,
              color: Colors.blue,
            ),
            // border: UnderlineInputBorder(),
            labelText: 'مبلغ الكلي للمشروع',
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          autovalidateMode: AutovalidateMode.always,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'يجب أن لا يكون فارغاً';
            }
            return null;
          },
        ),
        Divider(),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20,left: 20),
          child: TextButton(onPressed: (){},
            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue) ,
                foregroundColor: MaterialStateProperty.all(Colors.white)
            ),
            child:
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text('احفظ المشروع',
                  style:TextStyle(color:Colors.white,fontSize: 20) ,
                ),
                Icon(Icons.save_outlined,
                  size: 30,)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget textEditThirdPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        IconButton(
          onPressed: () {},
          color: Colors.green,
          icon: const Icon(Icons.save_as_sharp),
        ),
        taqssetList(context),
      ],
    );
  }

  Widget bottomButtns(BuildContext context) {
    return ButtonBar(
      buttonMinWidth: 100,
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton(
          child: Text(
            negativeBtnText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          onPressed: () {
            DbPerson dbPerson = DbPerson();
            dbPerson.addPersons(_projecatName.text, _projectCurrency.toString());
            IncomeAddDialog positiveBtnPressed;
            Navigator.of(context).pop();
          },
          child: Text(
            positiveBtnText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget taqssetList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(5),
          shrinkWrap: true,
          itemCount: projectCheckNo,
          itemBuilder: (context, i) {
            DateTime date = DateTime(projectStartDate.year,
                projectStartDate.month + i + 1, projectStartDate.day);
            Map <String,dynamic> ob={
              "installment_id":1,
              "installment_type" : 'المشاريع',
              "installment_type_id" : "1",
              "installment_date" : "${date.day}/${date.month}/${date.year}",
              "installment_kind" : "شيك",
              "installment_value" : '$onlyTaqsset',
              "installment_currency" :projectCurrency,
              "installment_meritDate" : "${date.day}/${date.month}/${date.year}",
              "installment_payed" : 'لا',
              "installment_picutre" : "mohamed",
            };
            InstallmentsModel Installment= InstallmentsModel(ob) ;
            allInstallmentsModel.add(Installment);
            return Card(
              color: Colors.cyan,
              elevation: 3,
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 27,
                              color: Colors.pinkAccent,
                            ),
                            onPressed: () {
                              checkWallet(context);
                              selected_installments=i;
                            },
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_forever_sharp,
                              size: 27,
                              color: Colors.amberAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                " المبلغ المقدر :",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              Text(
                                "$onlyTaqsset",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              Text(
                                " $projectCurrency ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Text(
                                "  التاريخ المستحق :",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              Text(
                                '${date.year}/${date.month}/${date.day}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future checkWallet(BuildContext context) {
    selecedtChecksList();
    return
      showModalBottomSheet(
        backgroundColor: const Color.fromARGB(255, 206, 204, 204),
        context: context,
        builder: (ctx) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Expanded(
              child:FutureBuilder<String>(
                future: _loadData(),
                initialData: 'Loading',
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData && snapshot.data == 'Loading') {
                    return _buildIndicator();
                  } else {
                    return  _LVListChecks();
                  }
                },
              ),
            ),
          ],
        ),
      );
  }

  Future<String> _loadData() async {
    // Specifies the indicator's duration / delay
    await Future.delayed(const Duration(seconds: 2));
    return Future<String>.value('Loaded');
  }
  Widget _buildIndicator() {
    return const Center(
      child: CircularProgressIndicator(
          color:Colors.blue,
          backgroundColor: Colors.black26,
          semanticsLabel:"انتظر حتى يكتمل التحميل"
      ),
    );
  }

  Widget _LVListChecks()  {
    return ListView.builder(
      // controller: controller,
      itemCount: allCheckWalletModel.length,
      itemBuilder:  (context,index)=>GestureDetector(
        onTap:(){
          setState(() {
            selectedIndex=index;
          });
        } ,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(left:8,right:8,top:2,bottom:2),
            child:
            CardList(index),
          ),
        ),
      ),
    );
  }

  Widget CardList (int index){
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            Card(
              color:Colors.pink[200],
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CheckList_Value(index),
                        Text(
                          allCheckWalletModel[index].type,
                          style: CustomTheme.lightTheme.textTheme.bodyText1,
                        ),
                        Text(
                          " رقمه: ${allCheckWalletModel[index].no} ",
                          style: CustomTheme.lightTheme.textTheme.bodyText1,
                        ),
                        Text(
                          "  من : ${allPersons_Check[index].name} ",
                          style: CustomTheme.lightTheme.textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("  التاريخ : ${allCheckWalletModel[index].date}",
                          style: CustomTheme.lightTheme.textTheme.bodyText1,),
                      ],
                    ),
                    Row(
                      children: [
                        Text("  تاريخ الاستحقاق: ${allCheckWalletModel[index].exdate}",
                          style: CustomTheme.lightTheme.textTheme.bodyText1,),
                      ],
                    ),
                    Row(
                      children: [
                        Text("  القيمة :${allCheckWalletModel[index].value}  ${allCheckWalletModel[index].currency} ",
                          style: CustomTheme.lightTheme.textTheme.bodyText1,)
                      ],
                    ),
                  ],
                ),
              ),
            );
        }
    );
  }
  Widget CheckList_Value(int index) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Center(
            child:
            Checkbox(
              value: checks_list[index],
              checkColor:Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  selectedIndex=index;
                  checks_list[index]=value;
                  allInstallmentsModel[selectedIndex].type_id=allCheckWalletModel[selectedIndex].id as String;
                  allInstallmentsModel[selectedIndex].type='المشاريع';
                  allInstallmentsModel[selectedIndex].date=allCheckWalletModel[selectedIndex].date;
                  allInstallmentsModel[selectedIndex].kind=allCheckWalletModel[selectedIndex].type;
                  allInstallmentsModel[selectedIndex].value=allCheckWalletModel[selectedIndex].value as String;
                  allInstallmentsModel[selectedIndex].currency=allCheckWalletModel[selectedIndex].currency;
                  allInstallmentsModel[selectedIndex].meritDate=allCheckWalletModel[selectedIndex].exdate;
                  allInstallmentsModel[selectedIndex].payed=allCheckWalletModel[selectedIndex].done;
                  allInstallmentsModel[selectedIndex].picutre=allCheckWalletModel[selectedIndex].picture;
                  allInstallmentsModel[selectedIndex].installment_checkWallent_id=allCheckWalletModel[selectedIndex].id as String;
                  Navigator.pop(context);
                });
              },
            ),
          );
        });
  }
  void calculateTaqsset() {
    if (projectCheckNo > 0) {
      if (projectCheckNo >= 6 && projectCheckNo <= 12) {
        projectPenfit = 10;
      } else if (projectCheckNo >= 13 && projectCheckNo <= 36) {
        projectPenfit = 25;
      } else if (projectCheckNo >= 37 && projectCheckNo <= 60) {
        projectPenfit = 53;
      }
      if (projectValue > 0) {
        projectTotalValue = projectValue * (1 + (projectPenfit / 100));
        projectTotalValue = double.parse(projectTotalValue.toStringAsFixed(2));
        _projectTotalValue.text = "$projectTotalValue";
        if (projectFirstPayment > 0) {
          totalTaqsset = projectTotalValue - projectFirstPayment;

          onlyTaqsset = totalTaqsset / projectCheckNo;
          onlyTaqsset = double.parse(onlyTaqsset.toStringAsFixed(2));
        }
      }
    }
  }

  Future<DateTime?> pickDate(context) {
    return showDatePicker(
      context: context,
      initialDate: projectStartDate,
      firstDate: DateTime(2017),
      lastDate: DateTime(2220),
    );
  }
  Future<void> selecedtChecksList() async {
    DbCheckWallet dbCheckWallet = DbCheckWallet();
    allPersons_Check.clear();
    allCheckWalletModel.clear();
    checks_list.clear();
    dbCheckWallet.allCheckWalletNotEnded().then((checks) {
      for (var item in checks) {
        checks_list.add(false) ;
        CheckWalletModel check = CheckWalletModel.fromMap(item);
        PersonModel person= PersonModel.fromMap(item);
        allCheckWalletModel.add(check);
        allPersons_Check.add(person);
      }
    });
  }
  Future<void> selecedtNameList() async {
    DbPerson dbPerson = DbPerson();
    dbPerson.allPersons().then((persons) {
      for (var item in persons) {
        PersonModel person = PersonModel.fromMap(item);
        //print(person);
        setState(() {
          listPersons.add(person.name.toString());
        });
      }
    });
  }
}