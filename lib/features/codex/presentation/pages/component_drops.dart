import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

class ComponentDrops extends StatelessWidget {
  const ComponentDrops({Key? key, required this.drops}) : super(key: key);

  final List<Drop> drops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        cacheExtent: 150,
        itemCount: drops.length,
        itemBuilder: (context, index) {
          final percentage =
              ((drops[index].chance ?? 0) * 100).toStringAsFixed(2);

          return ListTile(
            title: Text(drops[index].location),
            subtitle: Text('$percentage% drop chance'),
            dense: drops.length > 10,
          );
        },
      ),
    );
  }
}
