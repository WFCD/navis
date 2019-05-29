import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/enums.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformIcon extends StatelessWidget {
  PlatformIcon({Key key, this.platform}) : super(key: key);

  final Platforms platform;

  String tooltip;
  String assetPath;
  Color platformColor;

  void _setValues() {
    switch (platform) {
      case Platforms.ps4:
        tooltip = ps4;
        assetPath = 'assets/platforms/ps4.svg';
        platformColor = const Color(0xFF003791);
        break;
      case Platforms.xb1:
        tooltip = xb1;
        assetPath = 'assets/platforms/xbox1.svg';
        platformColor = const Color(0xFF107c10);
        break;
      case Platforms.swi:
        tooltip = swi;
        assetPath = 'assets/platforms/switch.svg';
        platformColor = const Color(0xFFe60012);
        break;
      default:
        tooltip = pc;
        assetPath = 'assets/platforms/pc.svg';
        platformColor = const Color(0xFFFACA04);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final storage = BlocProvider.of<StorageBloc>(context);

    void _onPressed(Platforms platforms) {
      storage.dispatch(ChangePlatformEvent(platform));
      state.dispatch(UpdateEvent.update);
      Navigator.of(context).pop();
    }

    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: storage,
      builder: (_, state) {
        _setValues();

        return IconButton(
          tooltip: tooltip,
          icon: SvgPicture.asset(
            assetPath,
            color: state.platform == platform
                ? platformColor
                : Theme.of(context).disabledColor,
            height: 25,
            width: 25,
            semanticsLabel: tooltip,
          ),
          onPressed: () => _onPressed(Platforms.pc),
        );
      },
    );
  }
}
