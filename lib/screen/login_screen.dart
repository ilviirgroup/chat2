import 'package:chat/screen/project_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 200.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  //textAlign: TextAlign.center,
                  onChanged: (value){
                    email = value;
                },
                decoration: kTextFieldDecoratin.copyWith(hintText: 'Enter your email'),
                  ),
                  SizedBox(height: 8.0),
                  TextField(

                    onChanged: (value){
                    password = value;
                    },
                    decoration: kTextFieldDecoratin.copyWith(hintText: 'Enter your password'),
                  ),
                  SizedBox(height: 24.0),
                  RoundedButton(
                    title: 'Log In',
                    colour: Colors.lightBlueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user != null) {
                          Navigator.pushNamed(context, ProjectScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }catch(e){
                        print(e);
                      }
                    },
                  ),


    ],
        ),

    ),
    ),
    );

  }
}
