import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/utils/extensions.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_objects.dart';

class CycleWidget extends StatelessWidget {
  const CycleWidget({Key key, this.title, this.cycle}) : super(key: key);

  final String title;
  final CycleObject cycle;

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<PersistentResource>(context);
    final state = toBeginningOfSentenceCase(cycle.state);
    final nextState = toBeginningOfSentenceCase(cycle.nextState);
    final dateFormat = enumToDateformat(storage.dateformat);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 17),
          ),
          const Spacer(),
          Text(
            state,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: cycle.getStateBool ? Colors.yellow[700] : Colors.blue,
            ),
          ),
          const SizedBox(width: 8.0),
          Tooltip(
            message: '$nextState on ${cycle.expiry.format(dateFormat)}',
            showDuration: const Duration(seconds: 2, milliseconds: 500),
            child: CountdownBox(expiry: cycle.expiry),
          ),
        ],
      ),
    );
  }
}
