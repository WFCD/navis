import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/enums.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformChoice extends StatefulWidget {
  const PlatformChoice({Key key}) : super(key: key);

  @override
  PlatformChoiceState createState() => PlatformChoiceState();
}

class PlatformChoiceState extends State<PlatformChoice> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final platform = BlocProvider.of<StorageBloc>(context);

    void onPressed(Platforms platforms) {
      platform.dispatch(ChangePlatformEvent(platforms));
      state.dispatch(UpdateEvent.update);
      Navigator.of(context).pop();
    }

    return Column(children: <Widget>[
      Divider(color: Theme.of(context).accentColor),
      BlocProvider<StorageBloc>(
          bloc: platform,
          child: BlocBuilder<ChangeEvent, StorageState>(
              bloc: platform,
              builder: (context, storageState) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        child: IconButton(
                      tooltip: pc,
                      icon: SvgPicture.asset(
                        'assets/platforms/pc.svg',
                        color: storageState.platform == Platforms.pc
                            ? const Color(0xFFFACA04)
                            : Theme.of(context).disabledColor,
                        height: 25,
                        width: 25,
                        semanticsLabel: 'PC',
                      ),
                      onPressed: () => onPressed(Platforms.pc),
                    )),
                    Container(
                        child: IconButton(
                            tooltip: ps4,
                            icon: SvgPicture.asset(
                              'assets/platforms/ps4.svg',
                              color: storageState.platform == Platforms.ps4
                                  ? const Color(0xFF003791)
                                  : Theme.of(context).disabledColor,
                              height: 25,
                              width: 25,
                              semanticsLabel: 'Sony PlayStation 4',
                            ),
                            onPressed: () => onPressed(Platforms.ps4))),
                    Container(
                        child: IconButton(
                            tooltip: xb1,
                            icon: SvgPicture.asset(
                              'assets/platforms/xbox1.svg',
                              color: storageState.platform == Platforms.xb1
                                  ? const Color(0xFF107c10)
                                  : Theme.of(context).disabledColor,
                              height: 25,
                              width: 25,
                              semanticsLabel: 'Microsoft Xbox One',
                            ),
                            onPressed: () => onPressed(Platforms.xb1))),
                    Container(
                        child: IconButton(
                            tooltip: swi,
                            icon: SvgPicture.asset(
                              'assets/platforms/switch.svg',
                              color: storageState.platform == Platforms.swi
                                  ? const Color(0xFFe60012)
                                  : Theme.of(context).disabledColor,
                              height: 50,
                              width: 50,
                              semanticsLabel: 'Nintendo Switch',
                            ),
                            onPressed: () => onPressed(Platforms.swi)))
                  ],
                );
              })),
    ]);
  }
}
