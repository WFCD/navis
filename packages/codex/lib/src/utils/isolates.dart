import 'dart:io';
import 'dart:isolate';

import 'package:codex/src/schema/schema.dart';
import 'package:collection/collection.dart';
import 'package:isar_community/isar.dart';
import 'package:warframestat_client/warframestat_client.dart';

typedef IsarProps = ({String dir, String name, List<CollectionSchema<dynamic>> schemas});

Iterable<List<T>> chunk<T>(List<T> list) => list.slices((list.length / (Platform.numberOfProcessors / 2)).floor());

Future<void> processCodexItems(IsarProps conn, List<CodexItem> items) async {
  final slices = chunk(items);

  await Future.wait(
    slices.map(
      (slice) async => Isolate.run(() async {
        final database = await Isar.open(conn.schemas, directory: conn.dir, name: conn.name);

        await database.writeTxn(() async {
          for (final item in slice) {
            final i = await database.codexItems.where().uniqueNameEqualTo(item.uniqueName).findFirst();
            if (i == item) continue;

            await database.codexItems.put(item);
          }
        });
      }),
    ),
  );
}

Future<void> processXpInfo(IsarProps conn, List<XpItem> xpInfo) async {
  final slices = chunk(xpInfo);

  await Future.wait(
    slices.map(
      (slice) async => Isolate.run(() async {
        final database = await Isar.open(conn.schemas, directory: conn.dir, name: conn.name);
        final info = slice.map((i) => MasterableItem(uniqueName: i.uniqueName, xp: i.xp));

        await database.writeTxn(() async {
          for (final masterable in info) {
            final i = await database.masterableItems.where().uniqueNameEqualTo(masterable.uniqueName).findFirst();
            if (i?.xp == masterable.xp) continue;

            masterable.item.value = await database.codexItems
                .where()
                .uniqueNameEqualTo(masterable.uniqueName)
                .findFirst();

            await database.masterableItems.put(masterable);
            await masterable.item.save();

            final profile = await database.playerProfiles.get(profileDefaultId);
            profile!.xpInfo.add(masterable);
            await profile.xpInfo.save();
          }
        });
      }),
    ),
  );
}
