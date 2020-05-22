import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/widgets/dialogs.dart';
import 'package:navis/widgets/widgets.dart';

class DisplayChoices extends StatelessWidget {
  const DisplayChoices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return Container(
      child: Column(children: <Widget>[
        const SettingTitle(title: 'Behavior'),
        ListTile(
          title: Text(localizations.themeTitle),
          subtitle: Text(localizations.themeDescription),
          onTap: () => ThemePicker.showThemes(context),
        ),
        WatchBoxBuilder(
          box: RepositoryProvider.of<Repository>(context).persistent.hiveBox,
          watchKeys: const ['backkey'],
          builder: (BuildContext context, Box box) {
            return CheckboxListTile(
              title: Text(localizations.backOpensDrawerTitle),
              subtitle: Text(localizations.backOpensDrawerDescription),
              value: box.get('backkey', defaultValue: false),
              activeColor: Theme.of(context).accentColor,
              onChanged: (b) => box.put('backkey', b),
            );
          },
        )
      ]),
    );
  }
}
