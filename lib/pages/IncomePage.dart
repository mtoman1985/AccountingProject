import 'package:belal_pro/db/dbincome.dart';
import 'package:belal_pro/db/dbproject.dart';
import 'package:belal_pro/dialog/income_add_dialog.dart';
import 'package:belal_pro/model/ProjectModel.dart';
import 'package:belal_pro/model/incomeModel.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:belal_pro/db/dbperson.dart';
import 'package:belal_pro/dialog/project_add_dialog.dart';
import 'package:belal_pro/model/PersonModel.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:ui' as ui;
class IncomePage extends StatefulWidget{
  const IncomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IncomePageState();
  }
}
class IncomePageState extends State<IncomePage>{
  DbIncome dbIncome  = DbIncome();
  List<IncomeModel> allIncoms = [];
  List<IncomeModel> items = [];
  List<PersonModel?> allPersons = [];
  List<ProjectModel> allProjects = [];
  late FocusNode myFocusNode;
  Color backGroundMsgs = Colors.black;
  List<Color> backGroundMsgsList = [];
  List<String> personsNames = [];

  // Future _onRefresh() async {
  //   dbIncome = DbIncome();
  //   try {
  //     await Future.delayed(const Duration(seconds: 3));
  //     setState(() {
  //       initState;
  //     });
  //   } catch (e) {
  //   }
  // }

  @override
  void initState() {
    super.initState();
    dbIncome = DbIncome();
    myFocusNode = FocusNode();
    setState(() {
      backGroundMsgsList = [];
      items = [];
    });
    dbIncome.allIncome().then((incomes) {
      for (var item in incomes) {
        setState(() {
          IncomeModel income = IncomeModel.fromMap(item);
          addProjectNameToListVeiw(income.project_id);
          addPersonNameToListVeiw(income.person_id);
          allIncoms.add(income);
          backGroundMsgsList.add(backGroundMsgs);
        });
      }
      items.addAll(allIncoms);
    });
  }


  void addPersonNameToListVeiw(int id) {
    DbPerson dbPerson = DbPerson();
    dbPerson.searchPersonById(id).then((persons) {
      for (var item in persons) {
        PersonModel person = PersonModel.fromMap(item);
        allPersons.add(person);
      }
    });
  }

  PersonModel? addPersonNameToList(int id) {
    DbPerson dbPerson = DbPerson();
    dbPerson.searchPersonById(id).then((persons) {
      return PersonModel.fromMap(persons.first);
    });
  }
  void addProjectNameToListVeiw(int id) {
    DbProject dbProject = DbProject();
    dbProject.searchProjectById(id).then((projects) {
      for (var item in projects) {
        ProjectModel projectModel = ProjectModel.fromMap(item);
        allProjects.add(projectModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'صفحة الوارد',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
              InkWell(
              onTap: () {
                items.sort((a, b) => a.person_name.compareTo(b.person_name));
                int i =0;
                items.map((e) {
                  allPersons[i]=addPersonNameToList(e.person_id);
                  i++;
                  addProjectNameToListVeiw(e.project_id);
                } );
              }, // Handle your callback.
              splashColor: Colors.brown.withOpacity(0.5),
              child: Ink(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit:BoxFit.contain,
                    image: AssetImage('assets/icon/alphabetical_sorting.png'),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.sort_by_alpha,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                items.sort((a, b) => a.date.compareTo(b.date));
                int i =0;
                items.map((e) {
                  allPersons[i]=addPersonNameToList(e.person_id);
                  // allPersons.indexOf(person)= addPersonNameToList(e.person_id);
                  i++;
                  addProjectNameToListVeiw(e.project_id);
                } );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return IncomeAddDialog(
                        title: "إضافة وارد جديد ",
                        positiveBtnText: "حفظ",
                        negativeBtnText: "إلفاء الأمر",
                        positiveBtnPressed: () {}
                    );
                  }),
            ),

          ],
        ),
        body: projectPageContent(context),
      ),
    );
  }

  Widget projectPageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5, left: 5),
      child: FutureBuilder<String>(
        future: _loadData(),
        initialData: 'Loading',
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData && snapshot.data == 'Loading') {
            return _buildIndicator();
          } else {
            return incomeListView();
          }
        },
      ),
    );
  }

  Future<String> _loadData() async {
    // Specifies the indicator's duration / delay
    await Future.delayed(const Duration(seconds: 3));
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


  Widget incomeListView() {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async{
              await Future.delayed(const Duration(seconds: 3));
              setState(() {

              });
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, i) {
                  IncomeModel income = items[i];
                  print (items);
                  return Dismissible(
                    background: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: ColoredBox(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                            EdgeInsets.only(top: 10.0, bottom: 10, right: 30),
                            child: Icon(
                              Icons.delete, //add to home screen
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    secondaryBackground: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: ColoredBox(
                        color: Colors.green,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.edit, //add to home screen
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    key: UniqueKey(),
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('هل أنت متأكد من الحذف '),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text(
                                    'لا',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      items.removeAt(i);
                                      dbIncome.deleteIncome(income.id);
                                      backGroundMsgsList.removeAt(i);
                                    });

                                    Navigator.pop(context, true);
                                  },
                                  child: const Text(
                                    'نعم',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else if (direction == DismissDirection.endToStart) {
                        //  _callNumber(person.mobile.toString());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 3,
                      ),
                      child: ExpansionTileCard(
                        elevation: 10,
                        baseColor: const Color.fromARGB(255, 240, 240, 241),
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.green,
                          child: Image.asset(
                            "assets/icon/receiving.png",
                            height: 35,
                            width: 35,
                            color: Colors.white,
                          ),
                        ),
                        title: Column(
                          children: [
                            Text(
                              income.person_name,
                              style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.pink,),
                            ),
                            Text(
                              income.date,
                              style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.pink,),
                            ),Text(
                              ' ${income.value.toString()}  ${income.currency}',
                              style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.pink,),
                            ),Text(
                              income.paymentMethod,
                              style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.pink,),
                            ),
                          ],
                        ),
                        // subtitle:
                        children: <Widget>[
                          const Divider(
                            thickness: 3.0,
                            height: 3.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 3.0,
                              right: 6.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    // color: Colors.grey[100],
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'قيمة تحويل العملة إلى الشيكل: ',
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown,),
                                            ),
                                            Text(
                                              ' ${income.currencyValue.toString()}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              '  القيمةالكلية بالشيكل: ',
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown),
                                            ),
                                            Text(
                                              ' ${income.value*income.currencyValue} شيكل ',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              ' الملاحظات:  ',
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown),
                                            ),
                                            Expanded(
                                              child: Text(
                                                ' ${income.note.toString()}',
                                                style: const TextStyle(fontSize: 16),
                                                maxLines: 4,
                                                overflow: TextOverflow.clip,
                                                textDirection: TextDirection.rtl,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  bool isPermmission = false;
  listenForPermissionStatus() async {
    // PermissionStatus status1 = await Permission.storage.request();
    if (await Permission.storage.request().isGranted) {
      isPermmission = true;
      //print("Permission is true");
    } else {
      isPermmission = false;
      // print("Permission is false");
      listenForPermissionStatus();
    }
  }

}