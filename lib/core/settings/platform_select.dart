import 'package:flutter/material.dart';
import 'package:navis/core/local/user_settings.dart';
import 'package:navis/core/network/warframestat_remote.dart';
import 'package:navis/core/services/notifications.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/injection_container.dart';
import 'package:provider/provider.dart';

class PlatformSelect extends StatelessWidget {
  const PlatformSelect({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          PlatformIcon(platform: GamePlatforms.pc),
          PlatformIcon(platform: GamePlatforms.ps4),
          PlatformIcon(platform: GamePlatforms.xb1),
          PlatformIcon(platform: GamePlatforms.swi)
        ],
      ),
    );
  }
}

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformIcon extends StatelessWidget {
  const PlatformIcon({Key key, this.platform}) : super(key: key);

  final GamePlatforms platform;

  static String _tooltip;
  static IconData _platformIcon;
  static Color _platformColor;

  void _setValues() {
    switch (platform) {
      case GamePlatforms.ps4:
        _tooltip = ps4;
        _platformIcon = PlatformIcons.playstation;
        _platformColor = const Color(0xFF003791);
        break;
      case GamePlatforms.xb1:
        _tooltip = xb1;
        _platformIcon = PlatformIcons.xbox;
        _platformColor = const Color(0xFF107C10);
        break;
      case GamePlatforms.swi:
        _tooltip = swi;
        _platformIcon = PlatformIcons.nintendoswitch;
        _platformColor = const Color(0xFFE60012);
        break;
      default:
        _tooltip = pc;
        _platformIcon = PlatformIcons.steam;
        _platformColor = const Color(0xFFFACA04);
    }
  }

  void _onPressed() {
    sl<NotificationService>()
        .unsubscribeFromPlatform(sl<Usersettings>().platform);

    sl<NotificationService>().subscribeToPlatform(platform);

    sl<Usersettings>().platform = platform;
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.shortestSide / 100) * 8.5;
    final currentPlatform = context.watch<Usersettings>().platform;

    _setValues();

    return IconButton(
      tooltip: _tooltip,
      splashColor: _platformColor,
      icon: Icon(
        _platformIcon,
        color: (currentPlatform ?? GamePlatforms.pc) == platform
            ? _platformColor
            : Theme.of(context).disabledColor,
        size: size,
        semanticLabel: _tooltip,
      ),
      onPressed: _onPressed,
    );
  }
}
