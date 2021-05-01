import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ukf_blood_bag/frdend/Needblood.dart';
import 'package:ukf_blood_bag/frdend/RegisterAsaDoner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'About.dart';




class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("UKF BLOOD BAG"),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("UKF BLOOD BAG"),
                  accountEmail: Text("nss.ukfcet@gmail.com"),
                  currentAccountPicture: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/logo.jpeg"
                              ),
                              fit: BoxFit.fill,
                            )
                          ),



                    ),


                  ),

                ListTile(
                  title: Text(
                    'Home Page',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Ask A Doubt',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.question_answer,
                    color: Colors.black,
                  ),
                  onTap: () {
                    _launchInBrowser("https://wa.me/+919895945776?text=Plz%20tell%20me%20about%20UKF%20Blood%20bag%20app");
                  },
                ),
                ListTile(
                  title: Text(
                    'About US',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutPage()));
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    'Rate Us',
                    style: TextStyle(color: Colors.blue),
                  ),
                  leading: Icon(
                    Icons.shop,
                    color: Colors.blue,
                  ),
                  onTap: (){
                    _launchInBrowser('https://play.google.com/store');
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height*.25,
              child: ListView(
                children: <Widget>[
                  buttonFunction(
                      name: "Search for blood",
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NeedBlood()));
                      },
                      buttenColor: Colors.red),
                  Divider(
                    height: 20,
                  ),
                  buttonFunction(
                      name: "Register as a doner",
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyCustomForm()));
                      },
                      buttenColor: Colors.red)
                ],
              ),
            ),
          )),
    );
  }
}

Widget buttonFunction({
  // used passing variable as a named parameters,
  String name,
  Color buttenColor,
  void Function() onpressed,
}) {
  return Column(

    children: <Widget>[
      Center(
        child: Container(

          height: 40,
          width: 200,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(.5, .5),
              )
            ],
          ),
          child: FlatButton(
            child: Text(name),
         //   color: buttenColor,
            onPressed: onpressed,
          ),
        ),
      ),
    ],
  );
}
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'header_key': 'header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}
