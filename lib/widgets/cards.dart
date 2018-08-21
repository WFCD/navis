import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final Widget child;

  Tiles({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 3.0, right: 3.0, bottom: 2.0),
      child: Card(
        elevation: 8.0,
        color: Color.fromRGBO(187, 187, 197, 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.blue[700], width: 2.5))),
            child: child),
      ),
    );
  }
}
