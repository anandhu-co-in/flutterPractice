import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MySharePrefPracPage extends StatelessWidget {
  MySharePrefPracPage({Key? key}) : super(key: key);

  final _textController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('SharePrefPracticeScaffoldAppbarTitle'),),
          body: Column(
            children: [
              TextFormField(
                controller: _textController,
              ),
              ElevatedButton(onPressed: (){
                saveDataToStorage();
              }, child: Text('Text'))
            ],
          )
        ),
      )
    );
  }


  Future<void> saveDataToStorage() async{

    // print(_textController.text);
    getSavedData();
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('saved_value', _textController.text);

    getSavedData();

  }



  //Imagine using this below fundtion in login screen to skip it if person is already logged in !
  //we can do this on splash screen.. to decide if to show login screen or home screen!
  Future<void> getSavedData() async{

    final sharedPreferences = await SharedPreferences.getInstance();
    String? setting = sharedPreferences.getString('saved_value');
    print('Saved value is $setting');

  }


}
