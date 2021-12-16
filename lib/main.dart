import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/pages/home_page.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Crypto Tracker",
      home: HomePage(),
    );
  }
}
