import 'package:color_blind_test/widgets/resultWidget.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Сорилын хариу',
          style: TextStyle(fontSize: 20, color: const Color(0xffFF4400)),
        ),
        backgroundColor: const Color(0xffFFC700), // status bar color
        brightness: Brightness.light,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
          child: ResultWidget(),
      ),
      backgroundColor: const Color(0xffFFF3C8),
    );
  }
}
