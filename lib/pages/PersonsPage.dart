import 'package:belal_pro/db/dbperson.dart';
import 'package:belal_pro/dialog/message_send.dart';
import 'package:belal_pro/model/PersonModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:belal_pro/dialog/person_add_dialog.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({super.key});
  @override
  _PersonsPage createState() => _PersonsPage();
}

class _PersonsPage extends State<PersonsPage> {
  DbPerson dbPerson = DbPerson();
  TextEditingController teSeach = TextEditingController();
  TextEditingController texMassege = TextEditingController();
  List<PersonModel> allPersons = [];
  List<PersonModel> items = [];
  var allPersonsVar = [];
  List<PersonModel> dummySearchList = [];
  late FocusNode myFocusNode;
  Color backGroundMsgs = Colors.black;
  List<Color> backGroundMsgsList = [];

  Future<Null> _onRefresh() async {
    dbPerson = DbPerson();
    try {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        initState;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    dbPerson = DbPerson();
    myFocusNode = FocusNode();
    setState(() {
      backGroundMsgsList = [];
      items = [];
    });
    dbPerson.allPersons().then((persons) {
      for (var item in persons) {
        setState(() {
          PersonModel person = PersonModel.fromMap(item);
          allPersons.add(person);
          backGroundMsgsList.add(backGroundMsgs);
        });
      }
      items.addAll(allPersons);
    });
  }

  void filterSeach(String? query) async {
    dummySearchList = [];
    setState(() {
      dbPerson.searchingPersons(query!).then((persons) {
        persons!.then((ee) {
          for (var item in ee) {
            // print(item);
            dummySearchList.add(PersonModel.fromMap(item));
          }
          items = [];
          items.addAll(dummySearchList);
        });
      });
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'صفحة العملاء',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 6,
                left: 4,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (recipents.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MessageSend(
                              title: "  إرسال رسالة ",
                              positiveBtnText: "إرسال الرسائل",
                              negativeBtnText: "إلفاء الأمر",
                              positiveBtnPressed: () {
                                _send();
                                // print(recipents);
                                imptyMsList();
                                Navigator.of(context).pop();
                              },
                            );
                          });
                      // showBottomSheet(
                      //       enableDrag: false,
                      //       context: context,
                      //       builder: (context) {
                      //         return GestureDetector(
                      //             child: Center(
                      //           child: ElevatedButton(
                      //             onPressed: () {},
                      //             child: const Text("hhhh"),
                      //           ),
                      //         ));
                      //       });
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 6,
                left: 4,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return PersonAddDialog(
                        title: "إضافة عميل جديد",
                        positiveBtnText: "حفظ",
                        negativeBtnText: "إلفاء الأمر",
                        positiveBtnPressed: () {},
                      );
                    }),
              ),
            ),
          ],
        ),
        body: personPageContent(context),
      ),
    );
  }

  Widget personPageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5, left: 5),
      child: Column(
        children: [
          personSearhName(),
          personListView(),
        ],
      ),
    );
  }

  Widget personSearhName() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          setState(() {
            filterSeach(value);
            //print(helper.searchingPersons(value));
          });
        },
        controller: teSeach,
        focusNode: myFocusNode,
        autofocus: true,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'البحث بالاسم ...',
          hintStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          labelText: 'البحث',
          prefixIcon: Icon(
            color: Color.fromARGB(255, 47, 47, 47),
            Icons.search,
            size: 30,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    );
  }

  Widget personListView() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, i) {
              PersonModel person = items[i];
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
                          Icons.add_to_home_screen, //add to home screen
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
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('هل أنت متأكد من حذف العميل'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text(
                                'لا',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  items.removeAt(i);
                                  dbPerson.deletePerson(person.id);
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
                    _callNumber(person.mobile.toString());
                  }
                },
                // onDismissed: (direction) {
                //   //swiped left
                //   if (direction == DismissDirection.startToEnd) {
                //     // setState(() {
                //     //   items.removeAt(i);
                //     //   helper.deletePerson(person.id);
                //     //   backGroundDissmis = Colors.red;
                //     // });
                //   } //swiped rigth
                //   else if (direction == DismissDirection.endToStart) {
                //     _callNumber(person.mobile.toString());
                //     setState(() {
                //       backGroundDissmis = Colors.green;
                //     });
                //   }
                // },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 23,
                      backgroundColor: Color.fromARGB(255, 114, 114, 114),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      person.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text('رقم الموبايل :  ${person.mobile}'),
                    trailing: SizedBox(
                      width: 90,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              //isSelected:,
                              icon: Icon(
                                Icons.message,
                                color: backGroundMsgsList[i],
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (backGroundMsgsList[i] == Colors.black) {
                                    backGroundMsgsList[i] = Colors.green;
                                    backGroundMsgs = backGroundMsgsList[i];
                                    recipents.add(person.mobile.toString());
                                  } else {
                                    backGroundMsgsList[i] = Colors.black;
                                    backGroundMsgs = backGroundMsgsList[i];
                                    recipents.remove(person.mobile);
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                _callNumber(person.mobile.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  String message = "This is a test message!";
  List<String> recipents = [];
  Future<void> _sendSMS(String message, List<String> recipents) async {
    final permission = Permission.sms.request();
    if (await permission.isGranted) {
      try {
        String _result = await sendSMS(
          message: message,
          recipients: recipents,
          sendDirect: true,
        );
        //   setState(() => message = _result);
      } catch (error) {
        //  setState(() => message = error.toString());
      }
    }
  }

  void _send() {
    _sendSMS(message, recipents);
  }

  _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  void imptyMsList() {
    setState(() {
      recipents = [];
      for (int x = 0; x < backGroundMsgsList.length; x++) {
        backGroundMsgsList[x] = Colors.black;
      }
    });
  }
}

class _massgeSender {
  //  scaffoldKey.currentState!.showBottomSheet((context) {
  //                     return SizedBox(
  //                       height: 200,
  //                       width: double.infinity,
  //                       child: Column(
  //                         children: [
  //                           TextField(
  //                             maxLines: 4,
  //                             style: const TextStyle(
  //                               fontSize: 22,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             onChanged: (value) {
  //                               setState(() {
  //                                 filterSeach(value);
  //                                 //print(helper.searchingPersons(value));
  //                               });
  //                             },
  //                             controller: texMassege,
  //                             focusNode: myFocusNode,
  //                             autofocus: true,
  //                             decoration: const InputDecoration(
  //                               labelStyle: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                               hintText: 'اكتب الرسالة هنا  ...',
  //                               hintStyle: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                               labelText: 'الرسالة ',
  //                               // prefixIcon: Icon(
  //                               //   color: Color.fromARGB(255, 47, 47, 47),
  //                               //   Icons.search,
  //                               //   size: 30,
  //                               // ),
  //                               border: OutlineInputBorder(
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(25)),
  //                               ),
  //                             ),
  //                           ),
  //                           ElevatedButton(
  //                             onPressed: () {
  //                               _send();
  //                               // print(recipents);
  //                               imptyMsList();
  //                             },
  //                             child: const Text("ارسل الرسالة "),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   });
}
