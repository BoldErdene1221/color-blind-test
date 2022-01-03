import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String _text;
  final Function _handlerSelect;

  AnswerButton(this._text, this._handlerSelect);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(_text, style: TextStyle(fontSize: 20.0)),
      color: const Color(0xffFFFADE),
      textColor: const Color(0xff616161),
      onPressed: () => _handlerSelect(_text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: const Color(0xffFDD511)),
      ),
    );
  }
}
