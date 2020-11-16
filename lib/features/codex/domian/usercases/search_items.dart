import 'package:navis/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/codex/domian/repositories/codex_repository.dart';
import 'package:warframestat_api_models/entities.dart';

class SearchItems extends Usecase<List<Item>, String> {
  const SearchItems(this.codexRepository);

  final CodexRepository codexRepository;

  @override
  Future<Either<Failure, List<Item>>> call(String params) {
    return codexRepository.searchItems(params);
  }
}
