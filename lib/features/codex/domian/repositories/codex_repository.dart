import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:warframestat_api_models/entities.dart';

abstract class CodexRepository {
  const CodexRepository();

  Future<Either<Failure, List<Item>>> searchItems(String text);
}
