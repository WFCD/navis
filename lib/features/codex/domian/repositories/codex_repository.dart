import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';

abstract class CodexRepository {
  const CodexRepository();

  Future<Result<List<Item>, Failure>> searchItems(String text);
}
