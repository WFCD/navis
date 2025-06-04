part of 'item_cubit.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {}

final class ItemFetchInProgress extends ItemState {}

final class ItemFetchSuccess extends ItemState {
  const ItemFetchSuccess(this.item);

  final Item item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'ItemFetchSuccess(item: ${item.uniqueName})';
}

final class ItemFetchFailure extends ItemState {
  const ItemFetchFailure({required this.exception, required this.stackTrace});

  final Exception exception;
  final StackTrace stackTrace;

  @override
  List<Object> get props => [exception, stackTrace];
}

final class ItemNotFound extends ItemState {}
