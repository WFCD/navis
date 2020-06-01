import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:warframestat_api_models/entities.dart';

class GetDarvoDealInfo extends Usecase<BaseItem, DealRequest> {
  const GetDarvoDealInfo(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Either<Failure, BaseItem>> call(DealRequest request) async {
    return repository.getDealInfo(request.id, request.name);
  }
}
