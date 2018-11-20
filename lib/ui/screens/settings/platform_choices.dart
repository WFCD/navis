import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/platform.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/resources/assets.dart';

class PlatformChoice extends StatefulWidget {
  @override
  PlatformChoiceState createState() => PlatformChoiceState();
}

class PlatformChoiceState extends State<PlatformChoice> {
  @override
  Widget build(BuildContext context) {
    final select = Platforms();
    final state = BlocProvider.of<WorldstateBloc>(context);

    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 8.0),
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
                          icon: Icon(ImageAssets.pc),
                          color: snapshot.data == 'pc'
                              ? Theme.of(context).accentColor
                              : Theme.of(context).disabledColor,
                          onPressed: () => onPressed(select, state, 'pc')),
                    ),
                    Container(
                        child: IconButton(
                            icon: Icon(ImageAssets.ps4),
                            color: snapshot.data == 'ps4'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).disabledColor,
                            onPressed: () => onPressed(select, state, 'ps4'))),
                    Container(
                        child: IconButton(
                            icon: Icon(ImageAssets.xbox),
                            color: snapshot.data == 'xb1'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).disabledColor,
                            onPressed: () => onPressed(select, state, 'xb1'))),
                    Container(
                        child: IconButton(
                            icon: Icon(ImageAssets.nintendo),
                            color: snapshot.data == 'swi'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).disabledColor,
                            onPressed: () => onPressed(select, state, 'swi')))
                  ],
                );
              })),
    ]);
  }
}

void onPressed(
    Platforms platform, WorldstateBloc bloc, String selectPlatform) async {
  platform.selectedPlatform.add((selectPlatform));
  await Future.delayed(Duration(
      milliseconds:
          500)); // waits for for platform to save before updating.. I think
  bloc.update();
}
