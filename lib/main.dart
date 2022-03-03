import 'package:flutter/material.dart';
import 'package:flutter_project1/apilistpage.dart';
import 'package:flutter_project1/db-hive/models/studentmodel.dart';
import 'package:flutter_project1/lessonhive.dart';
import 'package:flutter_project1/loginscreen.dart';
import 'package:flutter_project1/page_shared_preference.dart';
import 'package:flutter_project1/routeanmication.dart';
import 'package:flutter_project1/splash.dart';
import 'package:flutter_project1/valunotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about.dart';
import 'package:flutter_project1/page_shared_preference.dart';

import 'db-hive/functions/dbfunctions.dart';

// void main() => runApp(MyApp());



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initializeSQFliteDatabase();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

      //Alternative say of routing, if i want to naviate to pages, ic we defind them like below we can call them from
      // a  page like this -->Navigator.of(context).pushNamed('screen_sharedp');
      routes: {
        'screen_sharedp':(ctx){
          return  MySharePrefPracPage();
        },
        'screen_login':(ctx){
          return  ScreenLogin();
        },
        'app_homeScreen':(ctx){
          return AppHomeScreen();
        }
      },
    );
  }
}

class AppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      drawer: myDrawer(),
      appBar: AppBar(
        elevation: 5,
        title: Text('BURGER ICONf'),

        //let me add a logout button in the appbar, which calls the logout funciton whitch clears the stack and navigates to login screen
        actions: [IconButton(onPressed: (){logout(context);}, icon: Icon(Icons.exit_to_app))],
      ),
      body: Column(
        children: [listtile(), listtile()],
      ),
    );
  }

  Widget listtile() {
    return const ListTile(
      leading: Text('ListTileLeadin'),
      trailing: Text('Kooied'),
    );
  }

  logout(BuildContext ctx) async{
    //removeuntil -- because it removes all previous screen in the stack, as we are logging out,
    Navigator.of(ctx).pushNamedAndRemoveUntil('screen_login', (route) => false);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('isloggedin');
  }
}

class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green[400],
        child: ListView(
          children: [
            menuItem(
                onClicked: () {
                  openPage(0, context);
                },
                name: "ABout page"),
            menuItem(
                onClicked: () {
                  openPage(1, context);
                },
                name: "API listview"),
            menuItem(
                onClicked: () {
                  openPage(2, context);
                },
                name: "API listview fade"),
            menuItem(
                onClicked: () {
                  openPage(3, context);
                },
                name: "SharePrefPractivePage"),
            menuItem(
                onClicked: () {
                  openPage(4, context);
                },
                name: "login screen"),
            menuItem(
                onClicked: () {
                  openPage(5, context);
                },
                name: "valuenotifier"),
            menuItem(
                onClicked: () {
                  openPage(6, context);
                },
                name: "HivePractice")
          ],
        ),
      ),
    );
  }

  Widget menuItem({VoidCallback? onClicked, name}) {
    return ListTile(
      leading: Icon(Icons.people),
      title: Text(name),
      hoverColor: Colors.green[300],
      onTap: onClicked,
    );
  }

  void openPage(int i, BuildContext context) {
    //Close the drawer just before naviation
    Navigator.of(context).pop();

    switch (i) {
      case 0:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AboutPage(passed_value: '12345678',);
          }));
          break;
        }
      case 1:
        {
          Navigator.push(context, SlideRightRoute(page: ApiListPage()));
          break;
        }
      case 2:
        {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => ApiListPage(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 100),
            ),
          );
        }
        break;
      case 3:
        //let me use named routes, these names are difined in the material app, route property our first amterial app function
        Navigator.of(context).pushNamed('screen_sharedp');
        break;
      case 4:
        //let me use named routes, these names are difined in the material app, route property our first amterial app function
        Navigator.of(context).pushNamed('screen_login');
        break;
      case 5:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MyCounteer();
          }));
          break;
        }
        case 6:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return HivePractive();
          }));
          break;
        }
    }
  }
}
