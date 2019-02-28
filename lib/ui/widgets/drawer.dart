import 'package:flutter/material.dart';
import 'platform_choices.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({this.currentIndex, this.children});

  final List<DrawerItem> children;
  final int currentIndex;

  Widget _buildDrawerItem(DrawerItem item) {
    if (item.children == null || item.children.isEmpty)
      return ListTile(
        leading: item.icon,
        title: Text(item.title),
        onTap: item.callback,
        selected: currentIndex == children.indexOf(item),
      );

    return ExpansionTile(
      leading: item.icon,
      title: Text(item.title),
      children: item.children.map(_buildDrawerItem).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _items = [];
    final List<Widget> _listview = [];

    _listview.addAll(children.map(_buildDrawerItem));

    //_items.insert(0, DrawerHeader(child: Container()));

    _items.add(Expanded(
      child: ListView(children: _listview),
    ));

    _items.add(const PlatformChoice(enableTitle: false));

    _items.add(ListTile(
      leading: const Icon(Icons.settings),
      title: const Text('Settings'),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/Settings');
      },
    ));

    return Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: _items));
  }
}

class DrawerItem {
  const DrawerItem({this.icon, this.title, this.children, this.callback});

  final Icon icon;
  final String title;
  final List<DrawerItem> children;
  final VoidCallback callback;
}
