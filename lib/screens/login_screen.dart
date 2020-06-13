import 'package:flash_chat/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/services/button_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email, password;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 80.0,
                    ),
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email =  value;
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ButtonClass(buttonText: 'Login', buttonColor: Colors.lightBlueAccent, onPress: ()async{
                    setState(() {
                      loader = true;
                    });
                    try{
                    var loggedInUser = await  _auth.signInWithEmailAndPassword(email: email, password: password) ;
                    if(loggedInUser !=  null)
                      {
                        Navigator.pushNamed(context, '/chat');
                      }
                    setState(() {
                      loader = false;
                    });
                    }catch(e) {
                      print(e);
                    }
                  },),
                  ],
                ),
            ),
          ),
          inAsyncCall : loader,
        ),
    );
  }
}
