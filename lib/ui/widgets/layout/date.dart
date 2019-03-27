import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/ui/widgets/layout.dart';
import 'package:navis/utils/factionutils.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry}) : super(key: key);

  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);
    return BlocBuilder(
      bloc: storage,
      builder: (context, state) {
        return StaticBox(
            color: Colors.blueAccent[400],
            child: Text(
                '${expiration(expiry, format: enumToDateformat(state.dateFormat))}',
                style: const TextStyle(color: Colors.white)));
      },
    );
  }
}
