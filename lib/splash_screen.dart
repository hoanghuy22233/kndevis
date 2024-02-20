import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'home.dart';


bool isFake = true;
String tokenFirebase = '';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(seconds: 3),
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Home(),
                    // fullscreenDialog: true,
                  ));
        },
      );
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/playstore.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
