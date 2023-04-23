// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:user_settings/user_settings.dart';
import 'package:warframestat_client/warframestat_client.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation Network';
const xb1 = 'Microsoft Xbox';
const swi = 'Nintendo Switch';

const pcColor = Color(0xFFFACA04);
const ps4Color = Color(0xFF003791);
const xb1Color = Color(0xFF107C10);
const swiColor = Color(0xFFE60012);

class PlatformSelect extends AbstractSettingsTile {
  const PlatformSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingRatio = MediaQuery.of(context).size.longestSide / 100;
    final padding = getValueForScreenType(
      context: context,
      mobile: paddingRatio * 2,
      tablet: paddingRatio * 4,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          _PlatformIconButton(
            platform: GamePlatform.pc,
            platformIcon: SimpleIcons.steam,
            platformName: pc,
            platformColor: pcColor,
          ),
          _PlatformIconButton(
            platform: GamePlatform.ps4,
            platformIcon: SimpleIcons.playstation,
            platformName: ps4,
            platformColor: ps4Color,
          ),
          _PlatformIconButton(
            platform: GamePlatform.xb1,
            platformIcon: SimpleIcons.xbox,
            platformName: xb1,
            platformColor: xb1Color,
          ),
          _PlatformIconButton(
            platform: GamePlatform.swi,
            platformIcon: SimpleIcons.nintendoswitch,
            platformName: swi,
            platformColor: swiColor,
          ),
        ],
      ),
    );
  }
}

class _PlatformIconButton extends StatelessWidget {
  const _PlatformIconButton({
    required this.platform,
    required this.platformIcon,
    required this.platformColor,
    required this.platformName,
  });

  final GamePlatform platform;
  final IconData platformIcon;
  final Color platformColor;
  final String platformName;

  void _onPressed(BuildContext context) {
    context
      ..read<NotificationRepository>().unsubscribeFromPlatform(
        context.read<UserSettingsNotifier>().platform,
      )
      ..read<UserSettingsNotifier>().setPlatform(platform)
      ..read<NotificationRepository>().subscribeToPlatform(platform);

    BlocProvider.of<SolsystemCubit>(context).fetchWorldstate(forceUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.shortestSide / 100) * 8;
    final currentPlatform = context
        .select<UserSettingsNotifier, GamePlatform>((value) => value.platform);

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
