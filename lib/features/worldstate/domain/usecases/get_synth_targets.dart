import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:worldstate_api_model/misc.dart';

class GetSynthTargets extends Usecase<List<SynthTarget>, NoParama> {
  const GetSynthTargets(this.repository);

  final WarframestatRepository repository;

  @override
  Future<List<SynthTarget>> call(NoParama params) {
    return repository.getSynthTargets();
  }
}
