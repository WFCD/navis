import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;

  BottomNavBar({this.index, this.items, this.onTap});

  final Color _color = Color.fromRGBO(34, 34, 34, .9);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(canvasColor: _color),
        child: BottomNavigationBar(
          iconSize: 25.0,
          items: items,
          currentIndex: index,
          onTap: onTap,
        ));
  }
}
