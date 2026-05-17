import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:navis_codex/src/tables/tables.dart';
import 'package:sentry_drift/sentry_drift.dart';
import 'package:warframestat_client/warframestat_client.dart' as wfcd;

part 'codex.g.dart';

@DriftDatabase(tables: [CodexBuilds, CodexItems, XpItems])
class CodexDatabase extends _$CodexDatabase {
  CodexDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const _name = 'codex';

  @override
  int get schemaVersion => 1;

  Future<String?> get lastBuild async => (await select(codexBuilds).getSingleOrNull())?.buildLabel;

  Future<void> updateBuild(String buildLabel) async {
    final build = CodexBuild(id: 1, buildLabel: buildLabel, timestamp: DateTime.timestamp());
    await codexBuilds.insertOnConflictUpdate(build);
  }

  Future<void> addItems(List<CodexItem> items) async {
    return computeWithDatabase(
      connect: CodexDatabase.new,
      computation: (codex) async {
        await codex.batch((batch) async {
          batch.insertAllOnConflictUpdate(codex.codexItems, items);
        });
      },
    );
  }

  Future<List<CodexItem>> search(String query) async {
    return (codexItems.select(distinct: true)..where((i) => i.name.contains(query))).get();
  }

  Future<List<CodexItem>> fetchMasterable() async {
    return (select(codexItems)..where((i) => i.isMasterable.equals(true))).get();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: _name).interceptWith(SentryQueryInterceptor(databaseName: _name));
  }
}
