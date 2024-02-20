


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 late DatabaseReference dbRef;
 Query db = FirebaseDatabase.instance.ref().child('url');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('url');
 final Future<FirebaseApp> _fapp = Firebase.initializeApp();
  String? urls;
  String hotro = "https://panelkey.store";

  @override
  void initState() {
   db = FirebaseDatabase.instance.ref().child("url");
   print(db);
    controller = WebViewController();
   DatabaseReference reference = FirebaseDatabase.instance.ref().child('url');
   DatabaseReference references =
   FirebaseDatabase.instance.ref().child('hotro');
    reference.onValue.listen((event) {
      setState(() {
        urls = event.snapshot.value.toString();
      });
    });
    references.onValue.listen((event) {
      setState(() {
        hotro = event.snapshot.value.toString();
      });
    });
    super.initState();
  }

  late WebViewController controller;
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fapp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          } else if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.only(top: 35),
              child: content(),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget content() {
    return WebViewWidget(
        controller: controller
          ..loadRequest(
            Uri.parse(urls??hotro),
          ));
  }
}
