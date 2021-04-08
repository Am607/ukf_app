import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'home_ui.dart';

class NeedBlood extends StatefulWidget {
  @override
  _NeedBloodState createState() => _NeedBloodState();
}

class _NeedBloodState extends State<NeedBlood> {
  final dnoController = TextEditingController();
  final bnoController = TextEditingController();

  @override
  void dispose() {
    dnoController.dispose();
    bnoController.dispose();
    super.dispose();
  }

  var district = [
    "Thiruvananthapuram",
    "Kollam",
    "Alappuzha",
    "Pthanamthitta",
    "Kottayam",
    "Idukki",
    "Ernakulam",
    "Thrissur",
    "Palakkad",
    "Malappuram",
    "Kozhikode",
    "Wayanad",
    "Kannur",
    "Kasaragod",
  ];

  var bloodgroup = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  int dno = 1;
  int bno = 1;

  @override
  Widget build(BuildContext context) {
    print(bno);
    print(dno);
    return Scaffold(
        // backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("UKF BLOOD BAG"),
        ),
        body: ListView(
          children: <Widget>[
            searchLayout(
              controller: dnoController,
              hint: " District Here",
              keyboardType: TextInputType.text,
              iconData: Icons.pin_drop,
              sufixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  dnoController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return district.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
            searchLayout(
              controller: bnoController,
              hint: " Blood group Here",
              keyboardType: TextInputType.text,
              iconData: Icons.format_list_bulleted,
              sufixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  bnoController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return bloodgroup.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
            Divider(
              height: 5,
            ),
            buttonFunction(
              name: "Submit",
              onpressed: () {
                setState(() {
                  String district = dnoController.text;
                  String bloodgroup = bnoController.text;

                  if (district == "Thiruvananthapuram") {
                    dno = 1;
                  } else if (district == "Kollam") {
                    dno = 2;
                  } else if (district == "Alappuzha") {
                    dno = 3;
                  } else if (district == "Pthanamthitta") {
                    dno = 4;
                  } else if (district == "Kottayam") {
                    dno = 5;
                  } else if (district == "Idukki") {
                    dno = 6;
                  } else if (district == "Ernakulam") {
                    dno = 7;
                  } else if (district == "Thrissur") {
                    dno = 8;
                  } else if (district == "Palakkad") {
                    dno = 9;
                  } else if (district == "Malappuram") {
                    dno = 10;
                  } else if (district == "Kozhikode") {
                    dno = 11;
                  } else if (district == "Wayanad") {
                    dno = 12;
                  } else if (district == "Kannur") {
                    dno = 13;
                  } else if (district == "Kasaragod") {
                    dno = 14;
                  }
                  print(dno);
                  if (bloodgroup == "A+") {
                    bno = 1;
                  } else if (bloodgroup == "A-") {
                    bno = 2;
                  } else if (bloodgroup == "B+") {
                    bno = 3;
                  } else if (bloodgroup == "B-") {
                    bno = 4;
                  } else if (bloodgroup == "O+") {
                    bno = 5;
                  } else if (bloodgroup == "O-") {
                    bno = 6;
                  } else if (bloodgroup == "AB+") {
                    bno = 7;
                  } else if (bloodgroup == "AB-") {
                    bno = 8;
                  }
                  print(bno);
                });
              },
            ),
            Divider(
              height: 10,
            ),

            Container(
                height: 400,
                //color: Colors.red,
                child: afunction(b: bno, d: dno)),
          ],
        ));
  }
}

Widget afunction({int b, int d}) {
  print("a = $b");
  print("d = $d");
  return StreamBuilder(
    // ignore: deprecated_member_use
    stream: Firestore.instance
        .collection("doner")
        .where('dno', isEqualTo: d)
        .where('bno', isEqualTo: b)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6 ,left: 8,right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(4, 4),
                        )
                      ],
                    ),
                    height: 45,
                    // color: Colors.blue,
                    child: ListTile(
                      title: Text(
                        snapshot.data.documents[index]['Name'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        snapshot.data.documents[index]['Blood group'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(),
                        child: IconButton(
                          onPressed: () {
                            String no = snapshot.data.documents[index]['Phone']
                                .toString();
                            _makePhoneCall('tel:$no');
                          },
                          icon: Container(
                            decoration: BoxDecoration(

                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.white,
                                //     spreadRadius: 1,
                                //     blurRadius: 40,
                                //     offset: Offset(.5, .5,),
                                //   )
                                // ],
                                ),
                            child: Icon(
                              Icons.call,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
      } else if (snapshot.hasError) {
        const Text('No data avaible right now');
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}

Widget searchLayout(
    {String hint,
    final controller,
    final keyboardType,
    final sufixIcon,
    // Color color,
    IconData iconData}) {
  return Container(
    height: 55,
    padding: const EdgeInsets.only(top: 6, bottom: 3, right: 3, left: 3),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          borderSide: BorderSide(color: Colors.blue, width: 2.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.5),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.5),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
        ),
        labelText: hint,
        //  helperText: "helper text",
        suffixIcon: sufixIcon,

        icon: Icon(
          iconData,
          color: Colors.blue,
        ),
      ),
    ),
  );
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
