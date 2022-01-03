import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Бидний тухай',
            style: TextStyle(fontSize: 20, color: const Color(0xffFFFFFF)),
          ),
          backgroundColor: const Color(0xff2C2B8C), // status bar color
          brightness: Brightness.light,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Image(
            image: AssetImage('assets/images/aboutus.png'),
          ),
          color: const Color(0xff7473FF),
        ),
        backgroundColor: const Color(0xff7473FF),
        body: Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 0.0, right: 5.0, bottom: 0.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: const Color(0xffD66B76),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Card(
                    semanticContainer: true,
                    color: const Color(0xffD0D2FF),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: [
                          Text('Холбоо барих: ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: const Color(0xff7473FF))),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.alternate_email,
                                  color: const Color(0xffD66B76)),
                              Text('  И-мейл: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF))),
                              Text('ttungaa0518@gmail.com',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF)))
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.phone, color: const Color(0xffD66B76)),
                              Text('  Утас: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF))),
                              Text('96120518',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF)))
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.favorite,
                                  color: const Color(0xffD66B76)),
                              Text('  FB: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF))),
                              Text('Enkh Tungalag',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF)))
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.star, color: const Color(0xffD66B76)),
                              Text('  IG: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF))),
                              Text('Jenna_e',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: const Color(0xff7473FF)))
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
