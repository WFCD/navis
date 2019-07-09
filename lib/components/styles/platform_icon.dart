import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/utils.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformIcon extends StatelessWidget {
  const PlatformIcon({Key key, this.platform}) : super(key: key);

  final Platforms platform;

  static String _tooltip;
  static String _assetPath;
  static Color _platformColor;

  void _setValues() {
    switch (platform) {
      case Platforms.ps4:
        _tooltip = ps4;
        _assetPath = 'assets/platforms/ps4.svg';
        _platformColor = const Color(0xFF003791);
        break;
      case Platforms.xb1:
        _tooltip = xb1;
        _assetPath = 'assets/platforms/xbox1.svg';
        _platformColor = const Color(0xFF107c10);
        break;
      case Platforms.swi:
        _tooltip = swi;
        _assetPath = 'assets/platforms/switch.svg';
        _platformColor = const Color(0xFFe60012);
        break;
      default:
        _tooltip = pc;
        _assetPath = 'assets/platforms/pc.svg';
        _platformColor = const Color(0xFFFACA04);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final storage = BlocProvider.of<StorageBloc>(context);

    void _onPressed(Platforms platforms) {
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
          icon: SvgPicture.asset(
            _assetPath,
            color: state.platform == platform
                ? _platformColor
                : Theme.of(context).disabledColor,
            height: 25,
            width: 25,
            semanticsLabel: _tooltip,
          ),
          onPressed: () => _onPressed(Platforms.pc),
        );
      },
    );
  }
}
