import 'dart:async';
import 'package:belal_pro/db/dbinstallment.dart';
import 'package:belal_pro/global_var/globals.dart';
import 'package:belal_pro/pages/IncomePage.dart';
import 'package:belal_pro/pages/PersonsPage.dart';
import 'package:belal_pro/db/dbhelper.dart';
import 'package:belal_pro/pages/projectPage.dart';
import 'package:belal_pro/utils.dart';
import 'package:flutter/material.dart';
import 'package:belal_pro/global_var/globals.dart' as global;
import 'package:intl/intl.dart' as tt;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
//import 'package:shared_preferences/shared_preferences.dart';
int rt = 0;
GlobalKey hhh = GlobalKey();
final mainKey = GlobalKey();
//final prefs = SharedPreferences.getInstance();

List<DateTime> Calnder_dates = [];
List<Object?> Calnder_count_Dates = [];
DbInstallment dbInstallment = DbInstallment();

Future<void> main() async {
  runApp(const MyApp());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("maxNoPic") == false) {
    prefs.setInt("maxNoPic", 1);
  }
}

void Calnder_Data() {
  dbInstallment.adteInstallment_count().then((counts) {
    for (var item in counts) {
      item.forEach((key, value) {
        if (key == "Sets_date") {
          Calnder_count_Dates.add(value);
          print(value);
        }
        if (key == "installment_date") {
          String theDate = value as String;
          DateTime theDateDa = tt.DateFormat("dd/MM/yyyy").parse(theDate);
          print(theDateDa);
          Calnder_dates.add(theDateDa);
        }
      });
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _Home();
}

class _Home extends State<MyHomePage> {
  
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    setState(() {
      Calnder_Data();
      getNotificationDate(Calnder_dates, Calnder_count_Dates);
    });

    helper = DbHelper();
    creatExtFolder("db");
    creatExtFolder("pic");
    creatExtFolder("files");
    Timer.periodic(const Duration(seconds: 5), (Timer t) => Calnder_Data());
  }

  late DbHelper helper;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: ((context, setState) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          //endDrawer: drawing(context),
          drawer: drawing(context),
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: const Text("برنامج الحسابات"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const PersonsPage())), // => Navigator.pop(context, _selectedGratitude)
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: global.ispressed ? Colors.white : Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  setState(() => global.ispressed = !global.ispressed);
                }, 
              ),
            ],
          ),
          body: Center(
            child: myWidget(context),
          ),
        ),
      );
    }));
  }

  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  Widget table_Calender(BuildContext context) {
    return TableCalendar<Event>(
      //colorMohamed: 2,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      eventLoader: _getEventsForDay,
      startingDayOfWeek: StartingDayOfWeek.saturday,
      selectedDayPredicate: (day) {
        // Use values from Set to mark multiple days as selected
        return _selectedDays.contains(day);
      },
      onDaySelected: _onDaySelected,
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  Widget table_Details(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Event>>(
        valueListenable: _selectedEvents,
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    //print('${value[index]}');
                  },
                  title: Text(
                    ' شيك رقم ${value[index]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _refreshDataCalender(BuildContext context) async {
    return getNotificationDate(Calnder_dates, Calnder_count_Dates);
  }

  @override
  Widget myWidget(BuildContext context) {
    return Column(
      children: [
        RefreshIndicator(
          onRefresh: () => _refreshDataCalender(context),
          child: FutureBuilder<String>(
            future: _loadData(),
            //initialData: 'Loading',
            builder: (context, snapshot) {
              if (Calnder_count_Dates.isNotEmpty) {
                getNotificationDate(Calnder_dates, Calnder_count_Dates);
                return table_Calender(context);
              } else {
                return const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.start, //Center Row contents vertically,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.calendar_today,
                  size: 35.0,
                  color: Colors.blue,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime.now();
                    _onDaySelected;
                  });
                },
              ),
              ElevatedButton(
                child: const Text(' امسح التحديدات'),
                onPressed: () {
                  setState(() {
                    _selectedDays.clear();
                    _selectedEvents.value = [];
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        table_Details(context),
      ],
    );
  }
}

Future<String> _loadData() async {
  // Specifies the indicator's duration / delay

  await Future.delayed(const Duration(seconds: 3));
  if (Calnder_count_Dates.isEmpty) {
    Calnder_Data();
    getNotificationDate(Calnder_dates, Calnder_count_Dates);
    return Future<String>.value('Not Loaded');
  } else {
    return Future<String>.value('Loaded');
  }
}

@override
Widget drawing(BuildContext context) {
  return Drawer(
    elevation: 10.0,
    child: ListView(children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
        ),
        child: Center(
          child: Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 95, 95, 95),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9,
                ],
                colors: [
                  Color.fromARGB(255, 90, 86, 55),
                  Colors.red,
                  Colors.indigo,
                  Colors.teal,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(55.0)),
            ),
            child: const Center(
              child: CircleAvatar(
                // radius: 10,
                radius: 50,
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ),
      ),
      ListTile(
        title: const Text(
          'العملاء',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        leading: const Icon(
          Icons.person,
          size: 35,
          color: Colors.blue,
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PersonsPage()));
          // Then close the drawer
          //Navigator.pop(context);
        },
      ),
      const Divider(
        thickness: 2,
      ),
      ListTile(
        title: const Text(
          'المشاريع',
          style: TextStyle(
            fontSize: 25,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/buildings.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectPage()));
        },
      ),
      ListTile(
        title: const Text(
          'الأضاحي',
          style: TextStyle(
            fontSize: 25,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/cow.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectPage()));
        },
      ),
      ListTile(
        title: const Text(
          'الجولات',
          style: TextStyle(
            fontSize: 25,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/phone.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectPage()));
        },
      ),
      ListTile(
        title: const Text(
          'الألمونيوم',
          style: TextStyle(
            fontSize: 23,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/window.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectPage()));
        },
      ),
      const Divider(
        thickness: 2,
      ),
      ListTile(
        title: const Text(
          'الشيكات و الكمبيالات',
          style: TextStyle(
            fontSize: 23,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/cheque.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectPage()));
        },
      ),
      ListTile(
        title: const Text(
          'الجمعيات',
          style: TextStyle(
            fontSize: 23,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/money.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectPage()));
        },
      ),
      const Divider(
        thickness: 2,
      ),
      ListTile(
        title: const Text(
          'الصرف',
          style: TextStyle(
            fontSize: 23,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/pay.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => IncomePage()));
        },
      ),
      ListTile(
        title: const Text(
          'الإيداع',
          style: TextStyle(
            fontSize: 23,
            color: Colors.blue,
          ),
        ),
        leading: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/saving.png",
            width: 45,
            height: 45,
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const IncomePage()));
        },
      ),
    ]),
  );
}

/*
  Future<DateTime?> pickDate() {
    return showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2220),
    );
  }

  Future<TimeOfDay?> pickMin() {
    return showTimePicker(
      context: context,
      initialTime:
      TimeOfDay(hour: currentTime.hour, minute: currentTime.minute),
    );
  }*/

/*

class bottmAppBar extends StatefulWidget {
  const bottmAppBar({super.key});

  @override
  State<bottmAppBar> createState() => _bottmAppBarState();
}

class _bottmAppBarState extends State<bottmAppBar> {
  void incrementQuantity(int order) {
    setState(() {
      global.selectedButton = order;
      rt = order;
      //mainKey.currentState.initState()

      // print(hhh.currentWidget.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue.shade200,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(global.bottmButton[0]),
            color: Colors.white,
            onPressed: () {
              incrementQuantity(0);
              // setState(() {
              //   global.selectedButton = 0;
              // });
            },
          ),
          IconButton(
            icon: Icon(global.bottmButton[1]),
            color: Colors.white,
            onPressed: () {
              incrementQuantity(1);
              // setState(() {
              //   global.selectedButton = 1;
              // });
            },
          ),
          IconButton(
            icon: Icon(global.bottmButton[2]),
            color: Colors.white,
            onPressed: () {
              incrementQuantity(2);
              // setState(() {
              //   global.selectedButton = 2;
              // });
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class bottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue.shade200,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(global.bottmButton[0]),
            iconSize: 20,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PersonsPage(),
                ),
              );

              // Navigator.pop(context, Persons);
              global.selectedButton = 0;
              //   });
            },
          ),
          IconButton(
            icon: Icon(global.bottmButton[1]),
            color: Colors.white,
            onPressed: () {
              global.selectedButton = 1;
            },
          ),
          IconButton(
            icon: Icon(global.bottmButton[2]),
            color: Colors.white,
            onPressed: () {
              global.selectedButton = 2;
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
*/
