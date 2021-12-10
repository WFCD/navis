import 'package:navis/codex/bloc/search_state.dart';
import 'package:wfcd_client/entities.dart';

class CodexfilterInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class Codexfiltered extends CodexSuccessfulSearch {
  const Codexfiltered(List<Item> results) : super(results);
}
