import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final menBazam = FirebaseFirestore.instance;

class DescriptionScreen extends StatefulWidget {
  static const String id = 'description_screen';
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Description'),
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
            final employers = snapshot.data.docs.reversed;
            List<DescriptionsObj> descriptions = [];
            for (var item in employers) {
              final group = item.data()['group'];
              final description = item.data()['description'];
              final projectName = item.data()['project'];

              final descriptionObj = DescriptionsObj(
                projectName: projectName,
                group: group,
                description: description,
              );
              if (user.currentUser.email == item.data()['user']) {
                descriptions.add(descriptionObj);
              }
            }
            return ListView.builder(
              itemCount: descriptions.length,
              itemBuilder: (context, i) {
                return descriptions[i];
              },
            );
          },
        ));
  }
}

class DescriptionsObj extends StatelessWidget {
  DescriptionsObj({this.group = '', this.description = '', this.projectName = ''});

  final String group;
  final String description;
  final String projectName;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
    child: Container(
    decoration: BoxDecoration(color: Colors.cyan,boxShadow: [BoxShadow(spreadRadius: 2.0,blurRadius: 6.0,color: Colors.black.withOpacity(0.1),
    )]),

      child: ListTile(
        leading: Text(
          projectName,
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700,color: Colors.white),
        ),
        title: Text(
          group,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400,color: Colors.white),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal,color: Colors.white),
        ),
      ),
    ),
    );
  }
}
