import 'common/resource_row_stateful.dart';
import 'package:flutter/material.dart';
import 'common/reg_row.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  ResRow goldRow = ResRow('gold', 0xfff2e7c3, 30);
  ResRow heatRow = ResRow('heat', 0xfff5deb3, 30);
  ResRow plantRow = ResRow('plant', 0xffe5f6df, 30);
  RegRow cardRow = RegRow('card', 0xffadd8e6);
  RegRow steelRow = RegRow('steel', 0xffc4a484);
  RegRow titaniumRow = RegRow('titanium', 0xff949494);
  RegRow trRow = RegRow('crown', 0xffe3e1d7);
  bool prodSelected = false;
  final moneyPlayer = AudioPlayer();
  final paperPlayer = AudioPlayer();


  produce() async {
    if (prodSelected) {
        goldRow.increaseBy(goldRow.getIncome() + trRow.getIndicator() + 4);
        plantRow.increaseBy(plantRow.getIncome());
        heatRow.increaseBy(heatRow.getIncome());
        if (cardRow.getIndicator() > 0) {
          paperPlayer.play(AssetSource('paper.mp3'));
          await Future.delayed(const Duration(milliseconds: 1500));
        }
    } else {
      goldRow.increaseBy(goldRow.getIncome() + trRow.getIndicator());
      plantRow.increaseBy(plantRow.getIncome());
      heatRow.increaseBy(heatRow.getIncome());
      if (cardRow.getIndicator() > 0) {
        paperPlayer.play(AssetSource('paper.mp3'));
        await Future.delayed(const Duration(milliseconds: 1500));
      }
    }
    moneyPlayer.play(AssetSource('money.mp3'));
  }

  _showDialog(BuildContext context) {
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
    return LayoutBuilder(builder: (context, constraints) {
      var parentHeight = constraints.maxHeight;
      var parentWidth = constraints.maxWidth;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white,
          ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                goldRow,
                heatRow,
                plantRow,
                Expanded(
                  child: Row(
                    children: [
                      steelRow,
                      titaniumRow,
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      cardRow,
                      trRow,
                    ],
                  ),
                ),
                // produce button starts
                Container(
                  width: double.infinity,
                  height: parentHeight/8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Colors.greenAccent,
                        Colors.lightGreen,
                        Colors.green,
                      ],
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.white,
                    ),
                    onPressed: () => _showDialog(context),
                    child: Text('Produce!', textScaleFactor: 2,),
                  ),
                ),
              ]
            )
        ),
      );
    });
  }
}
