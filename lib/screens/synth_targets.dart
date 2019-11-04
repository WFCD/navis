import 'package:flutter/material.dart';

class SynthTargets extends StatelessWidget {
  const SynthTargets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: SizedBox.fromSize(
            size: const Size(100, 100),
          ),
        );
      },
    );
  }
}
