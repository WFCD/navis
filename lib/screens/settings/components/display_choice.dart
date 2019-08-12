import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/dialogs.dart';
import 'package:navis/components/layout.dart';

class DisplayChoices extends StatelessWidget {
  const DisplayChoices({Key key, this.enableTitle = true}) : super(key: key);

  final bool enableTitle;

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return BlocBuilder<StorageBloc, StorageState>(
      bloc: storage,
      builder: (_, state) {
        // final enabled = state.theme.brightness == Brightness.dark;

        return Container(
            child: Column(children: <Widget>[
          if (enableTitle) const SettingTitle(title: 'Display'),
          ListTile(
            title: const Text('Dateformat'),
            subtitle:
                const Text('Change the format used for timer expiration dates'),
            onTap: () => DateFormatPicker.selectDateformat(context),
          )
        ]));
      },
    );
  }
}
