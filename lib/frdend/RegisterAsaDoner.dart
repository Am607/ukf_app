import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_ui.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final districtController = TextEditingController();
  final phoneController = TextEditingController();
  var district = [
    "Thiruvananthapuram",
    "Kollam",
    "Alappuzha",
    "Pathanamthitta",
    "Kottayam",
    "Idukki",
    "Ernamkulam",
    "Thrissur",
    "Palakkad",
    "Malappuram",
    "Kozhikode",
    "Wayanad",
    "Kannur",
    "Kasaragod",
  ];
  int dno = 100;
  int bno = 101;

  var bloodgroup = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    bloodGroupController.dispose();
    districtController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as a donor'),
      ),
      body: ListView(
        children: <Widget>[
          textLayout(
            disabled: false,
              hint: "Enter Your Name",
              controller: nameController,
              iconData: Icons.person,
              keyboardType: TextInputType.text),
          textLayout(
              disabled: false,
              hint: "Enter Your Number",
              controller: phoneController,
              iconData: Icons.phone,
              keyboardType: TextInputType.phone),
          textLayout(
              disabled: false,
              hint: "Enter Your Age",
              controller: ageController,
              iconData: Icons.plus_one,
              keyboardType: TextInputType.number),
          textLayout(
            hint: "Enter Your District",
            disabled: true,
            controller: districtController,
            iconData: Icons.pin_drop,
            keyboardType: TextInputType.text,
            sufixIcon: PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              onSelected: (String value) {
                districtController.text = value;
              },
              itemBuilder: (BuildContext context) {
                return district.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: new Text(value), value: value);
                }).toList();
              },
            ),
          ),
          textLayout(
            hint: "Enter Your BloodGroup",
            disabled: true,
            controller: bloodGroupController,
            iconData: Icons.format_list_bulleted,
            keyboardType: TextInputType.text,
            sufixIcon: PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              onSelected: (String value) {
                bloodGroupController.text = value;
              },
              itemBuilder: (BuildContext context) {
                return bloodgroup.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: new Text(value), value: value);
                }).toList();
              },
            ),
          ),
          buttonFunction(
              name: "Submit",
              buttenColor: Colors.blue,
              onpressed: () {
                setState(() {
                  String name = nameController.text.toString();

                  int _age = int.parse(ageController.text);

                  int phone = int.parse(phoneController.text);
                  String district = districtController.text;
                  String bloodgroup = bloodGroupController.text;
                  if (district == "Thiruvananthapuram") {
                    dno = 1;
                  } else if (district == "Kollam") {
                    dno = 2;
                  } else if (district == "Alappuzha") {
                    dno = 3;
                  } else if (district == "Pathanamthitta") {
                    dno = 4;
                  } else if (district == "Kottayam") {
                    dno = 5;
                  } else if (district == "Idukki") {
                    dno = 6;
                  } else if (district == "Ernamkulam") {
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

                  aFunction(
                      fullName: name,
                      age: _age,
                      bloodGroup: bloodgroup,
                      district: district,
                      phone: phone,
                      dnoa: dno,
                      bnoa: bno);
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
              }),
        ],
      ),
    );
  }
}

void aFunction(
    {String fullName,
    int phone,
    int age,
    String district,
    String bloodGroup,
    int dnoa,
    int bnoa}) {
  CollectionReference users = FirebaseFirestore.instance.collection('doner');

  users
      .add({
        'Name': fullName,
        'Age': age,
        'Blood group': bloodGroup,
        'District': district,
        'Phone': phone,
        'dno': dnoa,
        'bno': bnoa,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Widget textLayout(
    {String hint,
    final controller,
    final keyboardType,
    final sufixIcon,
      bool disabled,
    // Color color,
    IconData iconData}) {
  return Container(
    //   decoration: BoxDecoration(
    //
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.blueGrey[200],
    //         spreadRadius: 1,
    //         blurRadius: 60,
    //
    //        offset: Offset(.5, .5),
    //
    //       )
    //     ],
    //   ),
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: disabled ,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(8),
            topLeft: Radius.circular(25),
          ),
          borderSide: BorderSide(color: Colors.blue, width: 2.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.5),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(8),
            topLeft: Radius.circular(25),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.5),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(8),
            topLeft: Radius.circular(25),
          ),
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
