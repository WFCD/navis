import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class GetDarvoDealInfo extends Usecase<BaseItem, DealRequest> {
  const GetDarvoDealInfo(this.repository);

  final WorldstateRepositoryImpl repository;

  @override
  Future<Either<Failure, BaseItem>> call(DealRequest request) async {
    return repository.getDealInfo(request.id, request.name);
  }
}

class DealRequest {
  const DealRequest(this.id, this.name);

  final String id;
  final String name;
}
