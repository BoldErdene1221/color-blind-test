import 'package:color_blind_test/model/user.dart';
import 'package:color_blind_test/quiz.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatefulWidget {
  UserWidget();

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final name = TextEditingController();
  final _age = TextEditingController();
  bool _nameValidate = false;
  bool _ageValidate = false;

  @override
  void dispose() {
    name.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/images/quiz1-min.png'),
              width: 250,
              height: 250,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Хэрэглэгчийн мэдээлэл бөглөх',
              style: TextStyle(fontSize: 25, color: const Color(0xffFF4400))),
          SizedBox(
            height: 40,
          ),
          Card(
            semanticContainer: true,
            color: const Color.fromRGBO(255, 223, 218, 0.8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        maxLength: 30,
                        controller: name,
                        decoration: InputDecoration(
                          icon: Icon(Icons.favorite),
                          labelText: 'Овог нэр',
                          errorText: _nameValidate ? "Хоосон байна" : null,
                          labelStyle: TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                          helperText: 'Цэвээндорж Энхтунгалаг',
                          suffixIcon: Icon(
                            Icons.check_circle,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        maxLength: 3,
                        controller: _age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          icon: Icon(Icons.star),
                          labelText: 'Нас',
                          errorText: _ageValidate ? "Хоосон байна" : null,
                          labelStyle: TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                          helperText: '20',
                          suffixIcon: Icon(
                            Icons.check_circle,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(0),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              child: Text(
                'Дараагийн',
                style: TextStyle(fontSize: 20.0),
              ),
              color: const Color(0xffFFCCB4),
              textColor: const Color(0xffFF581B),
              onPressed: () {
                setState(() {
                  name.text.isEmpty
                      ? _nameValidate = true
                      : _nameValidate = false;
                  _age.text.isEmpty
                      ? _ageValidate = true
                      : _ageValidate = false;
                  if (!_nameValidate & !_ageValidate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Quiz(),
                          settings: RouteSettings(
                              arguments: User(name.text, int.parse(_age.text),
                                  DateTime.now()))),
                    );
                  }
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: const Color(0xffFF4400)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
