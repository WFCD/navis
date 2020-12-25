import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/codex_repository.dart';

class SearchItems extends Usecase<List<Item>, String> {
  const SearchItems(this.codexRepository);

  final CodexRepository codexRepository;

  @override
  Future<Either<Failure, List<Item>>> call(String params) {
    return codexRepository.searchItems(params);
  }
}
