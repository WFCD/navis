import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model.dart';

class NavisError extends StatelessWidget {
  final Function() onPressed;

  NavisError({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (BuildContext context, Widget child, NavisModel model) {
        return Center(
          child: AlertDialog(
            content: Text(
                'Sorry there was an error loading the content, make sure you are connected to the internet before retrying'),
            actions: <Widget>[
              FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: onPressed,
                  child: Text('Retry', style: TextStyle(color: Colors.white)))
            ],
          ),
        );
      },
    );
  }
}
