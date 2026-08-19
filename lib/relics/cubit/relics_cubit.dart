import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:item_repository/items_repository.dart';
import 'package:warframe_common/warframe_common.dart';

part 'relics_state.dart';

class RelicsCubit extends Cubit<RelicsState> {
  RelicsCubit(this._repository) : super(RelicsInitial());

  final ItemsRepository _repository;

  Future<void> fetchRelics(FissureTier tier) async {
    emit(RelicsLoading());

    try {
      final relics = await _repository.fetchRelics(tier);
      emit(RelicsSuccessful(relics));
    } on Exception catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }
}
