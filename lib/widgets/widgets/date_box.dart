import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';

import 'package:navis/widgets/widgets/static_box.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry, this.color}) : super(key: key);

  final DateTime expiry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageBloc, StorageState>(
      builder: (context, state) {
        final dateFormat = enumToDateformat(state.dateformat);

        return StaticBox(
          color: color ?? Colors.blueAccent[400],
          child: Text(
            '${expiration(expiry, format: dateFormat)}',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
