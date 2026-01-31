part of 'item_cubit.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {
  @override
  String toString() => 'ItemInitial()';
}

final class ItemFetchInProgress extends ItemState {
  @override
  String toString() => 'ItemFetchInProgress()';
}

final class ItemFetchSuccess extends ItemState {
  const ItemFetchSuccess(this.item);

  final ItemCommon item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'ItemFetchSuccess(item: ${item.uniqueName})';
}

final class ItemFetchFailure extends ItemState {
  const ItemFetchFailure({required this.exception, required this.stackTrace});

  final Object exception;
  final StackTrace stackTrace;

  @override
  List<Object> get props => [exception, stackTrace];
}

final class ItemNotFound extends ItemState {}
