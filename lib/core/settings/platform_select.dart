import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/notifiers/user_settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../features/worldstate/presentation/bloc/solsystem_bloc.dart';
import '../../injection_container.dart';
import '../services/notifications.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

const pcColor = Color(0xFFFACA04);
const ps4Color = Color(0xFF003791);
const xb1Color = Color(0xFF107C10);
const swiColor = Color(0xFFE60012);

class PlatformSelect extends StatelessWidget {
  const PlatformSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          PlatformIconButton(
            platform: GamePlatforms.pc,
            platformIcon: SimpleIcons.steam,
            platformName: pc,
            platformColor: pcColor,
          ),
          PlatformIconButton(
            platform: GamePlatforms.ps4,
            platformIcon: SimpleIcons.playstation,
            platformName: ps4,
            platformColor: ps4Color,
          ),
          PlatformIconButton(
            platform: GamePlatforms.xb1,
            platformIcon: SimpleIcons.xbox,
            platformName: xb1,
            platformColor: xb1Color,
          ),
          PlatformIconButton(
            platform: GamePlatforms.swi,
            platformIcon: SimpleIcons.nintendoswitch,
            platformName: swi,
            platformColor: swiColor,
          )
        ],
      ),
    );
  }
}

class PlatformIconButton extends StatelessWidget {
  const PlatformIconButton({
    Key? key,
    required this.platform,
    required this.platformIcon,
    required this.platformColor,
    required this.platformName,
  }) : super(key: key);

  final GamePlatforms platform;
  final IconData platformIcon;
  final Color platformColor;
  final String platformName;

  void _onPressed(BuildContext context) {
    sl<NotificationService>()
        .unsubscribeFromPlatform(sl<UserSettingsNotifier>().platform);

    sl<NotificationService>().subscribeToPlatform(platform);
    sl<UserSettingsNotifier>().setPlatform(platform);

    BlocProvider.of<SolsystemBloc>(context)
        .add(const SyncSystemStatus(forceUpdate: true));
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.shortestSide / 100) * 8.5;
    final currentPlatform = context.watch<UserSettingsNotifier>().platform;

    return IconButton(
      tooltip: platformName,
      splashColor: platformColor,
      icon: Icon(
        platformIcon,
        color: currentPlatform == platform
            ? platformColor
            : Theme.of(context).disabledColor,
        size: size,
        semanticLabel: platformName,
      ),
      onPressed: () => _onPressed(context),
    );
  }
}
