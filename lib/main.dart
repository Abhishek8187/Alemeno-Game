import 'package:abhishek_kannaujia/click_picture.dart';
import 'package:abhishek_kannaujia/home_screen.dart';
import 'package:abhishek_kannaujia/share_picture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
