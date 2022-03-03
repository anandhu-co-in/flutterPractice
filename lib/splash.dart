import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/loginscreen.dart';
import 'package:flutter_project1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    verifyLogin(); //to decide if to show login or directly home page
    super.initState();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 300), () {});

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Container(child: AppHomeScreen());
    }));
  }

  _navigateLogin() async {


    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Container(child: ScreenLogin());
    }));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'MyApp',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  //using shared preference to check if user is logged in or not, navigate to ether home screen or to login screen
  void verifyLogin() async{

    final sharedPreferences = await SharedPreferences.getInstance();

     final alreadyLoggedin = sharedPreferences.getBool('isloggedin');


    await Future.delayed(Duration(milliseconds: 3000), () {});

    if(alreadyLoggedin==null || alreadyLoggedin ==false){
      _navigateLogin();
    }
    else{
      _navigateToHome();
    }

  }
}

class SplashScreen2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 3000,
          splash: Icons.home,
          // splash: Column(
          //   children: [
          //     Text(
          //       'MyApp',
          //       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          nextScreen: AppHomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.green),
    );
  }
}
