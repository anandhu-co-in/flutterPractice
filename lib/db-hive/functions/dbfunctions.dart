import 'package:flutter/cupertino.dart';
import 'package:flutter_project1/db-hive/models/studentmodel.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<studentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;


//Add new student to hive db <----- called in the main file, when starting the app
Future<void> initializeSQFliteDatabase() async {
  // open the database
  _db = await openDatabase("mydbname.db", version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
  });
}


//Add new student to hive db
Future<void> addStudent(studentModel value) async {
  //save the new student to db
  await _db.rawInsert(
      'INSERT INTO student(name, age) VALUES(?,?)', [value.name, value.age]);
  getAllStudents();
}


//get all students
Future<void> getAllStudents() async {
  studentListNotifier.value.clear();
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);

  _values.forEach((map) {
    studentListNotifier.value.add(studentModel.fromMap(map));
  });

  studentListNotifier.notifyListeners();
}

//get all students
Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id=?', [id]);

  getAllStudents();
}



//FLOW
//in pubsec.yaml sqflite dependenecy is added, eg.. (i had removed all the hive ones i had added for hive ) sqflite: ^2.0.0+4
//also that generated file when i did hive was deleted
//initializeSQFliteDatabase is called in main.dart file when starting the app
//So the databse mydbname.db is created if it is not already created
//and the _db variable has the db
//get all students wiill fetch the data from db, is an array of maps (each map each row of the table)
//each map is then converted into the correct object as in the studementmode.dart file
//For doing that we have writtedn a static funciton inside studeentmodel calss
//So objec for each item is pushed into the student notifiers value
//so value changes... its notifies the listeners, its rebuilds with the new data

//add student and delete student are self explanatory!

//note i haven't renamed the db-hive folder,,

//test before commit - done




