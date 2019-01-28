import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/platform.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

class PlatformChoice extends StatefulWidget {
  @override
  PlatformChoiceState createState() => PlatformChoiceState();
}

class PlatformChoiceState extends State<PlatformChoice> {
  @override
  Widget build(BuildContext context) {
    final Platforms select = Platforms();
    final WorldstateBloc state = BlocProvider.of<WorldstateBloc>(context);

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
          child: StreamBuilder<String>(
              stream: select.currentPlatform,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/platforms/pc.svg',
                            color: snapshot.data == 'pc'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).disabledColor,
                            height: 25,
                            width: 25,
                          ),
                          onPressed: () => onPressed(select, state, 'pc')),
                    ),
                    Container(
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/platforms/ps4.svg',
                              color: snapshot.data == 'ps4'
                                  ? const Color(0xFF003791)
                                  : Theme.of(context).disabledColor,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: () => onPressed(select, state, 'ps4'))),
                    Container(
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/platforms/xbox1.svg',
                              color: snapshot.data == 'xb1'
                                  ? const Color(0xFF107c10)
                                  : Theme.of(context).disabledColor,
                              height: 25,
                              width: 25,
                            ),
                            onPressed: () => onPressed(select, state, 'xb1'))),
                    Container(
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/platforms/switch.svg',
                              color: snapshot.data == 'swi'
                                  ? const Color(0xFFe60012)
                                  : Theme.of(context).disabledColor,
                              height: 50,
                              width: 50,
                            ),
                            onPressed: () => onPressed(select, state, 'swi')))
                  ],
                );
              })),
    ]);
  }
}

void onPressed(Platforms platform, WorldstateBloc bloc, String selectPlatform) {
  platform.selectedPlatform.add(selectPlatform);
  Future<void>.delayed(
      Duration(milliseconds: 500),
      () => bloc
          .update()); // waits for for platform to save before updating.. I think
}
