import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ResRow extends StatefulWidget {
  final String icon;
  int income = 0;
  bool status = true;
  ValueNotifier<int> stock = ValueNotifier<int>(0);
  List<bool> isSelected = [true, false];
  late int colorCode;
  late Color c = Color(colorCode);
  late double iconSize;

  increaseBy(int newVal) {
    stock.value += newVal;
  }

  getIncome() {
    return income;
  }

  ResRow(this.icon, this.colorCode, this.iconSize, {Key? key}) : super(key: key);

  @override
  State<ResRow> createState() => _ResRowState();
}

class _ResRowState extends State<ResRow> {
  _incrementIncome() {
    setState(() {
      widget.income++;
    });
  }
  _decrementIncome() {
    if(widget.income > 0) {
      setState(()
      {
        widget.income--;
      });}
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
  _changeStockBy(int amount) {
    if(widget.status) {
      setState(() {
        widget.stock.value += amount;
      });
    }
    else if (widget.stock.value - amount < 0) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Stock cannot be less than zero'),
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
    else {
      setState(() {
        widget.stock.value -= amount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.all(4),
          padding: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              color: widget.c
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: IconButton(
                        icon: Image.asset(
                            '''assets/''' + widget.icon + '''.png'''''),
                        onPressed: null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IconButton(
                                icon: Image.asset('assets/plus.png'),
                                onPressed: _incrementIncome,
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Image.asset('assets/minus.png'),
                                onPressed: _decrementIncome,
                              ),
                            ),
                          ],
                        ),
                  ),
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                        widget.income.toString(), textScaleFactor: 2, maxLines: 1),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset('assets/bronze_cube.png'),
                      iconSize: widget.iconSize,
                      onPressed: () => _changeStockBy(1),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset('assets/silver_cube.png'),
                      iconSize: widget.iconSize,
                      onPressed: () => _changeStockBy(5),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset('assets/gold_cube.png'),
                      iconSize: widget.iconSize,
                      onPressed: () => _changeStockBy(10),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: ValueListenableBuilder(
                      builder: (context, value, _) {
                        return AutoSizeText(
                          '$value', textScaleFactor: 2, maxLines: 1,);
                      },
                      valueListenable: widget.stock,
                    ),
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: FlutterSwitch(
                        activeText: 'E a r n',
                        inactiveText: 'S p e n d',
                        activeColor: Colors.green,
                        inactiveColor: Colors.redAccent,
                        width: 105.0,
                        height: 40.0,
                        valueFontSize: 15.0,
                        toggleSize: 30.0,
                        value: widget.status,
                        borderRadius: 24.0,
                        padding: 5.0,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            widget.status = val;
                          });
                        },
                      ),
                    ),
                  ),
                ]
            );
          }),
          ),
    );
  }
}

