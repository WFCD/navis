part of 'item_cubit.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {}

final class ItemFetchSucess extends ItemState {
  const ItemFetchSucess(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

final class ItemFetchFailure extends ItemState {
  const ItemFetchFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class NoItemFound extends ItemState {
  const NoItemFound();
}
