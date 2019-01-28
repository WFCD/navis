import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/theming.dart';

import 'package:navis/ui/screens/home.dart';
import 'package:navis/ui/screens/settings/settings.dart';

class Navis extends StatelessWidget {
  final theme = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        bloc: theme,
        child: StreamBuilder<ThemeData>(
            initialData: theme.defaultTheme,
            stream: theme.themeDataStream,
            builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
              return MaterialApp(
                title: 'Navis',
                //showPerformanceOverlay: true,
                color: Colors.grey[900],
                theme: snapshot.data,
                home: const HomeScreen(),
                routes: <String, WidgetBuilder>{
                  '/Settings': (_) => const Settings()
                },
              );
            }));
  }
}
