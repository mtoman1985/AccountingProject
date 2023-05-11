library globals;

import 'dart:io';
import 'package:belal_pro/utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

bool isLoggedIn = false;
bool ispressed = false;
int selectedButton = 0;
int maxNoPic = 1;
List<IconData> bottmButton = [
  Icons.account_box_rounded,
  Icons.add_card,
  Icons.abc_rounded
];


const extFolder = "/storage/emulated/0/BelalFiles";
const extDbFolder = "/storage/emulated/0/BelalFiles/db";
const extPicFolder = "/storage/emulated/0/BelalFiles/pic";
const extFilesFolder = "/storage/emulated/0/BelalFiles/files";

void copyFiles(String fromPath, String toPath) async {
  const dbFolder = "storage/emulated/0/Android/data/com.example.belal_pro";
  File source1 = File('$dbFolder/database/db.db');
  String source2 = await getDatabasesPath() + '/db.db';
  Directory copyTo = Directory("$dbFolder/database");
  if (await Permission.storage.request().isGranted) {
    await copyTo.create();
  }
  if ((await copyTo.exists())) {
    // print("Path exist");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  } else {
    print("not exist");
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      await copyTo.create();
    } else {
      print('Please give permission');
    }
  }
}

void creatExtFolder(String folderName) async {
  creatExtMainFolder();
  Directory path = Directory("$extFolder/$folderName");
  if ((await path.exists())) {
    print("exists file ");
  } else {
    PermissionStatus status = await Permission.storage.request();
    PermissionStatus status2 = await Permission.manageExternalStorage.request();
    if (status.isGranted && status2.isGranted) {
      path.createSync();
    }
  }
}

void creatExtMainFolder() async {
  Directory path = Directory(extFolder);
  if ((await path.exists())) {
    print("exists file ");
  } else {
    PermissionStatus status = await Permission.storage.request();
    PermissionStatus status2 = await Permission.manageExternalStorage.request();
    if (status.isGranted && status2.isGranted) {
      path.createSync();
    }
  }

  void _listenForPermissionStatus() async {
    print("guyutyuuuuuuuuuuuuuututut      ggggggutututu");
    final status = await Permission.storage.status;
    // setState() triggers build again
    PermissionStatus status1 = await Permission.storage.request();
    PermissionStatus status2 = await Permission.manageExternalStorage.request();
    if (status1.isGranted && status2.isGranted) {
      //   await Permission.storage.request();
      print("ggggggggggggggggggobject");
    }
    print("gggggewreeeeeeeeeeeeeeeeeewrwr  wegggggggggggggobject");
  }
}
