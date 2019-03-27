import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/ui/screens/home.dart';
import 'package:navis/ui/screens/settings/settings.dart';

class Navis extends StatefulWidget {
  @override
  NavisState createState() => NavisState();
}

class NavisState extends State<Navis> {
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _theme = ThemeBloc();
  final _storage = StorageBloc();
  final _worldstate = WorldstateBloc.initialize();

  @override
  void initState() {
    super.initState();
    _theme.dispatch(ThemeStart());
    _storage.dispatch(RestoreEvent());
    _worldstate.dispatch(UpdateEvent.update);

    _init();

    // _firebaseMessaging.configure();
  }

  Future<void> _init() async {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            startOnBoot: true,
            stopOnTerminate: false,
            enableHeadless: true), () {
      _worldstate.update();
      BackgroundFetch.finish();
    });
  }

  @override
  void dispose() {
    _theme.dispose();
    _storage.dispose();
    _worldstate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        bloc: _theme,
        child: BlocProvider<StorageBloc>(
            bloc: _storage,
            child: BlocProvider<WorldstateBloc>(
              bloc: _worldstate,
              child: BlocBuilder(
                  bloc: _theme,
                  builder: (_, ThemeState themeState) {
                    return MaterialApp(
                      title: 'Navis',
                      color: Colors.grey[900],
                      theme: themeState.theme,
                      home: const HomeScreen(),
                      routes: <String, WidgetBuilder>{
                        '/Settings': (_) => const Settings()
                      },
                    );
                  }),
            )));
  }
}
