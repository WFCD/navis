import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class GetDarvoDealInfo extends Usecase<BaseItem, DealRequest> {
  final WarframestatRepository repository;

  const GetDarvoDealInfo(this.repository);

  @override
  Future<BaseItem> call(DealRequest request) async {
    return repository.getDealInfo(request.id, request.itemNmae);
  }
}

class DealRequest {
  final String id;
  final String itemNmae;

  const DealRequest(this.id, this.itemNmae);
}
