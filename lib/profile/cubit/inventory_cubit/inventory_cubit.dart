import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(InventoryInitial());
}
