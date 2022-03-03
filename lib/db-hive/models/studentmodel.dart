// class studentModel{
//   final String name;
//   final String age;
//
//   studentModel({required this.name, required this.age});
//
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'studentmodel.g.dart'; //when that generator command is runnnig, as i add this .g.dart filean and saved, the studentmode.g.dart is generated succesfully

@HiveType(typeId: 1)
class studentModel extends HiveObject{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  studentModel({required this.name, required this.age});

}



//Code to build hte adatpeter file
// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs