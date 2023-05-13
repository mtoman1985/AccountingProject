import 'dart:convert';
import 'dart:io';
import 'package:belal_pro/db/dbbuilding.dart';
import 'package:belal_pro/db/dbperson.dart';
import 'package:belal_pro/dialog/project_add_dialog.dart';
import 'package:belal_pro/main.dart';
import 'package:belal_pro/db/dbpicture.dart';
import 'package:belal_pro/global_var/globals.dart';
import 'package:belal_pro/db/dbproject.dart';
import 'package:belal_pro/dialog/person_add_dialog.dart';
import 'package:belal_pro/model/PersonModel.dart';
import 'package:belal_pro/model/PictureModel.dart';
import 'package:belal_pro/model/BuildingModel.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'package:sqflite/sqflite.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});
  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  DbBuilding dbBuilding = DbBuilding();
  DbPicture dbPicutre = DbPicture();
  List<BuildingModel> allProjects = [];
  List<BuildingModel> items = [];
  List<String> allPicture = [];
  late Map<int, dynamic> itemsPicture = {};
  var allPersonsVar = [];
  List<BuildingModel> dummySearchList = [];
  late FocusNode myFocusNode;
  Color backGroundMsgs = Colors.black;
  List<Color> backGroundMsgsList = [];
  XFile? imageFile;
  Image? img;
  List imageList = [];
  int maxNoPic = 0;
  var numberFormat = NumberFormat("000000", "en_US");
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var prefs;
  List<String> allPersons = [];
  List<String> personsNames = [];

  Future _onRefresh() async {
    dbBuilding = DbBuilding();
    try {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        initState;
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //listenForPermissionStatus();
    selecedtNameList();
    dbBuilding = DbBuilding();
    myFocusNode = FocusNode();
    initial();
    setState(() {
      backGroundMsgsList = [];
      items = [];
    });
    dbBuilding.allBuildings().then((projects) {
      for (var item in projects) {
        setState(() {
          BuildingModel project = BuildingModel.fromMap(item);
          allProjects.add(project);
          findPicture(project.projectId);
          backGroundMsgsList.add(backGroundMsgs);
        });
      }
      items.addAll(allProjects);
    });

  }

  void initial() async {
    prefs = await _prefs;
    setState(() {
      maxNoPic = prefs.getInt('maxNoPic') ?? 1;
    });
  }

  findPicture(int index) {
    allPicture = [];
    dbPicutre
        .searchPictureByProject(index.toString(), "project")
        .then((pictureItems) {
      for (var item in pictureItems!) {
        setState(() {
          PictureModel picture = PictureModel.fromMap(item);
          allPicture.add(picture.pictureName);
        });
      }
      itemsPicture.addAll({index: allPicture});
    });
  }

  void selecedtNameList() {
    DbPerson dbPerson = DbPerson();
    dbPerson.allPersons().then((persons) {
      for (var item in persons) {
        PersonModel person = PersonModel.fromMap(item);
        print (person);
        allPersons.add(person.name.toString());
      }
      personsNames.addAll(allPersons);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'صفحة المشاريع',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return ProjectAddDialog(
                      title: "إضافة مشروع جديد",
                      positiveBtnText: "حفظ",
                      negativeBtnText: "إلفاء الأمر",
                        personNmae:allPersons,
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
            return projectListView();
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


  Widget projectListView() {
    final GlobalKey<ExpansionTileCardState> cardProject = GlobalKey();
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Column(
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      BuildingModel Building = items[i];
                      imageList = itemsPicture[Building.projectId];
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
                            await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('هل أنت متأكد من حذف المشروع'),
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
                                          dbBuilding.deleteProject(Building.projectId);
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
                            elevation: 5,
                            baseColor: const Color.fromARGB(255, 240, 240, 241),
                            //  expandedColor: Colors.red[50],
                            key: cardProject,
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.green,
                              child: Image.asset(
                                "assets/icon/buildings.png",
                                height: 35,
                                width: 35,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              Building.projectName,
                              style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.pink,),
                            ),
                           // subtitle:
                            children: <Widget>[
                              const Divider(
                                thickness: 2.0,
                                height: 2.0,
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
                                      Container(
                                       // color: Colors.grey[100],
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 40,
                                              color:Colors.grey[200],
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                            children: [
                                                  IconButton( icon: const Icon(
                                                    Icons.monetization_on_outlined,
                                                    color: Colors.teal,
                                                    size:35,
                                                  ), padding: const EdgeInsets.all(2.0), onPressed: () {  },
                                                  ),
                                                  const Text(
                                                    ' المعلومات المالية',
                                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange,),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  ' قيمة المشروع الكلية: ',
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown,),
                                                ),
                                                Text(
                                                  ' ${Building.projectValue.toString()}  ${Building.projectCurrency}',
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  ' الدفعة الأولى: ',
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown),
                                                ),
                                                Text(
                                                  ' ${Building.projectFirstPayment.toString()}  ${project.projectCurrency}',
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'عددأشهر الأقساط:  ',
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown),
                                                ),
                                                Text(
                                                  ' ${Building.projectCheckNo.toString()}',
                                                  style: const TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  ' نسبة الأرباح:',
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown),
                                                ),
                                                Text(
                                                  ' ${Building.projectPenfit.toString()} %',
                                                  style: const TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  ' مبلغ الربح: ',
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown,),
                                                ),
                                                Text(
                                                  ' ${((Building.projectPenfit / 100)) * Building.projectValue}  ${project.projectCurrency}',
                                                  style: const TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'المبلغ الكلي مع الأرباح :',
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.brown),
                                                  overflow: TextOverflow.clip, // default is .clip
                                                  maxLines: 2,// default is 1
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '  ${((Building.projectPenfit / 100) + 1) * Building.projectValue}  ${project.projectCurrency}',
                                                    style: const TextStyle(fontSize: 16),
                                                    //textAlign: TextAlign.right,
                                                    overflow: TextOverflow.fade, // default is .clip
                                                    maxLines: 2,// default is 1
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        thickness: 1,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 40,
                                        color:Colors.grey[200],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            IconButton( icon: const Icon(
                                              Icons.party_mode_rounded,
                                              color: Colors.teal,
                                              size:35,
                                            ), padding: const EdgeInsets.all(2.0), onPressed: () {  },
                                            ),
                                            const Text(
                                              'صور العقد',
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange,),
                                            ),

                                          ],
                                        ),
                                      ),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.spaceAround,
                                        buttonHeight: 52.0,
                                        buttonMinWidth: 90.0,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2.0,
                                            ),
                                            child:
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                   // Icons.browse_gallery_sharp,
                                                    Icons.panorama_rounded ,
                                                    color: Colors.green,
                                                    size:35,
                                                  ),
                                                  onPressed: () async {
                                                    maxNoPic = maxNoPic + 1;
                                                    prefs.setInt('maxNoPic', maxNoPic);
                                                    // SnackBar(
                                                    //   content: Text('$maxNoPic'),
                                                    // );
                                                    imageSelector(
                                                        context,
                                                        "camera",
                                                        "Project_${numberFormat.format(maxNoPic)}.jpg",
                                                        Building.projectId);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.camera_enhance_rounded,
                                                    color: Colors.green,
                                                    size:35,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      maxNoPic = maxNoPic + 1;
                                                      prefs.setInt(
                                                          'maxNoPic', maxNoPic);
                                                      imageSelector(
                                                          context,
                                                          "gallery",
                                                          "Project_${numberFormat.format(maxNoPic)}.jpg",
                                                          Building.projectId);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: photoGallery(),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget photoGallery() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 200,
        height: 200,
        child: PhotoViewGallery.builder(
          itemCount: imageList.length,
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          scrollDirection: Axis.horizontal,
          //scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, index) {
            listenForPermissionStatus();
            return setPhoto(index, imageList[index]);
          },
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions? photoViewGalleryPageOption;
  PhotoViewGalleryPageOptions setPhoto(int index, String picPath) {
    listenForPermissionStatus();
    if (isPermmission || imageList.isNotEmpty) {
      img = Image.file(File(picPath));
      return PhotoViewGalleryPageOptions(
        imageProvider: img!.image,
        initialScale: PhotoViewComputedScale.contained,
        onScaleEnd: (context, details, controllerValue) {},
        // gestureDetectorBehavior: ,
        onTapUp: (context, details, controllerValue) {
          setState(() {
            imageList.remove(imageList[index]);
            // print('object   Delte');
          });
        },
      );
    } else {
      // print("put the icons");
      return PhotoViewGalleryPageOptions(
        imageProvider: const AssetImage('assets/icon/buildings.png'),
        initialScale: PhotoViewComputedScale.contained,
      );
    }
  }

  final ImagePicker picker = ImagePicker();
  //********************** IMAGE PICKER
  Future imageSelector(BuildContext context, String pickerType, String picName,
      int projectId) async {
    // listenForPermissionStatus();
    switch (pickerType) {
      case "gallery": // GALLERY IMAGE PICKER
        imageFile = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 100);
        break;
      case "camera": // CAMERA CAPTURE CODE
        // ignore: unnecessary_cast
        imageFile = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 100);
        break;
    }
    if (imageFile != null) {
      PermissionStatus status = await Permission.storage.request();
      PermissionStatus status2 =
          await Permission.manageExternalStorage.request();
      if (status.isGranted && status2.isGranted) {
        await imageFile!.saveTo('$extPicFolder/$picName');
      }
      dbPicutre.addPicture("$extPicFolder/$picName", projectId.toString());
      List yt = itemsPicture[projectId];
      yt.add("$extPicFolder/$picName");
      //print(' rterteetteteteteteteterte     $yt');
      itemsPicture[projectId] = yt;
    } else {
      // print("You have not taken image");
    }
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

  // int findLastPicNo() {
  //   dbPicutre.lastPicture().then((pictureItems) {
  //     //pictureItems. maxno
  //     //  var item = pictureItems.first;
  //     // item.
  //     maxNoPic = Sqflite.firstIntValue(pictureItems)!;
  //     // print(' ewwwwweeeeewwwwwwwwwwwww      $maxNoPic');
  //   });
  //   return maxNoPic;
  // }
}
