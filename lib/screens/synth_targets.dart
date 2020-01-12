import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/repository/repositories.dart';
import 'package:worldstate_api_model/misc.dart';

class SynthTargetScreen extends StatelessWidget {
  const SynthTargetScreen({Key key}) : super(key: key);

  static const route = '/synthTargets';

  Widget _buildTargets(BuildContext context, SynthTarget target) {
    return Card(
      child: ExpansionTile(
        title: Text(target.name),
        children: target.locations.map<Widget>((l) {
          return ListTile(
            title: Text('${l.planet} (${l.mission})'),
            subtitle:
                Text('${l.type} | ${l.faction} | ${l.spawnRate} spawn rate'),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildList(List<SynthTarget> targets) {
    return ListView.builder(
      itemCount: targets.length,
      itemBuilder: (context, index) => _buildTargets(context, targets[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final warframestate = RepositoryProvider.of<WorldstateRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Synthesis Targets'),
        backgroundColor: const Color(0xFF5F3C0D),
      ),
      body: FutureBuilder<List<SynthTarget>>(
        future: warframestate.getTargets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return _buildList(snapshot.data);

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
