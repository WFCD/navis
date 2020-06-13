import 'package:flutter/material.dart';
import 'package:navis/core/local/user_settings.dart';
import 'package:navis/core/widgets/category_title.dart';
import 'package:navis/generated/l10n.dart';
import 'package:provider/provider.dart';

class Behavior extends StatelessWidget {
  const Behavior({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return Container(
      child: Column(children: <Widget>[
        const CategoryTitle(title: 'Behavior'),
        // ListTile(
        //   title: Text(localizations.themeTitle),
        //   subtitle: Text(localizations.themeDescription),
        //   onTap: () => ThemePicker.showThemes(context),
        // ),
        SwitchListTile(
          title: Text(localizations.backOpensDrawerTitle),
          subtitle: Text(localizations.backOpensDrawerDescription),
          value: context.watch<Usersettings>().backkey,
          activeColor: Theme.of(context).accentColor,
          onChanged: (b) => context.read<Usersettings>().backkey = b,
        )
      ]),
    );
  }
}
