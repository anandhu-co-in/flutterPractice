


import 'package:flutter/cupertino.dart';
import 'package:flutter_project1/db-hive/models/studentmodel.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<studentModel>> studentListNotifier = ValueNotifier([]);

//Add new student to hive db
Future<void> addStudent(studentModel value) async{

  //save the new student to db
  final studentBD= await Hive.openBox<studentModel>('student_db');
  await studentBD.add(value);
  getAllStudents();
}


//get all studentss
Future<void> getAllStudents() async{

  final studentBD= await Hive.openBox<studentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentBD.values);
  studentListNotifier.notifyListeners();
}

//get all students
Future<void> deleteStudent(int key) async{
  final studentBD= await Hive.openBox<studentModel>('student_db');
  await studentBD.delete(key);
  getAllStudents();
}



//WHen we use hive
//i adde annoation above the fields in the model calss
// i registered the have thins on the main fucniton
// i extendded a hivemodel class in them model clas, that gave an id field, which i am using to pass into delete
