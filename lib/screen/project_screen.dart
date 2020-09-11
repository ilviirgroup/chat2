import 'package:chat/components/rounded_button.dart';
import 'package:chat/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'description_screen.dart';

final menBazam = FirebaseFirestore.instance;
final menUser = FirebaseAuth.instance;

class ProjectScreen extends StatefulWidget {
  static const String id = 'project_screen';
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget> [
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pushNamed(context, ChatScreen.id);
              },
            )
          ],
          title: Text('Project'),
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: menBazam.collection('employers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            final projects = snapshot.data.docs.reversed;
            List<ProjectsObj> project = [];
            for (var item in projects) {
              final name = item.data()['project'];
              final projectObj = ProjectsObj(
                name: name,
              );
              if(menUser.currentUser.email==item.data()['user']){
                project.add(projectObj);
              }

            }
            return ListView.builder(
              itemCount: project.length,
              itemBuilder: (context, i) {
                return project[i];
              },
            );
          },
        ));
  }
}

class ProjectsObj extends StatelessWidget {
  ProjectsObj({this.name = ''});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: RaisedButton(

        onPressed: () {
          print('basyldy');
        },
         color: Colors.greenAccent,

        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, DescriptionScreen.id);
          },
          leading: Text('1'),
          title: Text(name),
          trailing: Text('descrip'),
        ),
        ),
    );
  }
}
