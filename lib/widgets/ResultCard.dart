import 'package:flutter/material.dart';
import '../model/text.dart';

// ignore: must_be_immutable
class ResultCard extends StatelessWidget {
  var _currentIndex;
  var _userAnswers = [];
  static const answers = AllText.questions;
  static const correctAnswers = AllText.correctAnswer;

  ResultCard(this._currentIndex, this._userAnswers);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      color: const Color.fromRGBO(255, 255, 255, 0.9),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.only(
              left: 2.0, top: 2.0, right: 2.0, bottom: 0.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                        flex: 0,
                        child: Text(
                          'Зураг ' + (_currentIndex + 1).toString(),
                          style: TextStyle(
                              fontSize: 18, color: Colors.purple[900]),
                        )),
                    Expanded(
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage(answers[_currentIndex]["image"]),
                      ),
                    ),
                    correctAnswers[_currentIndex] == _userAnswers[_currentIndex]
                        ? Expanded(
                            child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 35,
                          ))
                        : Expanded(
                            child: Icon(
                            Icons.dangerous,
                            color: Colors.red,
                            size: 35,
                          )),
                  ],
                )),
            SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Хариу: ' + _userAnswers[_currentIndex].toString(),
                          style: TextStyle(
                              fontSize: 18, color: Colors.purple[900]),
                        )),
                    Expanded(
                        flex: 4,
                        child: Text(
                          'Тайлбар: ' +
                              answers[_currentIndex]["desc"].toString(),
                          style: TextStyle(
                              fontSize: 16, color: Colors.purple[900]),
                        ))
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
