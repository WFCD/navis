import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/cubit/navigation_cubit.dart';
import 'package:navis/home/widgets/nav_bar.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:user_settings/user_settings.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  Future<bool> _willPop() async {
    if (context.read<UserSettingsNotifier>().backKey) {
      if (!scaffold.currentState!.isDrawerOpen) {
        scaffold.currentState!.openDrawer();
        return false;
      } else {
        return true;
      }
    }

    return true;
  }

  //  ListTile(
  //           leading: ,
  //           title: Text(l10n.discordSupportTitle),
  //           onTap: () => discordInvite.launchLink(context),
  //         ),

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        key: scaffold,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => discordInvite.launchLink(context),
              icon: const AppIcon(SimpleIcons.discord),
            ),
            IconButton(
              onPressed: () {
                final deviceType = getDeviceType(MediaQuery.of(context).size);

                if (deviceType != DeviceScreenType.mobile) {
                  showDialog<void>(
                    context: context,
                    builder: (_) => const SettingsDialog(),
                  );
                } else {
                  Navigator.of(context).pushNamed('/settings');
                }
              },
              icon: const Icon(Icons.settings_rounded),
            )
          ],
        ),
        body: BlocBuilder<NavigationCubit, Widget>(
          builder: (BuildContext context, Widget state) {
            return AnimatedSwitcher(
              duration: kAnimationShort,
              child: state,
            );
          },
        ),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
