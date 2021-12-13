import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app/app.dart';
import 'package:navis/app/app_bloc_observer.dart';
import 'package:navis/injection_container.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Firebase.initializeApp();
  await FlutterWebBrowser.warmup();

  final appDir = await getApplicationDocumentsDirectory();

  Hive.init(appDir.path);
  final storage = await HydratedStorage.build(storageDirectory: appDir);

  await init();
  if (sl<UserSettingsNotifier>().isFirstTime) {
    await sl<NotificationRepository>().subscribeToPlatform(GamePlatforms.pc);
  }

  HydratedBlocOverrides.runZoned(
    () => runApp(
      ChangeNotifierProvider(
        create: (_) => UserSettingsNotifier(sl<UserSettings>()),
        child: const NavisApp(),
      ),
    ),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}
