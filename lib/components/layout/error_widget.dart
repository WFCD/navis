import 'package:flutter/material.dart';

class NavisErrorWidget extends StatelessWidget {
  const NavisErrorWidget({Key key, this.showStacktrace = true, this.details})
      : super(key: key);

  final bool showStacktrace;
  final FlutterErrorDetails details;

  static const _title = 'An application error has occurred';
  static const _description = 'There was unexpected error in the application';

  Widget _getStackTraceWidget() {
    if (showStacktrace) {
      return SizedBox(
        height: 200.0,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Text(details.exceptionAsString());
          },
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.announcement, color: Colors.red, size: 40),
          Text(_title,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          const Text(_description, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          _getStackTraceWidget()
        ])));
  }
}
