import 'package:flutter/material.dart';
import 'package:flutter_project1/db-hive/functions/dbfunctions.dart';
import 'package:flutter_project1/db-hive/models/studentmodel.dart';

class HivePractive extends StatelessWidget {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();

  final mylistitems = ['item1', 'item2', 'ss'];


  @override
  Widget build(BuildContext context) {

    getAllStudents(); //calling the dbfunction i have writted to loada all the students when app first started

    return Scaffold(
      appBar: AppBar(
        title: Text('Page for Hive databse practice Practice'),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                TextFormField(
                    controller: _namecontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'name')),
                TextFormField(
                    controller: _agecontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'age')),
                TextButton(
                    onPressed: () {
                      final student = studentModel(
                          name: _namecontroller.text.trim(),
                          age: _agecontroller.text.trim());
                      addStudent(student);
                    },
                    child: Text('Add'))
              ],
            ),
          ),

          ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext ctx, List<studentModel> studentsList,
                Widget? child) {
              print(studentsList);
              // return Text(studentsList[6].name.toString());

              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: studentsList.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: ListTile(
                          title: Text(studentsList[index].name),
                          subtitle: Text(studentsList[index].age),
                          trailing: IconButton(onPressed: (){
                            print('clicked');
                            print(studentsList[index].key);
                            if (studentsList[index].key!=null){
                              deleteStudent(studentsList[index].key!);
                            }
                          }, icon: Icon(Icons.delete)),

                        ),
                        elevation: 2,
                      );
                    }),
              );
            },
          ),


        ],
      ),
    );
  }
}

//Hive and he said something like sqlif..
//Said hive is easier, so we learn it first



// User enter name and age fields
// studemetmodel object is created and it is sent to addstudent function
// Add student funcaiton add that objcen into studentListNotifier value <<-- ie its vaue is our array. its an array right, so that object gets added there
// That funtions then notifices the liststerns of studentListNotifier
// this in this page ValueListenableBuilder reerenders the listview with so new data appears
// Need to udnerstand the purpose of expanded widget

