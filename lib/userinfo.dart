import 'package:flutter/material.dart';
import 'widgets/userWidget.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(new AssetImage('assets/images/quiz1-min.png'), context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Сорил бөглөх',style: TextStyle(fontSize: 20, ),),
        backgroundColor: const Color(0xffFFCCB4), // status bar color
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 0.0, right: 5.0, bottom: 30.0),
          child: UserWidget(),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 159, 142, 1),
    );
  }
}
