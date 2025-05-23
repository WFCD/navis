import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/profile/utils/extensions.dart';

part 'mastery_progress_state.dart';

class MasteryProgressCubit extends HydratedCubit<MasteryProgressState> {
  MasteryProgressCubit(this.inventoria) : super(MasteryProgressInitial());

  final Inventoria inventoria;

  Future<void> fetchInProgress() async {
    try {
      final profile = await inventoria.fetchProfile();
      if (profile == null) return;

      final inventory =
          (await inventoria.fetchInventory()).where((i) => i.rank < i.maxRank && !i.isMissing).toList()
            ..sort((a, b) => a.xp.compareTo(b.xp));

      if (isClosed) return;
      emit(MasteryProgressSuccess(List.unmodifiable(inventory)));
    } on Exception {
      if (isClosed) return;
      emit(MasteryProgressFailure());
    }
  }

  @override
  MasteryProgressState? fromJson(Map<String, dynamic> json) {
    final progressList = json['items'] as List;
    final inProgess = List<Map<String, dynamic>>.from(progressList).map(InventoryItemData.fromJson);

    return MasteryProgressSuccess(inProgess.toList());
  }

  @override
  Map<String, dynamic>? toJson(MasteryProgressState state) {
    if (state is! MasteryProgressSuccess) return null;

    return {'items': state.items.map((p) => p.toJson()).toList()};
  }
}
