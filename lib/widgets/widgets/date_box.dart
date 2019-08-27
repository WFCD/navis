import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/utils/factionutils.dart';

import 'package:navis/widgets/widgets/static_box.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry, this.color}) : super(key: key);

  final DateTime expiry;
  final Color color;

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
    return BlocBuilder<StorageBloc, StorageState>(
      bloc: BlocProvider.of<StorageBloc>(context),
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
