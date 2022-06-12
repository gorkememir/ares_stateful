import 'package:flutter/material.dart';

class RegRow extends StatefulWidget {
  final String icon;
  late int indicator = 0;
  late int colorCode;
  late Color c = Color(colorCode);

  getIndicator() {
    return indicator;
  }

  setIndicator(int newVal) {
    indicator = newVal;
  }

  RegRow(this.icon, this.colorCode, {Key? key}) : super(key: key);

  @override
  State<RegRow> createState() => _RegRowState();
}

class _RegRowState extends State<RegRow> {

  Future<void> _changeBy(int amount) async {
    if(amount > 0 || widget.indicator > 0) {
      setState(()
      {
        widget.indicator += amount;
      });
    }
    else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Income cannot be less than zero'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: widget.c
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset('''assets/'''+widget.icon+'''.png'''''),
              iconSize: 40,
              onPressed: null,
            ),
            Text(widget.indicator.toString(), textScaleFactor: 2),
            Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/plus.png'),
                  iconSize: 20,
                  onPressed: () => _changeBy(1),
                ),
                IconButton(
                  icon: Image.asset('assets/minus.png'),
                  iconSize: 20,
                  onPressed: () => _changeBy(-1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
