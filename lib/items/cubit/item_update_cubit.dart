import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:item_repository/items_repository.dart';

part 'item_update_state.dart';

class ItemUpdateCubit extends Cubit<ItemUpdateState> {
  ItemUpdateCubit(this._repository) : super(ItemUpdateInitial());

  final ItemsRepository _repository;

  Future<void> update(String buildLabel, {bool forceUpdate = false}) async {
    emit(const ItemUpdateInProgress(0, 0));
    try {
      await _repository.updateItems(
        buildLabel,
        forceUpdate: forceUpdate,
        onProgress: (progress, total) => emit(ItemUpdateInProgress(progress, total)),
      );
      emit(const ItemUpdateSuccess());
    } on Exception catch (e, st) {
      addError(e, st);
      emit(const ItemUpdateFailure());
    }
  }
}
