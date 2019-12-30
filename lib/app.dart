import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/utils/theme.dart';

import 'repository/drop_table_repository.dart';

class NavisApp extends StatefulWidget {
  const NavisApp({Key key}) : super(key: key);

  @override
  _NavisAppState createState() => _NavisAppState();
}

class _NavisAppState extends State<NavisApp> {
  @override
  void initState() {
    super.initState();

    RepositoryProvider.of<DropTableRepository>(context)
        .initDrops()
        .catchError(onError);
  }

  void onError() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Unable to load drop tables'),
      ));
    });
  }

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
