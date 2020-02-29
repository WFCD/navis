import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:worldstate_api_model/misc.dart';

class GetSynthTargets extends Usecase<List<SynthTarget>, NoParama> {
  final WarframestatRepository repository;

  const GetSynthTargets(this.repository);

  @override
  Future<List<SynthTarget>> call(NoParama params) {
    return repository.getSynthTargets();
  }
}
