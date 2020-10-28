import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  TextEditingController _heightctrl = new TextEditingController();
  TextEditingController _weightctrl = new TextEditingController();

  double lbmBoer = 0, lbmJames = 0, lbmHume = 0, lbmChild = 0;
  double percentBoer = 0, percentJames = 0, percentHume = 0, percentChild = 0;
  double fatBoer = 0, fatJames = 0, fatHume = 0, fatChild = 0;
  String lbm = "";
  int gender = 0, age = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Lean Body Mass Calculator'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(60, 0, 60, 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Gender  ',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    Radio(
                      value: 1,
                      groupValue: gender,
                      onChanged: _handleChangeGender,
                    ),
                    Text('Male', style: new TextStyle(fontSize: 20.0)),
                    Radio(
                      value: 2,
                      groupValue: gender,
                      onChanged: _handleChangeGender,
                    ),
                    Text('Female', style: new TextStyle(fontSize: 20.0)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Are you 14 or younger?',
                        style: new TextStyle(fontSize: 20.0)),
                    Radio(
                      value: 3,
                      groupValue: age,
                      onChanged: _handleChangeAge,
                    ),
                    Text('Yes', style: new TextStyle(fontSize: 20.0)),
                    Radio(
                      value: 4,
                      groupValue: age,
                      onChanged: _handleChangeAge,
                    ),
                    Text('No', style: new TextStyle(fontSize: 20.0)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextField(
                    controller: _heightctrl,
                    keyboardType: TextInputType.numberWithOptions(),
                    style: new TextStyle(
                        fontSize: 22.0,
                        color: const Color(0xFFE1F5FE),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.white),
                        hintText: "Your Height (CM)",
                        fillColor: Colors.white10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    style: new TextStyle(
                        fontSize: 22.0,
                        color: const Color(0xFFE1F5FE),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                    controller: _weightctrl,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.white),
                        hintText: "Your Weight (KG)",
                        fillColor: Colors.white10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                  child: new MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    elevation: 5.0,
                    minWidth: 200.0,
                    height: 50,
                    color: Colors.greenAccent,
                    child: new Text('CALCULATE LMS',
                        style:
                            new TextStyle(fontSize: 16.0, color: Colors.black)),
                    onPressed: _leanBodyMassOperation,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(1.5),
                        child: Table(
                          border: TableBorder.all(
                              color: Colors.greenAccent,
                              style: BorderStyle.solid,
                              width: 2.0),
                          children: [
                            TableRow(children: [
                              Text(
                                "Formula",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Lean Body Mass (KG)",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Body Fat",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Boer",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${lbmBoer.toStringAsFixed(1) + "(" + percentBoer.toStringAsFixed(0) + "%" + ")"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${fatBoer.toStringAsFixed(0) + "%"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "James",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${lbmJames.toStringAsFixed(1) + "(" + percentJames.toStringAsFixed(0) + "%" + ")"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${fatJames.toStringAsFixed(0) + "%"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Hume",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${lbmHume.toStringAsFixed(1) + "(" + percentHume.toStringAsFixed(0) + "%" + ")"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${fatHume.toStringAsFixed(0) + "%"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Children",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.6,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${lbmChild.toStringAsFixed(1) + "(" + percentChild.toStringAsFixed(0) + "%" + ")"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${fatChild.toStringAsFixed(0) + "%"}",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleChangeGender(int value) {
    setState(() {
      gender = value;
    });
  }

  void _handleChangeAge(int value) {
    setState(() {
      age = value;
    });
  }

  void _leanBodyMassOperation() {
    double h = double.parse(_heightctrl.text);
    double w = double.parse(_weightctrl.text);

    setState(() {
      if (gender == 1 && age == 4) {
        lbmBoer = 0.407 * w + 0.267 * h - 19.2;
        lbmJames = 1.1 * w - (128 * (pow((w / h), 2)));
        lbmHume = 0.32810 * w + 0.33929 * h - 29.5336;

        print(lbmBoer);
        print(lbmJames);
        print(lbmHume);

        fatBoer = 100 - (lbmBoer / w) * 100;
        fatJames = 100 - (lbmJames / w) * 100;
        fatHume = 100 - (lbmHume / w) * 100;

        print(fatBoer);
        print(fatJames);
        print(fatHume);

        percentBoer = 100 - fatBoer;
        percentJames = 100 - fatJames;
        percentHume = 100 - fatHume;

        print(percentBoer);
        print(percentJames);
        print(percentHume);
      } else if (gender == 2 && age == 4) {
        lbmBoer = 0.252 * w + 0.473 * h - 48.3;
        lbmJames = 1.07 * w - (148 * (pow((w / h), 2)));
        lbmHume = 0.29569 * w + 0.41813 * h - 43.2933;

        print(lbmBoer);
        print(lbmJames);
        print(lbmHume);

        fatBoer = 100 - (lbmBoer / w) * 100;
        fatJames = 100 - (lbmJames / w) * 100;
        fatHume = 100 - (lbmHume / w) * 100;

        print(fatBoer);
        print(fatJames);
        print(fatHume);

        percentBoer = 100 - fatBoer;
        percentJames = 100 - fatJames;
        percentHume = 100 - fatHume;

        print(percentBoer);
        print(percentJames);
        print(percentHume);
      } else {
        double ecv = 0.0215 * pow(w, 0.6469) * pow(h, 0.7236);
        lbmChild = 3.8 * ecv;
        fatChild = 100 - (lbmChild / w) * 100;
        percentChild = 100 - fatChild;

        print(lbmChild);
        print(percentChild);
        print(fatChild);
      }
    });
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
