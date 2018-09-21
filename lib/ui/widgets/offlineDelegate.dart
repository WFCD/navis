import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../app_model.dart';

class Offline extends StatelessWidget {
  final Widget child;
  final NavisModel model;

  Offline({this.child, this.model});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        if (connectivity == ConnectivityResult.none || model.hasError) {
          return Container(
              color: Colors.transparent,
              child: Center(
                  child: Text(
                'Error loading data, device is Offline.',
                style: TextStyle(fontSize: 20.0),
              )));
        } else
          return child;
      },
      builder: (_) => this.child,
      errorBuilder: (_) =>
          Container(color: Colors.white, child: Text('Placeholder')),
    );
  }
}
