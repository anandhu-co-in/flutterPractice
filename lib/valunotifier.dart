import 'dart:ffi';

import 'package:flutter/material.dart';

//Valie listener builder looks for the change in value by a vlue notifier and reredners some widget
//Statedless counter which updates cound using a value notifier
//we createa a valud notifier called counter for an int data
//we wrote a functionto update that int data
// when that function is called,  ie from the floating action button onclik
//Theis causes the Valulistenerbuilder widge which we have connetectd with the value notifier
// to execute the builder function we wrote inside it to build a text field in this case with
// the valud store in the value notifier

//ALso here i learnded, how to show different pages in screen using botton navigatino bar

class MyCounteer extends StatelessWidget {
  ValueNotifier<int> _counter = ValueNotifier(0);

  void _incrementCounter() {
    _counter.value = _counter.value + 1;
  }

  final pages = [Text('page1'), Text('page2'), Text('page3')];

  final _dropdownimtes = ['apple', 'perakka', 'mangp'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('click right end button to show botom sheet-->'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  showmyBottomSheet(context);
                },
                child: Icon(Icons.eighteen_mp_sharp))
          ],
        ),
        body: Center(
          child: Column(children: [
            //TO PRACIVE VLAUE LISTENER BUILDER

            ValueListenableBuilder(
              valueListenable: _counter,
              builder: (BuildContext ctx, int newValue, Widget? child) {
                return Text('$newValue');
              },
            ),

            //in ontap of botomnavationg bar, use set state to control the index here to display different pages/
            //cant do now as i am using staless widget
            Container(
              child: pages[2],
            ),


            //PRACTIVE DROPDOWN LIST
            DropdownButtonFormField(
                hint: Text('Select any item'),
                onChanged: (val) {
                  print(val);
                },
                items: _dropdownimtes.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList())
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            print('index of item clickdein botm nav bar is $index');
          },

          //use set state to control current Index to the selected with you click through each item
          // then you have to make this stateful widget
          currentIndex: 2,

          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blue,

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'personalabel'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          ],
        ),
      ),
    );
  }

  void showmyBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx1) {
          return Container(
            width: double.infinity,
            height: 400,
            color: Colors.orange,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx1).pop();
                },
                child: Text('textclosebutton'),
              ),
            ),
          );
        });
  }
}
