import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/repositories/worldstate_rep_impl.dart';
import '../repositories/worldstate_repository.dart';

class GetDarvoDealInfo extends Usecase<Item, DealRequest> {
  const GetDarvoDealInfo(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Either<Failure, Item>> call(DealRequest params) async {
    return repository.getDealInfo(params.id, params.name);
  }
}
