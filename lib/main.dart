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
  ResRow goldRow = ResRow('gold', 0xfff2e7c3, 30);
  ResRow plantRow = ResRow('plant', 0xffe5f6df, 30);
  ResRow heatRow = ResRow('heat', 0xfff5deb3, 30);
  RegRow cardRow = RegRow('card', 0xffadd8e6);
  RegRow steelRow = RegRow('steel', 0xffc4a484);
  RegRow titaniumRow = RegRow('titanium', 0xff949494);
  RegRow trRow = RegRow('crown', 0xffe3e1d7);
  bool prodSelected = false;

  produce() {
    if (prodSelected) {
      setState(() {
        goldRow.increaseBy(goldRow.getIncome() + trRow.getIndicator() + 4);
        plantRow.increaseBy(plantRow.getIncome());
        heatRow.increaseBy(heatRow.getIncome());
      });
    } else {
      goldRow.increaseBy(goldRow.getIncome() + trRow.getIndicator());
      plantRow.increaseBy(plantRow.getIncome());
      heatRow.increaseBy(heatRow.getIncome());
    }
  }

  void _showDialog(BuildContext context) {
    prodSelected = false;
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        produce();
        Navigator.of(context).pop();
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return CheckboxListTile(
                title: Text("I chose production phase"),
                value: prodSelected,
                autofocus: false,
                activeColor: Colors.green,
                checkColor: Colors.white,
                selected: prodSelected,
                onChanged: (bool? value) {
                  setState(() {
                    prodSelected = value!;
                  });
                },
              );
            }),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [cancelButton, okButton],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    trRow.setIndicator(5);
    return MaterialApp(
      home: Scaffold(
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              print("max height?");
              print(constraints.maxHeight);
              return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      goldRow,
                      plantRow,
                      heatRow,
                      Row(
                        children: [
                          steelRow,
                          titaniumRow,
                        ],
                      ),
                      Row(
                        children: [
                          cardRow,
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
                              onPressed: () => _showDialog(context),
                              child: const Text('Produce!'),
                            ),
                          ],
                        ),
                      ), //produceButton
                    ]
                );
          }
        )
      ),
    );
  }
}
