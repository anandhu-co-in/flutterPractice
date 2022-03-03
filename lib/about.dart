import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  final String passed_value;

  const AboutPage({Key? key, required this.passed_value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aboutdd'),
          leading: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Text('ABOUT PAGE BODY- Passed vale : $passed_value'),
      ),
    );
  }
}
