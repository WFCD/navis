import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ExpandedInfo extends StatefulWidget {
  const ExpandedInfo(
      {Key key,
      @required this.header,
      @required this.body,
      this.condition = false})
      : super(key: key);

  final Widget header;
  final Widget body;
  final bool condition;

  @override
  _ExpandedInfoState createState() => _ExpandedInfoState();
}

class _ExpandedInfoState extends State<ExpandedInfo> {
  StreamController<bool> isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = BehaviorSubject<bool>();
  }

  @override
  void dispose() {
    isExpanded?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: isExpanded.stream,
        builder: (_, AsyncSnapshot action) {
          return Column(children: <Widget>[
            widget.header,
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: !action.data
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(),
              secondChild: widget.body,
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        padding: const EdgeInsets.all(8.0),
                        textColor: Theme.of(context).accentColor,
                        onPressed: widget.condition
                            ? null
                            : () => isExpanded.sink.add(!action.data),
                        child: action.data
                            ? const Text('See less')
                            : const Text('See more'))
                  ]),
            )
          ]);
        });
  }
}
