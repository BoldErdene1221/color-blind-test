import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'model/filters.dart';

class ComparePlate extends StatefulWidget {
  @override
  ComparePlateState createState() => ComparePlateState();
}

class ComparePlateState extends State<ComparePlate> {
  var _index = 0;
  final GlobalKey _globalKey = GlobalKey();
  final List<List<double>> filters = [
    NORMAL_MATRIX,
    PROT_MATRIX,
    DEUT_MATRIX,
    TRIT_MATRIX,
    MONO_MATRIX
  ];
  final List<String> names = NAMES;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Харьцуулалт хийх",
        ),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: const Color(0xffFFBCA7),
      body: Column(children: [
        SizedBox(height: 20),
        Expanded(
          child: RepaintBoundary(
            key: _globalKey,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width,
                maxHeight: size.width,
              ),
              child: PageView.builder(
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(names[index].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xff464646)))),
                        SizedBox(height: 20),
                        ColorFiltered(
                          colorFilter: ColorFilter.matrix(filters[index]),
                          child: Image.asset(
                            IMAGES[_index].toString(),
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                _index != 0
                    ? SizedBox(
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _index--;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 10),
                              Text('Өмнөх', style: TextStyle(fontSize: 18))
                            ],
                          ),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      )
                    : SizedBox(),
                Expanded(child: SizedBox()),
                _index != (IMAGES.length - 1)
                    ? SizedBox(
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _index++;
                            });
                          },
                          child: Row(
                            children: [
                              Text('Дараах', style: TextStyle(fontSize: 18)),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            )),
        SizedBox(height: 20)
      ]),
    );
  }
}
