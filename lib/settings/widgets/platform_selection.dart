import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation Network';
const xb1 = 'Microsoft Xbox';
const swi = 'Nintendo Switch';

const pcColor = Color(0xFFFACA04);
const ps4Color = Color(0xFF003791);
const xb1Color = Color(0xFF107C10);
const swiColor = Color(0xFFE60012);

class PlatformSelect extends StatelessWidget {
  const PlatformSelect({Key? key}) : super(key: key);

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
    Provider.of<UserSettingsNotifier>(context, listen: false)
        .setPlatform(platform);

    context
        .read<NotificationRepository>()
        .unsubscribeFromPlatform(context.read<UserSettingsNotifier>().platform);
    context.read<NotificationRepository>().subscribeToPlatform(platform);

    BlocProvider.of<SolsystemCubit>(context).fetchWorldstate(forceUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.shortestSide / 100) * 8;
    final currentPlatform = context
        .select<UserSettingsNotifier, GamePlatforms>((value) => value.platform);

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
