part of 'mastery_progress_cubit.dart';

sealed class MasteryProgressState extends Equatable {
  const MasteryProgressState();

  @override
  List<Object> get props => [];
}

final class MasteryProgressInitial extends MasteryProgressState {}

final class MasteryProgressSuccess extends MasteryProgressState {
  const MasteryProgressSuccess(this.items);

  final List<InventoryItemData> items;

  @override
  List<Object> get props => [items];
}

final class MasteryProgressFailure extends MasteryProgressState {}
