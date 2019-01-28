import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({this.index, this.items, this.onTap});

  final int index;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF222222)),
        child: BottomNavigationBar(
          iconSize: 25.0,
          items: items,
          currentIndex: index,
          onTap: onTap,
        ));
  }
}
