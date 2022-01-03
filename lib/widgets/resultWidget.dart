import 'package:color_blind_test/model/answer.dart';
import 'package:color_blind_test/model/user.dart';
import 'package:color_blind_test/model/result.dart';
import 'package:color_blind_test/repo/SQLiteDbProvider.dart';
import 'package:color_blind_test/resultMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:intl/intl.dart';

class ResultWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResultWidgetState();
  }
}

class ResultWidgetState extends State<ResultWidget> {
  SQLiteDbProvider provider = SQLiteDbProvider();
  List<User> userList;
  List<Result> resultList;
  List<Answer> answerList;
  int cnt = 0;

  Widget build(BuildContext context) {
    if (userList == null) {
      userList = List<User>();
      resultList = List<Result>();
      answerList = List<Answer>();
      updateListView();
    }
    return getDataGridView();
  }

  ListView getDataGridView() {
    return ListView.builder(
        itemCount: cnt,
        itemBuilder: (BuildContext context, int position) {
          return GestureDetector(
            onTap: () => {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultMain(),
                      settings: RouteSettings(arguments: [
                        userList[position],
                        resultList[position],
                        answerList[position],
                        position
                      ])),
                );
              })
            },
            child: Card(
                color: const Color(0xffFFE68E),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 5.0, right: 15.0, bottom: 5.0),
                    child: Row(
                      children: [
                        new CircularPercentIndicator(
                          radius: 100.0,
                          lineWidth: 15.0,
                          animation: true,
                          percent: resultList[position].corrAnsPer,
                          center: Text(
                              (((resultList[position].corrAns) * 100) / 38)
                                      .ceilToDouble()
                                      .toString() +
                                  "%",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: const Color(0xffFF4400))),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: const Color(0xff00FF19),
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                              Text(
                                'Нэр: ' + userList[position].fullName,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xffFF4400)),
                              ),
                              Text(
                                'Нас: ' + userList[position].age.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xffFF4400)),
                              ),
                              Text(
                                'Өдөр: ' +
                                    DateFormat('yyyy-MM-dd kk:mm')
                                        .format(userList[position].testedDate),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xffFF4400)),
                              ),
                              Text(
                                'Хариу: ' +
                                    resultList[position].corrAns.toString() +
                                    '/38',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xffFF4400)),
                              )
                            ]))
                      ],
                    ))),
          );
        });
  }

  void updateListView() {
    final Future<Database> dbFuture = provider.database;
    dbFuture.then((database) {
      Future<List> listFuture = provider.getAllList();
      listFuture.then((list) {
        setState(() {
          this.userList = list[0];
          this.resultList = list[1];
          this.answerList = list[2];
          this.cnt = list[0].length;
        });
      });
    });
  }
}
