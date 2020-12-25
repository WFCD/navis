import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';

abstract class CodexRepository {
  const CodexRepository();

  Future<Either<Failure, List<Item>>> searchItems(String text);
}
