import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _showLoginError=false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form( //Warpping with form since i want to use validator in the fields
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.end, //makes the login button right righ
            children: [
              TextFormField(
                validator: (value){
                  if(value == 'invalid'){
                    return 'Invlid value';
                  }else{
                    return null;
                  }
                },
                controller: _usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Username'),
              ),
              const SizedBox(
                height: 17,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: _showLoginError,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
              ),
              const SizedBox(
                height: 17,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //visibilety widdge to make something visible based on a boolen value
                  Visibility(
                    visible: false,
                      child: Text('Usernamd or Password is wrong',
                          style: TextStyle(fontStyle: FontStyle.italic,
                          color: Colors.red))),
                  ElevatedButton.icon(
                    onPressed: () {
                      print("clicked login button");
                      if(_formKey.currentState!.validate()){
                        print("validation passed");
                        verifyLogin(context);
                      } //<--- this call is for the validator to work
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Login')),],
              ),
            ],
          ),
        ),
      )),
    ));
  }

  void verifyLogin(BuildContext ctx) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == password) {
      //Login success
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Login Success Snackbars')));

      //using reaplacement, as if user clickx back it should not take back to login
      //same should be done in splash screen also
      Navigator.of(ctx).pushReplacementNamed('app_homeScreen');

      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('isloggedin',true);

    } else {
      //Login failed

      //snackbar with floating red background and 5 seconds duration
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Login Failed Floating Snackbar')));

      //We can also show a dialogue like this, although he said we don't usually do this
      showDialog(
          context: ctx,
          builder: (ctx1) {
            return AlertDialog(
              title: Text('error diglog titlesssssssssssss'),
              content: Text("Alert dialog content text"),
              actions: [TextButton(onPressed: () {
                Navigator.of(ctx1).pop();
              }, child: Text('Close'))],
            );
          });
    }
  }
}
