import 'package:flutter/widgets.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/app/app.dart';
import 'package:navis/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MatomoTracker.instance.initialize(siteId: 0, url: '');

  await bootstrap(() => const NavisApp());
}
