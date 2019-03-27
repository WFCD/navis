import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/bloc.dart';

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
      platform.onPressedPlatform(platforms);
      state.update();
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
                      icon: SvgPicture.asset(
                        'assets/platforms/pc.svg',
                        color: storageState.platform == 'pc'
                            ? const Color(0xFFFACA04)
                            : Theme.of(context).disabledColor,
                        height: 25,
                        width: 25,
                      ),
                      onPressed: () => onPressed(Platforms.pc),
                    )),
                    Container(
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/platforms/ps4.svg',
                              color: storageState.platform == 'ps4'
                                  ? const Color(0xFF003791)
                                  : Theme.of(context).disabledColor,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: () => onPressed(Platforms.ps4))),
                    Container(
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/platforms/xbox1.svg',
                              color: storageState.platform == 'xb1'
                                  ? const Color(0xFF107c10)
                                  : Theme.of(context).disabledColor,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: () => onPressed(Platforms.xb1))),
                    Container(
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/platforms/switch.svg',
                              color: storageState.platform == 'swi'
                                  ? const Color(0xFFe60012)
                                  : Theme.of(context).disabledColor,
                              height: 50,
                              width: 50,
                            ),
                            onPressed: () => onPressed(Platforms.swi)))
                  ],
                );
              })),
    ]);
  }
}
