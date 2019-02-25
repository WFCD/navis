import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/bloc.dart';

class PlatformChoice extends StatefulWidget {
  @override
  PlatformChoiceState createState() => PlatformChoiceState();
}

class PlatformChoiceState extends State<PlatformChoice> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final platform = BlocProvider.of<PlatformBloc>(context);

    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Choose your side',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ))
            ],
          )),
      Divider(
        color: Theme.of(context).accentColor,
      ),
      Align(
          alignment: Alignment.topCenter,
          child: BlocProvider<PlatformBloc>(
              bloc: platform,
              child: BlocBuilder<PlatformEvent, PlatformState>(
                  bloc: platform,
                  builder: (context, platformState) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/platforms/pc.svg',
                            color: platformState.platform == 'pc'
                                ? const Color(0xFFFACA04)
                                : Theme.of(context).disabledColor,
                            height: 25,
                            width: 25,
                          ),
                          onPressed: () => platform.onPressed(Platforms.pc,
                              callback: state.update()),
                        )),
                        Container(
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/platforms/ps4.svg',
                                  color: platformState.platform == 'ps4'
                                      ? const Color(0xFF003791)
                                      : Theme.of(context).disabledColor,
                                  height: 25,
                                  width: 25,
                                ),
                                onPressed: () => platform.onPressed(
                                    Platforms.ps4,
                                    callback: state.update()))),
                        Container(
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/platforms/xbox1.svg',
                                  color: platformState.platform == 'xb1'
                                      ? const Color(0xFF107c10)
                                      : Theme.of(context).disabledColor,
                                  height: 25,
                                  width: 25,
                                ),
                                onPressed: () => platform.onPressed(
                                    Platforms.xb1,
                                    callback: state.update()))),
                        Container(
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/platforms/switch.svg',
                                  color: platformState.platform == 'swi'
                                      ? const Color(0xFFe60012)
                                      : Theme.of(context).disabledColor,
                                  height: 50,
                                  width: 50,
                                ),
                                onPressed: () => platform.onPressed(
                                    Platforms.swi,
                                    callback: state.update())))
                      ],
                    );
                  }))),
    ]);
  }
}
