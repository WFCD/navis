import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class GetDarvoDealInfo extends Usecase<BaseItem, DealRequest> {
  const GetDarvoDealInfo(this.repository);

  final WarframestatRepository repository;

  @override
  Future<BaseItem> call(DealRequest request) async {
    return repository.getDealInfo(request.id, request.itemName);
  }
}

class DealRequest {
  const DealRequest(this.id, this.itemName);

  final String id;
  final String itemName;
}
