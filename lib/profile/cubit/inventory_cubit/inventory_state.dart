part of 'inventory_cubit.dart';

sealed class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

final class InventoryInitial extends InventoryState {}
