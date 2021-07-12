import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../data/repositories/worldstate_rep_impl.dart';
import '../../../domain/usecases/get_darvo_deal_info.dart';

part 'darvodeal_event.dart';
part 'darvodeal_state.dart';

class DarvodealBloc extends HydratedBloc<DarvodealEvent, DarvodealState> {
  DarvodealBloc({required this.getDarvoDealInfo}) : super(DarvodealInitial());

  final GetDarvoDealInfo getDarvoDealInfo;

  static const unknownItem = MiscItemModel(
    uniqueName: '',
    name: '',
    type: '',
    category: 'unknown',
    tradable: false,
  );

  @override
  Stream<DarvodealState> mapEventToState(
    DarvodealEvent event,
  ) async* {
    if (event is LoadDarvodeal) {
      yield DarvodealLoading();

      final request = DealRequest(event.deal.id!, event.deal.item);
      final either = await getDarvoDealInfo(request);

      yield either.match(
        (r) => DarvoDealLoaded(r),
        (l) => const DarvoDealLoaded(unknownItem),
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
