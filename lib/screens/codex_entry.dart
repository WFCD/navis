import 'package:flutter/material.dart';
import 'package:navis/widgets/screen_widgets/items_info/items_info_widgets.dart';
import 'package:navis/widgets/screen_widgets/items_info/warframe_stats.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class CodexEntry extends StatefulWidget {
  const CodexEntry({Key key}) : super(key: key);

  static const route = '/entry';

  @override
  _CodexEntryState createState() => _CodexEntryState();
}

class _CodexEntryState extends State<CodexEntry> {
  ItemObject _item;

  @override
  void didChangeDependencies() {
    _item = ModalRoute.of(context).settings.arguments;

    super.didChangeDependencies();
  }

  Widget _buildWarframeStats(Warframe warframe) {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Codex Entry'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ItemHeader(
                name: _item.name,
                description: _item.description,
                imageName: _item.imageName,
                wikiaUrl: _item.wikiaUrl,
              ),
              if (_item is Warframe) _buildWarframeStats(_item as Warframe)
            ],
          ),
        ),
      ),
    );
  }
}
