import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/sorties/sorties.dart';
import 'package:navis/widgets/widgets.dart';

class SortieScreen extends StatelessWidget {
  const SortieScreen({Key key}) : super(key: key);

  Widget _header(BuildContext context, DateTime expiry) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        title: const Text(
          'Sortie will reset in: ',
          style: TextStyle(color: Colors.white),
        ),
        trailing: CountdownBox(
          color: Colors.transparent,
          expiry: expiry,
          size: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      condition: (WorldStates previous, WorldStates current) {
        return (previous.worldstate?.sortie?.expiry !=
                current.worldstate?.sortie?.expiry) ??
            false;
      },
      builder: (BuildContext context, WorldStates state) {
        final sortie = state.worldstate?.sortie;

        if (sortie?.variants?.isNotEmpty ?? false) {
          return ListView(children: <Widget>[
            _header(context, sortie.expiry),
            SortieMission(
              variants: sortie.variants,
              faction: sortie.faction,
              boss: sortie.boss,
            )
          ]);
        }

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 16.0),
              Text('Waiting for new sortie...')
            ],
          ),
        );
      },
    );
  }
}
