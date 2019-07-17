import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/utils.dart';
import "package:flutter_brand_icons/flutter_brand_icons.dart";

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformIcon extends StatelessWidget {
  const PlatformIcon({Key key, this.platform}) : super(key: key);

  final Platforms platform;

  static String _tooltip;
  static IconData _platformIcon;
  static Color _platformColor;

  void _setValues() {
    switch (platform) {
      case Platforms.ps4:
        _tooltip = ps4;
        _platformIcon = BrandIcons.playstation;
        _platformColor = const Color(0xFF003791);
        break;
      case Platforms.xb1:
        _tooltip = xb1;
        _platformIcon = BrandIcons.xbox;
        _platformColor = const Color(0xFF107C10);
        break;
      case Platforms.swi:
        _tooltip = swi;
        _platformIcon = BrandIcons.nintendoswitch;
        _platformColor = const Color(0xFFE60012);
        break;
      default:
        _tooltip = pc;
        _platformIcon = BrandIcons.steam;
        _platformColor = const Color(0xFFFACA04);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final storage = BlocProvider.of<StorageBloc>(context);

    void _onPressed() {
      storage.dispatch(ChangePlatformEvent(platform));
      state.dispatch(UpdateEvent.update);
      //Navigator.of(context).pop();
    }

    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: storage,
      builder: (_, state) {
        _setValues();
        return IconButton(
          tooltip: _tooltip,
          iconSize: 30,
          icon: Icon(
            _platformIcon,
            color: state.platform == platform
                ? _platformColor
                : Theme.of(context).disabledColor,
          ),
          onPressed: _onPressed,
        );
      },
    );
  }
}
