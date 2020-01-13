import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/repository/notification_repository.dart';
import 'package:navis/repository/repositories.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/screens/codex_entry.dart';
import 'package:navis/screens/nightwaves.dart';
import 'package:navis/screens/scaffold.dart';
import 'package:navis/screens/settings.dart';
import 'package:navis/screens/syndicate_bounties.dart';
import 'package:navis/screens/synth_targets.dart';
import 'package:navis/screens/trader_inventory.dart';
import 'package:navis/themes.dart';
import 'package:navis/widgets/widgets.dart';

class Navis extends StatefulWidget {
  const Navis();

  @override
  _NavisState createState() => _NavisState();
}

class _NavisState extends State<Navis> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final persistent = RepositoryProvider.of<PersistentResource>(context);

    if (persistent.initialStart) {
      NotificationRepository.subscribeToPlatform(
        currentPlatform: persistent.platform,
      );

      persistent.initialStart = false;
    }

    BlocProvider.of<WorldstateBloc>(context).update();
    RepositoryProvider.of<DropTableRepository>(context).initDrops();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<WorldstateBloc>(context).update();
    }

    super.didChangeAppLifecycleState(state);
  }

  Widget _builder(BuildContext context, Widget widget) {
    ErrorWidget.builder =
        (FlutterErrorDetails error) => NavisErrorWidget(details: error);
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<PersistentResource>(context);

    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: storage.watchBox(key: SettingsKeys.theme),
      builder: (context, box, child) {
        return MaterialApp(
          title: 'Navis',
          color: Colors.grey[900],
          theme: storage.theme,
          darkTheme: AppTheme.theme.dark,
          home: const MainScreen(),
          builder: _builder,
          routes: <String, WidgetBuilder>{
            Settings.route: (_) => const Settings(),
            Nightwaves.route: (_) => const Nightwaves(),
            SyndicateJobs.route: (_) => const SyndicateJobs(),
            SynthTargetScreen.route: (_) => const SynthTargetScreen(),
            CodexEntry.route: (_) => const CodexEntry(),
            VoidTraderInventory.route: (_) => const VoidTraderInventory()
          },
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
