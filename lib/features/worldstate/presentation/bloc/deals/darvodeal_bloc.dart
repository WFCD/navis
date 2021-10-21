import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../data/repositories/worldstate_rep_impl.dart';
import '../../../domain/usecases/get_darvo_deal_info.dart';

part 'darvodeal_event.dart';
part 'darvodeal_state.dart';

class DarvodealBloc extends HydratedBloc<DarvodealEvent, DarvodealState> {
  DarvodealBloc({required this.getDarvoDealInfo}) : super(DarvodealInitial()) {
    on<LoadDarvodeal>(_loadDeal);
  }

  final GetDarvoDealInfo getDarvoDealInfo;

  static const unknownItem = MiscItemModel(
    uniqueName: '',
    name: '',
    type: '',
    category: 'unknown',
    tradable: false,
  );

  Future<void> _loadDeal(
    DarvodealEvent event,
    Emitter<DarvodealState> emit,
  ) async {
    if (event is LoadDarvodeal) {
      emit(DarvodealLoading());

      final request = DealRequest(event.deal.id!, event.deal.item);
      final either = await getDarvoDealInfo(request);

      emit(
        either.match(
          (r) => DarvoDealLoaded(r),
          (l) => const DarvoDealLoaded(unknownItem),
        ),
      );
    }
  }

  @override
  DarvodealState fromJson(Map<String, dynamic> json) {
    final items = toBaseItem(json['items'] as Map<String, dynamic>);

    return DarvoDealLoaded(items);
  }

  @override
  Map<String, dynamic>? toJson(DarvodealState state) {
    if (state is DarvoDealLoaded) {
      return <String, dynamic>{'items': fromBaseItem(state.item)};
    }

    return null;
  }
}
