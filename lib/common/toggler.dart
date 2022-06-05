import 'package:flutter/material.dart';

class Toggler extends StatefulWidget {

  @override
  State<Toggler> createState() => _TogglerState();
}

class _TogglerState extends State<Toggler> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ToggleButtons(
          isSelected: isSelected,
          selectedColor: Colors.green.shade900,
          color: Colors.grey,
          fillColor: Colors.green.shade300,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('Earn', style: TextStyle(fontSize: 15)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('Spend', style: TextStyle(fontSize: 15)),
            ),
          ],
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < isSelected.length; index++) {
                if (index == newIndex) {
                  isSelected[index] = true;
                } else {
                  isSelected[index] = false;
                }
              }
            });
          },
        )
    );
  }
}
