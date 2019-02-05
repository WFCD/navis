import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/platform.dart';
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
                              onPressed: () =>
                                  onPressed(platform, state, 'pc')),
                        ),
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
                                onPressed: () =>
                                    onPressed(platform, state, 'ps4'))),
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
                                onPressed: () =>
                                    onPressed(platform, state, 'xb1'))),
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
                                onPressed: () =>
                                    onPressed(platform, state, 'swi')))
                      ],
                    );
                  }))),
    ]);
  }
}

void onPressed(
    PlatformBloc platform, WorldstateBloc bloc, String selectPlatform) {
  platform.dispatch(PlatformChange(platform: selectPlatform));
  Future<void>.delayed(
      const Duration(milliseconds: 500),
      () => bloc
          .update()); // waits for for platform to save before updating.. I think
}
