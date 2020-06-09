import 'package:flutter/material.dart';
import 'package:navis/widgets/items_info/items_info_widgets.dart';
import 'package:navis/widgets/items_info/warframe_stats.dart';
import 'package:warframestat_api_models/entities.dart';

class CodexEntry extends StatefulWidget {
  const CodexEntry({Key key}) : super(key: key);

  static const route = '/entry';

  @override
  _CodexEntryState createState() => _CodexEntryState();
}

class _CodexEntryState extends State<CodexEntry> {
  BaseItem _item;

  @override
  void didChangeDependencies() {
    _item = ModalRoute.of(context).settings.arguments;

    super.didChangeDependencies();
  }

  Widget _buildWarframeStats(BioWeapon warframe) {
    return WarframeStats(
      health: warframe.health,
      shield: warframe.shield,
      armor: warframe.armor,
      power: warframe.power,
      sprintSpeed: warframe.sprintSpeed,
      passive: warframe.passiveDescription,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_item.name),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ItemHeader(
              description: _item.description,
              imageName: _item.imageName,
              wikiaUrl: _item.wikiaUrl,
            ),
            if (_item is BioWeapon) _buildWarframeStats(_item as BioWeapon)
          ],
        ),
      ),
    );
  }
}
