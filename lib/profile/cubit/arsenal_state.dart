part of 'arsenal_cubit.dart';

sealed class ArsenalState extends Equatable {
  const ArsenalState();

  @override
  List<Object> get props => [];
}

final class ArsenalInitial extends ArsenalState {}

final class ArsenalUpdating extends ArsenalState {}

final class ArsenalSuccess extends ArsenalState {
  const ArsenalSuccess(this.items);

  final List<InventoryItemData> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ArsenalSuccess(items: ${items.length})';
}

final class ArsenalFailure extends ArsenalState {}
