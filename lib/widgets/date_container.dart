import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/utils/extensions.dart';

import 'colored_container.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key key,
    @required this.expiry,
    this.color,
  })  : assert(expiry != null),
        super(key: key);

  final Color color;
  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final persistent = RepositoryProvider.of<PersistentResource>(context);

    final dateFormat = persistent.dateformat.toDateformat();

    return ColoredContainer(
      color: color ?? theme.primaryColor,
      child: Text(
        '${expiry.format(dateFormat)}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
