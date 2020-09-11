import 'package:chat/screen/chat_screen.dart';
import 'package:chat/screen/description_screen.dart';
import 'package:chat/screen/login_screen.dart';
import 'package:chat/screen/project_screen.dart';
import 'package:chat/screen/registration_screen.dart';
import 'package:chat/screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id:(context)=> ChatScreen(),
        ProjectScreen.id: (context) => ProjectScreen(),
        DescriptionScreen.id: (context) => DescriptionScreen(),
      },
    );
  }
}
