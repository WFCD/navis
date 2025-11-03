import 'package:codex/codex.dart';
import 'package:codex/src/utils.dart';
import 'package:isar_community/isar.dart';

part 'masterable_item.g.dart';

@Collection(ignore: {'isMissing'})
class MasterableItem {
  MasterableItem({required this.uniqueName, required this.xp});

  @Index(unique: true, replace: true)
  final String uniqueName;
  final int xp;

  final item = IsarLink<CodexItem>();

  Id get isarId => fastHash(uniqueName);
}
