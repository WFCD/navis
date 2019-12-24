import 'package:flutter/material.dart';
import 'package:navis/utils/theme.dart';

class NavisApp extends StatelessWidget {
  const NavisApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cephalon Navis',
      theme: AppTheme.dark,
      color: Colors.blueGrey,
      home: Scaffold(
        body: Container(child: const Text('Test')),
      ),
    );
  }
}
