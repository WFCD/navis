import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navis/models/target.dart';

class SynthTargetScreen extends StatelessWidget {
  const SynthTargetScreen({Key key}) : super(key: key);

  static const route = '/synthTargets';

  Future<List<SynthTarget>> loadTargets() async {
    final data = await rootBundle.loadString('assets/jsons/synthTargets.json');

    final _targets = json.decode(data).cast<Map<String, dynamic>>();

    return _targets.map<SynthTarget>((t) => SynthTarget.fromJson(t)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synthesis Targets'),
        titleSpacing: 0.0,
        backgroundColor: const Color(0xFF5F3C0D),
      ),
      body: FutureBuilder<List<SynthTarget>>(
        future: loadTargets(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SynthTarget>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final target = snapshot.data[index];

                return Card(
                  child: ExpansionTile(
                    title: Text(target.name),
                    children: target.locations.map<Widget>((l) {
                      return ListTile(
                        title: Text('${l.planet} (${l.mission})'),
                        subtitle: Text(
                            '${l.type} | ${l.faction} | ${l.spawnRate} spawn rate'),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
