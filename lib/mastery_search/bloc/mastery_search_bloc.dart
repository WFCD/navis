import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframe_common/warframe_common.dart';

part 'mastery_search_event.dart';
part 'mastery_search_state.dart';

class MasterySearchBloc extends Bloc<MasterySearchEvent, MasterySearchState> {
  MasterySearchBloc(this._repository) : super(MasterySearchEmpty()) {
    on<MasterySearchTextChanged>(_searchMastery, transformer: _waitForUser());
    on<MasteryResultsFiltered>(_filterResults);
  }

  final ProfileRepository _repository;

  List<MasterableItem> _originalResults = [];

  Future<void> _searchMastery(MasterySearchTextChanged event, Emitter<MasterySearchState> emit) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(MasterySearchEmpty());
    } else {
      emit(MasterySearchInProgress());

      try {
        final results = _repository.searchXpInfo(text);
        _originalResults = results;

        emit(MasterySearchSuccessful(results));
      } on Exception catch (e, stack) {
        addError(e, stack);
        emit(MasterySearchFailure(text));
      }
    }
  }

  Future<void> _filterResults(MasteryResultsFiltered event, Emitter<MasterySearchState> emit) async {
    emit(MasterySearchInProgress());

    final type = event.type;
    if (type == null) return emit(MasterySearchSuccessful(_originalResults));

    final results = _originalResults.filterByCategory(type).toList();
    emit(MasterySearchSuccessful(results));
  }

  EventTransformer<T> _waitForUser<T extends MasterySearchTextChanged>() {
    return (event, mapper) {
      return event.debounceTime(const Duration(milliseconds: 500)).distinct().flatMap(mapper);
    };
  }
}
