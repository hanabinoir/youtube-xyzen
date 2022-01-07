import 'package:flutter/material.dart';
import 'package:youtube_xyzen_dev/screens/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) =>  const Home(),
    },
  ));
}


