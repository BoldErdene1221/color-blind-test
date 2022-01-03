import 'package:color_blind_test/widgets/protCamera.dart';
import 'package:color_blind_test/widgets/deutCamera.dart';
import 'package:color_blind_test/widgets/tritCamera.dart';
import 'package:flutter/material.dart';
import '../model/filters.dart';

class Cameras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Өнгөт харалган хараа',
            style: TextStyle(fontSize: 20, color: const Color(0xffFFFFFF)),
          ),
          backgroundColor: const Color(0xff4644FF), // status bar color
          brightness: Brightness.light,
        ),
        backgroundColor: const Color(0xff8F8EFF),
        body: Padding(
          padding:
              EdgeInsets.only(top: 30.0, bottom: 30.0, left: 20.0, right: 20.0),
          child: Container(
            child: Column(
              children: [
                Expanded(
                    child: SizedBox(
                  child: RaisedButton(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Протанопия камер',
                              style: TextStyle(fontSize: 25.0)),
                        ),
                        Expanded(
                          child: ColorFiltered(
                              colorFilter: ColorFilter.matrix(PROT_MATRIX),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0)),
                                child: Image.asset(
                                  'assets/images/colorful1.jpg',
                                  height: 800,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        )
                      ],
                    ),
                    color: const Color(0xff4644FF),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProtCamera()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                )),
                SizedBox(height: 20.0),
                Expanded(
                    child: SizedBox(
                  child: RaisedButton(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('Дейтеранопия камер',
                                style: TextStyle(fontSize: 25.0))),
                        Expanded(
                          child: ColorFiltered(
                              colorFilter: ColorFilter.matrix(DEUT_MATRIX),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0)),
                                child: Image.asset(
                                  'assets/images/colorful1.jpg',
                                  height: 800,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        )
                      ],
                    ),
                    color: const Color(0xff4644FF),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeutCamera()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                )),
                SizedBox(height: 20.0),
                Expanded(
                    child: SizedBox(
                  child: RaisedButton(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('Тританопия камер',
                                style: TextStyle(fontSize: 25.0))),
                        Expanded(
                            child: ColorFiltered(
                                colorFilter: ColorFilter.matrix(TRIT_MATRIX),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0)),
                                  child: Image.asset(
                                    'assets/images/colorful1.jpg',
                                    height: 800,
                                    fit: BoxFit.cover,
                                  ),
                                )))
                      ],
                    ),
                    color: const Color(0xff4644FF),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TritCamera()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
