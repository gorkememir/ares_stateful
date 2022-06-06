import 'common/resource_row_stateful.dart';
import 'package:flutter/material.dart';
import 'common/reg_row.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  ResRow goldRow = ResRow('gold', 0xfff2e7c3);
  ResRow plantRow = ResRow('plant', 0xffe5f6df);
  ResRow heatRow = ResRow('heat', 0xfff5deb3);
  RegRow cardRow = RegRow('card', 0xffadd8e6);
  RegRow steelRow = RegRow('steel', 0xffc4a484);
  RegRow titaniumRow = RegRow('titanium', 0xff949494);
  RegRow trRow = RegRow('crown', 0xffe3e1d7);
  bool _prodSelected = false;

  produce() {
    setState(() {
      goldRow.increaseBy(goldRow.getIncome() + trRow.getIndicator());
    });
  }

  @override
  Widget build(BuildContext context) {
    trRow.setIndicator(5);
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                goldRow,
                plantRow,
                heatRow,
                Row(
                  children: [
                    cardRow,
                    steelRow,
                  ],
                ),
                Row(
                  children: [
                    titaniumRow,
                    trRow,
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.greenAccent,
                                Colors.lightGreen,
                                Colors.green,
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(30.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return AlertDialog(
                                      title: Text("Did you chose production phase?"),
                                      actions: <Widget>[
                                        CheckboxListTile(
                                          title: Text("Yes"),
                                          value: _prodSelected,
                                          autofocus: false,
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                          selected: _prodSelected,
                                          onChanged: (value){
                                            setState(() {
                                              _prodSelected = value!;
                                            });
                                          },
                                        ),
                                      ]
                                  );
                                },
                              );
                            },
                          );                        },
                        child: const Text('Produce!'),
                      ),
                    ],
                  ),
                ),
              ])
      ),
    );
  }
}