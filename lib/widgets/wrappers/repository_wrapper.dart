import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/repository/repositories.dart';
import 'package:navis/resources/storage/cache.dart';
import 'package:navis/resources/storage/persistent.dart';

class RepositoryWrapper extends StatelessWidget {
  const RepositoryWrapper({
    Key key,
    this.persistentResource,
    this.cacheResource,
    this.child,
  }) : super(key: key);

  final PersistentResource persistentResource;
  final CacheResource cacheResource;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider<PersistentResource>.value(value: persistentResource),
        RepositoryProvider<CacheResource>.value(value: cacheResource),
        RepositoryProvider<WorldstateRepository>(
          create: (_) => WorldstateRepository(cacheResource),
        ),
        RepositoryProvider<DropTableRepository>(
          create: (_) => DropTableRepository(),
        )
      ],
      child: child,
    );
  }
}
