import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/theming.dart';

import 'ui/screens/home.dart';

class Navis extends StatelessWidget {
  final theme = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        bloc: theme,
        child: StreamBuilder<ThemeType>(
            initialData: theme.defaultTheme,
            stream: theme.themeDataStream,
            builder: (BuildContext context, AsyncSnapshot<ThemeType> snapshot) {
              return MaterialApp(
                title: 'Navis',
                color: Colors.grey[900],
                theme: snapshot.data.theme,
                home: HomeScreen(),
              );
            }));
  }
}
