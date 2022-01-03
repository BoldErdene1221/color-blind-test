import 'package:color_blind_test/comparePlate.dart';
import 'package:color_blind_test/result.dart';
import 'package:flutter/material.dart';
import '../userinfo.dart';
import '../aboutus.dart';
import './cameras.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/images/home1.png'),
                width: 250,
                height: 250,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Өнгөний харалган байдалын сорил',
              style: TextStyle(fontSize: 22, color: const Color(0xffFF581B))),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              child: Text(
                'Ишихара сорил бөглөх',
                style: TextStyle(fontSize: 20.0),
              ),
              color: const Color(0xffFFCCB4),
              textColor: const Color(0xffFF581B),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfo()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: const Color(0xffFF581B)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              child: Text(
                'Сорилын хариу харах',
                style: TextStyle(fontSize: 20.0),
              ),
              color: const Color(0xffFFB4CC),
              textColor: const Color(0xffFF581B),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Result()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: const Color(0xffFF581B)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              child: Text(
                'Өнгөний харьцуулалт хийх',
                style: TextStyle(fontSize: 20.0),
              ),
              color: const Color(0xffB4CCFF),
              textColor: const Color(0xffFF581B),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComparePlate()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: const Color(0xffFF581B)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              child: Text(
                'Өнгөт харалган хараа',
                style: TextStyle(fontSize: 20.0),
              ),
              color: const Color(0xffB4FFCC),
              textColor: const Color(0xffFF581B),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cameras()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: const Color(0xffFF581B)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              child: Text(
                'Бидний тухай',
                style: TextStyle(fontSize: 20.0),
              ),
              color: const Color(0xff2c2bff),
              textColor: const Color(0xffFF581B),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: const Color(0xffFF581B)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
