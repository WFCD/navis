import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app_model.dart';
import 'ui/screens/home.dart';

class Navis extends StatelessWidget {
  final NavisModel model;

  Navis({this.model});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(26, 80, 144, .9),
        accentColor: Color.fromRGBO(26, 80, 144, .9),
        scaffoldBackgroundColor: Color.fromRGBO(34, 34, 34, .9),
        splashColor: Color.fromRGBO(26, 80, 144, .9));

    final app = MaterialApp(
      title: 'Navis',
      debugShowCheckedModeBanner: false,
      color: Colors.grey[900],
      theme: theme,
      home: HomeScreen(),
    );

    return ScopedModel<NavisModel>(model: model, child: app);
  }
}
