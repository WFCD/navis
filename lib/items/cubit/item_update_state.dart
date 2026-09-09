part of 'item_update_cubit.dart';

sealed class ItemUpdateState extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

final class ItemUpdateInitial extends ItemUpdateState;

final class ItemUpdateInProgress extends ItemUpdateState {
  const new(this.progress, this.total);

  final double progress;
  final int total;
}

final class ItemUpdateSuccess extends ItemUpdateState {
  const new();
}

final class ItemUpdateFailure extends ItemUpdateState {
  const new();
}
