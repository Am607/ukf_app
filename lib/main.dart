import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:ukf_blood_bag/frdend/home_ui.dart';

import 'frdend/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splash2());
  }
}

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // ignore: deprecated_member_use
      stream: Firestore.instance.collection("doner").snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => Container(
                  child: Text(snapshot.data.documents[index]['Name']),
                ));
      },
    );
  }
}
