import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/repository.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformIcon extends StatelessWidget {
  const PlatformIcon({Key key, this.platform}) : super(key: key);

  final Platforms platform;

  static String _tooltip;
  static String _platformIcon;
  static Color _platformColor;

  void _setValues() {
    switch (platform) {
      case Platforms.ps4:
        _tooltip = ps4;
        _platformIcon = 'assets/platforms/playstation.svg';
        _platformColor = const Color(0xFF003791);
        break;
      case Platforms.xb1:
        _tooltip = xb1;
        _platformIcon = 'assets/platforms/xbox.svg';
        _platformColor = const Color(0xFF107C10);
        break;
      case Platforms.swi:
        _tooltip = swi;
        _platformIcon = 'assets/platforms/nintendoswitch.svg';
        _platformColor = const Color(0xFFE60012);
        break;
      default:
        _tooltip = pc;
        _platformIcon = 'assets/platforms/steam.svg';
        _platformColor = const Color(0xFFFACA04);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final persistent = RepositoryProvider.of<Repository>(context).persistent;
    final notification =
        RepositoryProvider.of<Repository>(context).notifications;

    void _onPressed() {
      notification.subscribeToPlatform(
        previousPlatform: persistent.platform,
        currentPlatform: platform,
      );

      persistent.platform = platform;
      state.add(UpdateEvent());
    }

    return WatchBoxBuilder(
      box: persistent.hiveBox,
      watchKeys: const [SettingsKeys.platformKey],
      builder: (BuildContext context, Box box) {
        _setValues();

        return IconButton(
          tooltip: _tooltip,
          splashColor: _platformColor,
          icon: SvgPicture.asset(
            _platformIcon,
            color: (persistent.platform ?? Platforms.pc) == platform
                ? _platformColor
                : Theme.of(context).disabledColor,
            width: 34,
            height: 34,
            semanticsLabel: _tooltip,
          ),
          onPressed: _onPressed,
        );
      },
    );
  }
}
