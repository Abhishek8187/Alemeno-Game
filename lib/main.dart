import 'package:abhishek_kannaujia/Provider/size_provider.dart';
import 'package:abhishek_kannaujia/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SizeIncrease>(create: (_) => SizeIncrease()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
