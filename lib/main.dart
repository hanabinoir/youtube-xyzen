import 'package:flutter/material.dart';
import 'package:youtube_xyzen_dev/screens/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) =>  const Home(),
    },
  ));
}


