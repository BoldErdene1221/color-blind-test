import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ResultInfoCard extends StatelessWidget {
  ResultInfoCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        print("hello world")
      },
      child: Card(
          color: const Color(0xffFFE68E),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 5,
          child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                child: Column(children: [
                  Text(
                    'Нэр: Цэвээндорж Энхтунгалаг',
                    style:
                        TextStyle(fontSize: 18, color: const Color(0xffFF4400)),
                  ),
                  Text(
                    'Нас: 20',
                    style:
                        TextStyle(fontSize: 18, color: const Color(0xffFF4400)),
                  ),
                  Text(
                    'Өдөр: 2020-02-01 00:00',
                    style:
                        TextStyle(fontSize: 18, color: const Color(0xffFF4400)),
                  ),
                  Text(
                    'Хариу: 25/38',
                    style:
                        TextStyle(fontSize: 18, color: const Color(0xffFF4400)),
                  ),
                  new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width * .4,
                    animation: true,
                    lineHeight: 15.0,
                    animationDuration: 0,
                    percent: 0.5,
                    center: Text(
                        (((0.5) * 100) / 38).ceilToDouble().toString() + "%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: const Color(0xff00FF19),
                  ),
                ])),
          )),
    );
  }
}
