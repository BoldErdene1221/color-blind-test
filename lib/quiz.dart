import 'package:color_blind_test/main.dart';
import 'package:color_blind_test/model/answer.dart';
import 'package:color_blind_test/model/result.dart';
import 'package:color_blind_test/service/AnswerService.dart';
import 'package:color_blind_test/service/ResultService.dart';
import 'package:color_blind_test/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'widgets/AnswerButtonWidget.dart';
import 'model/user.dart';
import 'model/text.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _index = 0;
  var userAnswers = [];
  var _resCnt = 0;
  double _percent = 0.0;
  double _correctScore = 0.0;
  User _user;
  Result _result;
  Answer _answer;
  var _userService = UserService();
  var _resultService = ResultService();
  var _answerService = AnswerService();

  static const questions = AllText.questions;
  static const correctAnswers = AllText.correctAnswer;
  static const protAnswers = AllText.protAns;
  static const deutAnswers = AllText.deutAns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Сорил бөглөх',
          style: TextStyle(
              fontSize: 20,
              color: _index < 38 ? const Color(0xffFF581B) : Colors.white),
        ),
        backgroundColor:
            _index < 38 ? const Color(0xffFFFADE) : Colors.blue[300],
        // status bar color
        brightness: Brightness.light,
        actionsIconTheme: IconThemeData(
            size: 25.0,
            color: _index < 38 ? const Color(0xffFF581B) : Colors.white,
            opacity: 10.0),
        actions: [
          _index < 38
              ? Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: Icon(Icons.info),
                  ))
              : Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.info),
                  )),
        ],
      ),
      bottomNavigationBar: _index < 38
          ? null
          : BottomAppBar(
              child: Image(
                image: AssetImage('assets/images/result1.png'),
              ),
              color: const Color(0xff8F8EFF),
            ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 0.0, right: 5.0, bottom: 20.0),
          child: Align(
            alignment: Alignment.center,
            child: _index < questions.length
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 0,
                          percent: _percent,
                          center: Text((((_index) * 100) / 38)
                                  .ceilToDouble()
                                  .toString() +
                              "%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.lightGreenAccent,
                        ),
                      ),
                      Text('Зураг ' + (_index + 1).toString(),
                          style: TextStyle(
                              fontSize: 25, color: const Color(0xff616161))),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 130,
                          backgroundImage: AssetImage(questions[_index]["image"]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                          semanticContainer: true,
                          color: const Color.fromRGBO(255, 223, 218, 0.8),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 20.0),
                            child: Column(
                              children: [
                                Text('Зураг дээр юу харагдаж байна вэ?',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: const Color(0xff616161))),
                                SizedBox(
                                  height: 20,
                                ),
                                ...(questions[_index]["answer"] as List<String>)
                                    .map((answer) {
                                  return SizedBox(
                                    width: double.maxFinite,
                                    child: AnswerButton(answer, _addIndex),
                                  );
                                }),
                              ],
                            ),
                          ))
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 10.0, bottom: 0.0),
                    child: Column(
                      children: [
                        Text(
                          'Сорилын хариу',
                          style: TextStyle(
                              fontSize: 30, color: Colors.purple[900]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                            semanticContainer: true,
                            color: const Color.fromRGBO(255, 255, 255, 0.9),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0,
                                  top: 10.0,
                                  right: 5.0,
                                  bottom: 10.0),
                              child: Column(
                                children: [
                                  /******************************* CORRECT ANSWER **************************************/
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        bottom: 0.0,
                                        top: 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Зөв хариу',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900])),
                                        Text(_resCnt.toString() + '/38',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900]))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0,
                                        right: 0.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width *
                                          .88,
                                      animation: true,
                                      lineHeight: 15.0,
                                      animationDuration: 0,
                                      percent: _correctScore,
                                      center: Text((((_resCnt) * 100) / 38)
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
                                        left: 5.0,
                                        right: 5.0,
                                        bottom: 0.0,
                                        top: 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Протанопия',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900])),
                                        Text(getProtCnt().toString() + '/36',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900]))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0,
                                        right: 0.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width *
                                          .88,
                                      animation: true,
                                      lineHeight: 15.0,
                                      animationDuration: 0,
                                      percent: getProtScr(),
                                      center: Text((((getProtCnt()) * 100) / 36)
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
                                        left: 5.0,
                                        right: 5.0,
                                        bottom: 0.0,
                                        top: 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Дейтеранопия',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900])),
                                        Text(getDeutCnt().toString() + '/36',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900]))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0,
                                        right: 0.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width *
                                          .88,
                                      animation: true,
                                      lineHeight: 15.0,
                                      animationDuration: 0,
                                      percent: getDeutScr(),
                                      center: Text((((getDeutCnt()) * 100) / 36)
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
                                        left: 5.0,
                                        right: 5.0,
                                        bottom: 0.0,
                                        top: 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Өнгөт харалган байдал',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900])),
                                        Text(getFalseCnt().toString() + '/38',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.purple[900]))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0,
                                        right: 0.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width *
                                          .88,
                                      animation: true,
                                      lineHeight: 15.0,
                                      animationDuration: 0,
                                      percent: getFalseScr(),
                                      center: Text(
                                          (((getFalseCnt()) * 100) / 38)
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
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 30,
                          child: RaisedButton(
                            child: Text('Нүүр хуудас руу буцах',
                                style: TextStyle(fontSize: 20.0)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            },
                            color: const Color(0xffB4CCFF),
                            textColor: Colors.purple[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                            child: Text(
                              'Сорилын дэлэгрэнгүй хариуг " Сориулын хариу харах" цэснээс харна уу!',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )),
          ),
        ),
      ),
      backgroundColor:
          _index < 38 ? const Color(0xffFDD511) : const Color(0xff8F8EFF),
    );
  }

  //хариулт товч дарагдах үед дуудагдах index нэмэх функц
  void _addIndex(String text) {
    userAnswers.add(text);
    if (_index == 37) {
      _resCnt = getResCnt();
      _correctScore = getCorScr();
    }
    var num = (_index * 100) ~/ 38;
    String per;
    if (num.toString().length == 1) {
      per = ('0.0' + num.toString());
    } else {
      per = ('0.' + num.toString());
    }
    _percent = double.parse(per);
    setState(() {
      _index++;
    });
    if (_index == 38) {
      insertData();
    }
  }

  //бүх өгөгдлийг өгөгдлийн сан руу insert хийх функц
  insertData() async {
    _user = ModalRoute.of(context).settings.arguments;
    var userResult = await _userService.saveUser(_user);
    _result = new Result(userResult, getResCnt(), getFalseCnt(), getProtCnt(),
        getDeutCnt(), getCorScr(), getFalseScr(), getProtScr(), getDeutScr());
    await _resultService.saveResult(_result);
    _answer = new Answer(
        userResult,
        userAnswers[0],
        userAnswers[1],
        userAnswers[2],
        userAnswers[3],
        userAnswers[4],
        userAnswers[5],
        userAnswers[6],
        userAnswers[7],
        userAnswers[8],
        userAnswers[9],
        userAnswers[10],
        userAnswers[11],
        userAnswers[12],
        userAnswers[13],
        userAnswers[14],
        userAnswers[15],
        userAnswers[16],
        userAnswers[17],
        userAnswers[18],
        userAnswers[19],
        userAnswers[20],
        userAnswers[21],
        userAnswers[22],
        userAnswers[23],
        userAnswers[24],
        userAnswers[25],
        userAnswers[26],
        userAnswers[27],
        userAnswers[28],
        userAnswers[29],
        userAnswers[30],
        userAnswers[31],
        userAnswers[32],
        userAnswers[33],
        userAnswers[34],
        userAnswers[35],
        userAnswers[36],
        userAnswers[37]);
    await _answerService.saveResult(_answer);
  }

  //хэрэглэгчийн зөв хариултыг тоолох функц
  int getResCnt() {
    int cnt = 0;
    for (int i = 0; i <= 37; i++) {
      if (correctAnswers[i] == userAnswers[i]) {
        cnt++;
      }
    }
    return cnt;
  }

  //хэрэглэгчийн буруу хариултыг тоолох функц
  int getFalseCnt() {
    int cnt = 0;
    for (int i = 0; i <= 37; i++) {
      if (userAnswers[i] != correctAnswers[i]) {
        cnt++;
      }
    }
    return cnt;
  }

  //хэрэглэгчийн protanopia байж болох хариултыг тоолох
  int getProtCnt() {
    int cnt = 0;
    for (int i = 0; i <= 37; i++) {
      if (userAnswers[i] == protAnswers[i]) {
        cnt++;
      }
    }
    return cnt;
  }

  //хэрэглэгчийн deutanopia байж болох хариултыг тоолох
  int getDeutCnt() {
    int cnt = 0;
    for (int i = 0; i <= 37; i++) {
      if (userAnswers[i] == deutAnswers[i]) {
        cnt++;
      }
    }
    return cnt;
  }

  //хэрэглэгчийн буруу хариулсан онооны хувийг тооцох
  double getFalseScr() {
    int cnt = getFalseCnt();
    double scr = 0.0;
    var num = (cnt * 100) ~/ 38;
    String per;
    if (num.toString().length == 3) {
      per = '1.0';
    } else if (num.toString().length == 1) {
      per = ('0.0' + num.toString());
    } else {
      per = ('0.' + num.toString());
    }
    scr = double.parse(per);
    return scr;
  }

  //хэрэглэгчийн зөв хариулсан онооны хувийг тооцох
  double getCorScr() {
    int cnt = getResCnt();
    double scr = 0.0;
    var num = (cnt * 100) ~/ 38;
    String per;
    if (num.toString().length == 3) {
      per = '1.0';
    } else if (num.toString().length == 1) {
      per = ('0.0' + num.toString());
    } else {
      per = ('0.' + num.toString());
    }
    scr = double.parse(per);
    return scr;
  }

  //хэрэглэгчийн protanopia байж болох онооны хувийг тооцох
  double getProtScr() {
    int cnt = getProtCnt();
    double scr = 0.0;
    var num = (cnt * 100) ~/ 36;
    String per;
    if (num.toString().length == 3) {
      per = '1.0';
    } else if (num.toString().length == 1) {
      per = ('0.0' + num.toString());
    } else {
      per = ('0.' + num.toString());
    }
    scr = double.parse(per);
    return scr;
  }

  //хэрэглэгчийн deutanopia байж болох онооны хувийг тооцох
  double getDeutScr() {
    int cnt = getDeutCnt();
    double scr = 0.0;
    var num = (cnt * 100) ~/ 36;
    String per;
    if (num.toString().length == 3) {
      per = '1.0';
    } else if (num.toString().length == 1) {
      per = ('0.0' + num.toString());
    } else {
      per = ('0.' + num.toString());
    }
    scr = double.parse(per);
    return scr;
  }

  //alert dialog буюу тайлбар мэдээлэл харуулах popup widget буцаах функц
  Widget _buildPopupDialog(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: AlertDialog(
        insetPadding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
        title: Text(
          questions[_index]['text'],
          style: TextStyle(fontSize: 18),
        ),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(questions[_index]['desc'], style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColorDark,
            child: const Text('Хаах'),
          ),
        ],
      ),
    );
  }
}
