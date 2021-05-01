import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_ui.dart';

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new HomePage(),
      title: new Text('UKF BLOOD BAG', textScaleFactor: 2,),
      image:  Image(
        image:  AssetImage(
            "assets/logo.jpeg"
        ),
      ),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}