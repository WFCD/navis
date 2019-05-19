import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/enums.dart';
import 'package:navis/utils/factionutils.dart';

import 'static_box.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry}) : super(key: key);

  final DateTime expiry;

  DateFormat enumToDateformat(Formats format) {
    switch (format) {
      case Formats.dd_mm_yy:
        return DateFormat('hh:mm:ss dd/MM/yyyy');
        break;
      case Formats.month_day_year:
        return DateFormat.yMMMMd('en_US').add_jms();
      default:
        return DateFormat.jms().add_yMd();
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);
    return BlocBuilder(
      bloc: storage,
      builder: (context, state) {
        return StaticBox(
            color: Colors.blueAccent[400],
            child: Text(
                '${expiration(expiry, format: enumToDateformat(state.dateformat))}',
                style: const TextStyle(color: Colors.white)));
      },
    );
  }
}
