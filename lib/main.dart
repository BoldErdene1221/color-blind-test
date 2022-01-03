import 'package:flutter/material.dart';
import 'widgets/homeWidget.dart';
// import 'model/filters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Lobster'),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 15.0, right: 5.0, bottom: 10.0),
          child:  HomeWidget(),
        ),
        backgroundColor: const Color(0xFFCCB4FF),
      )
    );
  }
}
