import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:color_blind_test/widgets/protVideoPlayer.dart';
import 'package:color_blind_test/widgets/deutVideoPlayer.dart';
import 'package:color_blind_test/model/answer.dart';
import 'package:color_blind_test/model/text.dart';
import 'package:color_blind_test/widgets/ResultCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/result.dart';
import 'model/user.dart';

class ResultMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResultMainState();
  }
}

class ResultMainState extends State<ResultMain> {
  User _user;
  Result _result;
  Answer _answer;
  // int _cnt;
  bool isNormal = true;
  var resultCards = <Widget>[];
  var deutGlassCards = <Widget>[];
  var protGlassCards = <Widget>[];
  var userAnswers = [];
  var deutGlass = AllText.deutGlass;
  var protGlass = AllText.protGlass;

  Widget _getGlasses(String image, String name, String price, String link) {
    return Card(
        color: const Color.fromRGBO(255, 255, 255, 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
          child: Column(
            children: [
              Image(image: NetworkImage(image)),
              SizedBox(height: 10.0),
              Text(
                'enchroma',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    price,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  launch(link);
                },
                child: Text(
                  'Барааг үзэх',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    deutGlass.forEach((element) {
      deutGlassCards.add(_getGlasses(element['image'], element['name'],
          element['price'], element['link']));
    });
    protGlass.forEach((element) {
      protGlassCards.add(_getGlasses(element['image'], element['name'],
          element['price'], element['link']));
    });
  }

  @override
  Widget build(BuildContext context) {
    List list = ModalRoute.of(context).settings.arguments;
    _user = list[0];
    _result = list[1];
    _answer = list[2];
    // _cnt = list[3];
    addAnswers();
    for (var i = 0; i < 38; i++) {
      resultCards.add(ResultCard(i, userAnswers));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Сорилын хариу',
          style: TextStyle(fontSize: 20, color: const Color(0xffFFFFFF)),
        ),
        backgroundColor: const Color(0xffFF7373), // status bar color
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, top: 0.0, right: 10.0, bottom: 5.0),
        child: Padding(
            padding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0, bottom: 20.0),
            child: Column(
              children: [
                Card(
                    semanticContainer: true,
                    color: const Color(0xffFFEEEE),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text('Нэр: ' + _user.fullName,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.purple[900])),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                                'Өдөр: ' +
                                    DateFormat('yyyy-MM-dd kk:mm')
                                        .format(_user.testedDate),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.purple[900])),
                          ),
                          /******************************* CORRECT ANSWER **************************************/
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, bottom: 0.0, top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Зөв хариу',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900])),
                                Text(_result.corrAns.toString() + '/38',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900]))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .87,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 0,
                              percent: _result.corrAnsPer,
                              center: Text((((_result.corrAns) * 100) / 38)
                                      .ceilToDouble()
                                      .toString() +
                                  "%"),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.lightGreenAccent,
                            ),
                          ),
                          /******************************* Protanopia **************************************/
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, bottom: 0.0, top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Протанопия',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900])),
                                Text(_result.protCb.toString() + '/36',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900]))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .87,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 0,
                              percent: _result.protCbPer,
                              center: Text((((_result.protCb) * 100) / 36)
                                      .ceilToDouble()
                                      .toString() +
                                  "%"),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: const Color(0xFFFBFF3C),
                            ),
                          ),
                          /******************************* Deuteranopia **************************************/
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, bottom: 0.0, top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Дейтеранопия',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900])),
                                Text(_result.deutCb.toString() + '/36',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900]))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .87,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 0,
                              percent: _result.deutCbPer,
                              center: Text((((_result.deutCb) * 100) / 36)
                                      .ceilToDouble()
                                      .toString() +
                                  "%"),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: const Color(0xFFFBFF3C),
                            ),
                          ),
                          /******************************* Нийт өнгөний харалган байдал **************************************/
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, bottom: 0.0, top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Өнгөт харалган байдал',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900])),
                                Text(_result.totalCb.toString() + '/38',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[900]))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 5.0, bottom: 5.0),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .87,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 0,
                              percent: _result.totalCbPer,
                              center: Text((((_result.totalCb) * 100) / 38)
                                      .ceilToDouble()
                                      .toString() +
                                  "%"),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: const Color(0xFFFF3C3C),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                /****************************************************************************
                     *
                     * Slider
                     *
                     * ****************************************************************************/
                CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * .40,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 7),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    ),
                    items: resultCards),
                getProtRes(),
                getDeutRes(),
                getNormalRes(),
                _result.protCb > 0
                    ? ExpansionTile(
                        title: Text(
                          'Протанопия харалган байдалд санал болгож буй шилнүүд',
                          style: TextStyle(color: Colors.purple[900]),
                        ),
                        children: [
                          CarouselSlider(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * .36,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 7),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {});
                                },
                              ),
                              items: protGlassCards)
                        ],
                      )
                    : SizedBox(),
                _result.deutCb > 0
                    ? ExpansionTile(
                        title: Text(
                          'Дейтеранопия харалган байдалд санал болгож буй шилнүүд',
                          style: TextStyle(color: Colors.purple[900]),
                        ),
                        children: [
                          CarouselSlider(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * .36,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 7),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {});
                                },
                              ),
                              items: deutGlassCards)
                        ],
                      )
                    : SizedBox()
              ],
            )),
      )),
      backgroundColor: const Color(0xffFFBFBF),
    );
  }

  Widget getProtRes() {
    if (_result.protCb > 0) {
      isNormal = false;
      return Card(
        semanticContainer: true,
        color: const Color.fromRGBO(255, 255, 255, 0.9),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Таний сорилын хариунд улаан буюу Протанопия харалган байдал илэрсэн байна. Протанопия харалган байдалд зориулсан видеог үзнэ үү!',
                        style:
                            TextStyle(fontSize: 16, color: Colors.purple[900]),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffFFCCB4),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProtVideoPlayer(index: 0);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffFFCCB4),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProtVideoPlayer(index: 1);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '3',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffFFCCB4),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProtVideoPlayer(index: 2);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '4',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffFFCCB4),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProtVideoPlayer(index: 3);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      )
                    ]))),
      );
    }
    return SizedBox();
  }

  Widget getDeutRes() {
    if (_result.deutCb > 0) {
      isNormal = false;
      return Card(
        semanticContainer: true,
        color: const Color.fromRGBO(255, 255, 255, 0.9),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Таний сорилын хариунд ногоон буюу Дейтеранопия харалган байдал илэрсэн байна. Дейтеранопия харалган байдалд зориулсан видеог үзнэ үү!',
                        style:
                            TextStyle(fontSize: 16, color: Colors.purple[900]),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffB4FFCC),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return DeutVideoPlayer(index: 0);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffB4FFCC),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return DeutVideoPlayer(index: 1);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '3',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffB4FFCC),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return DeutVideoPlayer(index: 2);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text(
                                '4',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: const Color(0xffB4FFCC),
                              textColor: const Color(0xffFF581B),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return DeutVideoPlayer(index: 3);
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    BorderSide(color: const Color(0xffFF581B)),
                              ),
                            ),
                          )
                        ],
                      )
                    ]))),
      );
    }
    return SizedBox();
  }

  Widget getNormalRes() {
    if (isNormal) {
      return Card(
        semanticContainer: true,
        color: const Color.fromRGBO(255, 255, 255, 0.9),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                child: Column(children: [
                  Text(
                      'Таны сорилын хариунд ямар нэг өнгөний харалган байдал илрээгүй байна. Таны өнгө ялгах чадвар сайн байна.',
                      style: TextStyle(fontSize: 18, color: Colors.purple[900]),
                      textAlign: TextAlign.center)
                ]))),
      );
    }
    return SizedBox();
  }

  void addAnswers() {
    userAnswers.add(_answer.a1);
    userAnswers.add(_answer.a2);
    userAnswers.add(_answer.a3);
    userAnswers.add(_answer.a4);
    userAnswers.add(_answer.a5);
    userAnswers.add(_answer.a6);
    userAnswers.add(_answer.a7);
    userAnswers.add(_answer.a8);
    userAnswers.add(_answer.a9);
    userAnswers.add(_answer.a10);
    userAnswers.add(_answer.a11);
    userAnswers.add(_answer.a12);
    userAnswers.add(_answer.a13);
    userAnswers.add(_answer.a14);
    userAnswers.add(_answer.a15);
    userAnswers.add(_answer.a16);
    userAnswers.add(_answer.a17);
    userAnswers.add(_answer.a18);
    userAnswers.add(_answer.a19);
    userAnswers.add(_answer.a20);
    userAnswers.add(_answer.a21);
    userAnswers.add(_answer.a22);
    userAnswers.add(_answer.a23);
    userAnswers.add(_answer.a24);
    userAnswers.add(_answer.a25);
    userAnswers.add(_answer.a26);
    userAnswers.add(_answer.a27);
    userAnswers.add(_answer.a28);
    userAnswers.add(_answer.a29);
    userAnswers.add(_answer.a30);
    userAnswers.add(_answer.a31);
    userAnswers.add(_answer.a32);
    userAnswers.add(_answer.a33);
    userAnswers.add(_answer.a34);
    userAnswers.add(_answer.a35);
    userAnswers.add(_answer.a36);
    userAnswers.add(_answer.a37);
    userAnswers.add(_answer.a38);
  }
}
